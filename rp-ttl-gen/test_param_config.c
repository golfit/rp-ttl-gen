//Start from http://antonpotocnik.com/?p=489265, stopwatch.c, and hack test parameters and waveform.
//T. Golfinopoulos, 19 Jan. 2018

#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <stdlib.h>
 
int main(int argc, char **argv)
{
  int fd;
  //float wait_time;
  //uint32_t count;
  uint32_t num_cycles_addr=0x4120000;
  uint32_t num_reps_addr=0x4121000;
  uint32_t init_val_addr=0x4122000;
  uint32_t waveform_addr=0x42000000; //In the initial configuration of this module, this is the offset for the waveform memory address
  //void *cfg;
  
  int waveform_val[]={1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,
                    65536,131072,262144,524288,1048576,2097152,4194304,8388608,
                    16777216,33554432,67108864,134217728};
  int num_cycles_val=sizeof(waveform);
  int num_reps_val=10;
  int init_val_val=0;
  
  void *num_cycles, *num_reps, *init_val, *waveform; //Pointers to memory locations where values are expected by FPGA
  
  char *name = "/dev/mem";
  //const int freq = 124998750; // Hz
 
  //if (argc == 2) wait_time = atof(argv[1]);
  //else wait_time = 1.0;
 
  if((fd = open(name, O_RDWR)) < 0) {
    perror("open");
    return 1;
  }
  //cfg = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
  //           PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0x42000000);
  num_cycles = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, num_cycles_addr);

  num_reps = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, num_reps_addr);
             
  init_val = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, init_val_addr);
             
  waveform = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, waveform_addr);
 
  //*((uint32_t *)(cfg + 0)) = 2;   // clear timer
  //*((uint32_t *)(cfg + 0)) = 1;   // start timer

  //Assign parameter values to correct locations in memory
  *((uint32_t *)(num_cycles + 0)) = num_cycles_val;
  *((uint32_t *)(num_reps + 0)) = num_reps_val;  
  *((uint32_t *)(init_val + 0)) = init_val;  
  
  //Copy waveform values into appropriate memory locations, one at a time
  for(i=0; i<num_cycles_val; i++){
    *((uint32_t *)(waveform + i)) = waveform_val[i];
  }
  
  //sleep(wait_time);   // wait for [wait_time] seconds
 
  //*((uint32_t *)(cfg + 0)) = 0;   // stop timer
 
  //count = *((uint32_t *)(cfg + 8)); // get binary counter output
 
  //printf("Clock count: %5d, calculated time: %5f s\n", 
  //       count, (double)count/freq);
 
  //munmap(cfg, sysconf(_SC_PAGESIZE));
  sleep(100); //Wait for a while to check memory
  
  return 0;
}
