//Start from http://antonpotocnik.com/?p=489265, stopwatch.c, and hack test parameters and waveform.
//This program is just meant to query the memory addresses used in ttl_gen board.
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
  uint32_t num_cycles_addr=0x41200000;
  uint32_t num_reps_addr=0x41210000;
  uint32_t init_val_addr=0x41220000;
  uint32_t waveform_addr=0x00000000; //In the initial configuration of this module, this is the offset for the waveform memory address
 
  uint32_t num_cycles_val;
 
  void *num_cycles, *num_reps, *init_val, *waveform; //Pointers to memory locations where values are expected by FPGA
  
  char *name = "/dev/mem";
 
  if((fd = open(name, O_RDWR)) < 0) {
    perror("open");
    return 1;
  }
  num_cycles = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, num_cycles_addr);

  num_reps = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, num_reps_addr);
             
  init_val = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, init_val_addr);
             
  waveform = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, waveform_addr);
 
  num_cycles_val=*((uint32_t *)(num_cycles+0));
 
  printf("Done setting parameters.\n");
  printf("num_cycles is at address, %x, and has the value, %d\n",num_cycles,num_cycles_val);
  printf("num_reps is at address, %x, and has the value, %d\n",num_reps,*((uint32_t *)(num_reps+0)));
  printf("init_val is at address, %x, and has the value, %d\n",init_val,*((uint32_t *)(init_val+0)));
  printf("waveform starts at address, %x, ends at address, %x, and has initial value, %d, and final value, %d\n", waveform, waveform+num_cycles_val*32, *((uint32_t *)(waveform+0)),*((uint32_t *)(waveform+32*(num_cycles_val-1))));
  printf("All values in waveform (edge wait times):\n");
  for(int i=0; i<num_cycles_val; i++){
      printf("Address, %x: value, %d\n", waveform+i*32, *((uint32_t *)(waveform+i*32)));
  }
  
  return 0;
}
