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
  uint32_t num_cycles_addr=0x41200000;
  uint32_t num_reps_addr=0x41210000;
  uint32_t init_val_addr=0x41220000;
  uint32_t waveform_addr=0x00000000; //In the initial configuration of this module, this is the offset for the waveform memory address
  //void *cfg;
  
  uint32_t waveform_val[]={1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768,
                    65536,131072,262144,524288,1048576,2097152,4194304,8388608,
                    16777216,33554432,67108864,134217728};
  uint32_t num_cycles_val=sizeof(waveform_val)/sizeof(waveform_val[0]); //Need to normalize by size of data type.
  uint32_t num_reps_val=10;
  uint32_t init_val_val=0;
  
  void *num_cycles, *num_reps, *init_val, *waveform; //Pointers to memory locations where values are expected by FPGA
  
  char *name = "/dev/mem";
  //const int freq = 124998750; // Hz
 
  //if (argc == 2) wait_time = atof(argv[1]);
  //else wait_time = 1.0;
 
  if((fd = open(name, O_RDWR)) < 0) {
    perror("open");
    return 1;
  }
  
  printf("num_cycles\n");
  //cfg = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
  //           PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0x42000000);
  num_cycles = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, num_cycles_addr);
  printf("num_reps\n");
  num_reps = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, num_reps_addr);

  printf("init_val\n");             
  init_val = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, init_val_addr);

  printf("waveform\n");
  waveform = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, waveform_addr);
 
  //*((uint32_t *)(cfg + 0)) = 2;   // clear timer
  //*((uint32_t *)(cfg + 0)) = 1;   // start timer

  //Assign parameter values to correct locations in memory
  printf("num_cycles_val\n");
  *((uint32_t *)(num_cycles + 0)) = num_cycles_val;
  printf("num_reps_val\n");
  *((uint32_t *)(num_reps + 0)) = num_reps_val;  
  printf("init_val_val\n");
  *((uint32_t *)(init_val + 0)) = init_val_val;  
  printf("waveform_val, address=%x\n",waveform);

  
  //sleep(wait_time);   // wait for [wait_time] seconds
 
  //*((uint32_t *)(cfg + 0)) = 0;   // stop timer
 
  //count = *((uint32_t *)(cfg + 8)); // get binary counter output
 
  //printf("Clock count: %5d, calculated time: %5f s\n", 
  //       count, (double)count/freq);
 
  //munmap(cfg, sysconf(_SC_PAGESIZE));
  //sleep(1);
  printf("Done setting parameters.\n");
  printf("num_cycles is at address, %x, and has the value, %d\n",num_cycles,*((uint32_t *)(num_cycles+0)));
  printf("num_reps is at address, %x, and has the value, %d\n",num_reps,*((uint32_t *)(num_reps+0)));
  printf("init_val is at address, %x, and has the value, %d\n",init_val,*((uint32_t *)(init_val+0)));
  
  //Copy waveform values into appropriate memory locations, one at a time
  for(int i=0; i<num_cycles_val; i++){
    *((uint32_t *)(waveform + i*32)) = waveform_val[i]; //Offset by 32 bits per number in waveform times
    printf("Address: %x, value: %d\n",waveform+i*32,waveform_val[i]);
  }
  
  printf("waveform starts at address, %x, ends at address, %x, and has initial value, %d, and final value, %d\n", waveform, waveform+num_cycles_val*32, *((uint32_t *)(waveform+0)),*((uint32_t *)(waveform+32*(num_cycles_val-1))));
  //sleep(1);
  //sleep(10); //Wait for a while to check memory
  
  return 0;
}
