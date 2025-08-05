/*********************************************************************
 * Testbench for s2mm_pl()                                           *
 * - Streams SIZE 32-bit words from AXI-Stream -> DDR-style array    *
 *********************************************************************/

 #include <iostream>
 #include <iomanip>
 #include <fstream>
 #include <vector>
 #include <hls_stream.h>
 #include <ap_axi_sdata.h>
#include "../../common/data_paths.h"
 
 typedef float data_t;
 typedef hls::axis<data_t, 0, 0, 0> axis_t;
 
 // DUT prototype
 extern "C" void s2mm_pl(hls::stream<axis_t>& s, float* mem, int size);
 
 constexpr int SIZE = 128; // test vector length
 
 int main() {
     /* --------------------------------------------------------------------
      * 1. Prepare input stream with a known pattern from a file
      * ------------------------------------------------------------------*/
     hls::stream<axis_t> s_in;
     std::vector<data_t> golden_data;
     golden_data.reserve(SIZE);
 
    std::ifstream fin(std::string(DATA_DIR) + "/output_data_ref.txt");
     if (!fin.is_open()) {
         std::cerr << "ERROR: Cannot open input file leakyrelu_output_ref.txt" << std::endl;
         return 1;
     }
 
     for (int i = 0; i < SIZE; ++i) {
         data_t val;
         fin >> val;
         golden_data.push_back(val); // Store for later comparison
 
         axis_t temp;
         temp.data = val;
         temp.keep = -1; // Keep all bytes
         temp.last = (i == SIZE - 1); // Set TLAST on the final word
         s_in.write(temp);
     }
     fin.close();
 
     /* --------------------------------------------------------------------
      * 2. Call the DUT
      * ------------------------------------------------------------------*/
     data_t mem_out[SIZE]; // This array represents our DDR memory
     s2mm_pl(s_in, mem_out, SIZE);
 
     /* --------------------------------------------------------------------
      * 3. Check the memory array for results
      * ------------------------------------------------------------------*/
     bool pass = true;
     for (int i = 0; i < SIZE; ++i) {
         if (mem_out[i] != golden_data[i]) {
             std::cerr << "Mismatch @ index " << i << ": "
                       << "Expected " << golden_data[i]
                       << ", Got " << mem_out[i] << std::endl;
             pass = false;
         }
     }
 
     /* --------------------------------------------------------------------
      * 4. Report
      * ------------------------------------------------------------------*/
     if (pass)
         std::cout << "Test PASSED – all " << SIZE << " words written to memory correctly." << std::endl;
     else
         std::cout << "Test FAILED." << std::endl;
 
     return pass ? 0 : 1;
 }
 