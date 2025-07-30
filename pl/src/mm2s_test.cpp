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
#include <fstream>

typedef float data_t;
typedef hls::axis<data_t, 0, 0, 0> axis_t;
 
 // DUT prototype (from mm2s.cpp / mm2s.h)
 extern "C" void mm2s_pl(float*            mem,
                      hls::stream<axis_t>& s, int size);
 
 constexpr int SIZE = 8;           // test vector length
 constexpr unsigned int SEED = 7;   // reproducible pseudo-random data
 
 // AXI-4-Stream word helper for readability
// using axis32 = ap_axis<32,0,0,0>;

 
 int main()
 {
     /* --------------------------------------------------------------------
      * 1. Prepare input “DDR” array with a known pattern
      * ------------------------------------------------------------------*/
     data_t mem[SIZE];
 
    //  std::mt19937               rng(SEED);
    //  std::uniform_int_distribution<int32_t> dist(0, 0x7FFFFFFF);
 

    std::ifstream fin("/home/synthara/VersalPrjs/LDRD/rtda_demo/aieml/data/input_data.txt");
    if (!fin.is_open()) {
        std::cerr << "ERROR: Cannot open input_data.txt" << std::endl;
        return 1;
    }

    for (int i = 0; i < SIZE; ++i){
        data_t val;
        fin >> val;
        // mem[i] = dist(rng);
        mem[i] = val;
    }
 
     /* --------------------------------------------------------------------
      * 2. Call the DUT
      * ------------------------------------------------------------------*/
     hls::stream<axis_t> s_out;
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
         axis_t val = s_out.read();
         std::cout<<val.data<<std::endl;
 
         if (val.data != mem[i]) {
             std::cerr << "Mismatch @ " << i << std::endl;
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