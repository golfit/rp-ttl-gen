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
  uint32_t arm_addr=0x41230000;
  uint32_t trig_addr=0x41240000;
  
  void *arm, *trig; //Pointers to memory locations where values are expected by FPGA
  
  char *name = "/dev/mem";
  //const int freq = 124998750; // Hz
 
  //if (argc == 2) wait_time = atof(argv[1]);
  //else wait_time = 1.0;
  
  
  if((fd = open(name, O_RDWR)) < 0) {
    perror("open");
    return 1;
  }
  
  arm = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, arm_addr);
  trig = mmap(NULL, sysconf(_SC_PAGESIZE), /* map the memory */
             PROT_READ|PROT_WRITE, MAP_SHARED, fd, trig_addr);
  
  //DISPLAY STATE
  printf("Arm Address: %x, val: %d\n", arm, *((uint32_t *)(arm)));
  printf("Trigger Address: %x, val: %d\n", trig, *((uint32_t *)(trig)));

  //ARM BOARD
  *((uint32_t *)(arm + 0)) = 1;
  //DISPLAY STATE
  printf("Arm Address: %x, val: %d\n", arm, *((uint32_t *)(arm)));
  printf("Trigger Address: %x, val: %d\n", trig, *((uint32_t *)(trig)));
 
  sleep(1.0); //Wait 1 s, then trigger.

  //TRIGGER BOARD
  *((uint32_t *)(trig + 0)) = 1;
  //DISPLAY STATE
  printf("Arm Address: %x, val: %d\n", arm, *((uint32_t *)(arm)));
  printf("Trigger Address: %x, val: %d\n", trig, *((uint32_t *)(trig)));
 
  printf("Board armed and triggered.\n");
  
  return 0;
}
