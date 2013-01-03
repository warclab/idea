#include <stdio.h>

int main ()
{
  int n = 50; 
  int a = 0;
  int b = 1;
  int sum;
  int i;

  // Here we call the fibonacci function 

  for ( i = 0; i < n; i++)			
  {							 
    sum = a + b;
    a = b;
    b = sum;
    // Values are printed after a and b are re-assigned.
    printf("a: %u, b: %u, sum: %u\n", a, b, sum);
  }

  // Finally, return 0 

  return 0;
}
