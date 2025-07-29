/*********************************************************************
 *  Testbench for mm2s()                                              *
 *  - Streams SIZE 32-bit words from DDR-style array → AXI-Stream     *
 *********************************************************************/

 #include <iostream>
 #include <iomanip>
 #include <random>
 #include <ap_int.h>
 #include <hls_stream.h>
 #include <ap_axi_sdata.h>
 
 // DUT prototype (from mm2s.cpp / mm2s.h)
 extern "C" void mm2s_pl(ap_int<32>*            mem,
                      hls::stream<ap_axis<32,0,0,0>>& s, int size);
 
 constexpr int SIZE = 8;           // test vector length
 constexpr unsigned int SEED = 7;   // reproducible pseudo-random data
 
 // AXI-4-Stream word helper for readability
 using axis32 = ap_axis<32,0,0,0>;
 
 int main()
 {
     /* --------------------------------------------------------------------
      * 1. Prepare input “DDR” array with a known pattern
      * ------------------------------------------------------------------*/
     ap_int<32> mem[SIZE];
 
     std::mt19937               rng(SEED);
     std::uniform_int_distribution<int32_t> dist(0, 0x7FFFFFFF);
 
     for (int i = 0; i < SIZE; ++i)
         mem[i] = dist(rng);
 
     /* --------------------------------------------------------------------
      * 2. Call the DUT
      * ------------------------------------------------------------------*/
     hls::stream<axis32> s_out;
     mm2s_pl(mem, s_out, SIZE);
 
     /* --------------------------------------------------------------------
      * 3. Drain the stream and check results
      * ------------------------------------------------------------------*/
     bool pass = true;
 
     for (int i = 0; i < SIZE; ++i) {
         if (s_out.empty()) {
             std::cerr << "ERROR: stream underrun at word " << i << std::endl;
             pass = false;
             break;
         }
         axis32 val = s_out.read();
 
         if (val.data != mem[i]) {
             std::cerr << std::hex << std::setfill('0')
                       << "Mismatch @ " << i
                       << "  expected 0x" << std::setw(8) << mem[i].to_uint()
                       << "  got 0x"      << std::setw(8) << val.data.to_uint()
                       << std::dec << std::endl;
             pass = false;
         }
     }
 
     if (!s_out.empty()) {
         std::cerr << "ERROR: stream contains extra data!" << std::endl;
         pass = false;
     }
 
     /* --------------------------------------------------------------------
      * 4. Report
      * ------------------------------------------------------------------*/
     if (pass)
         std::cout << "Test PASSED – all " << SIZE << " words correct." << std::endl;
     else
         std::cout << "Test FAILED." << std::endl;
 
     return pass ? 0 : 1;
 }