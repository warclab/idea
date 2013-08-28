// gcc -o fib fib.c
// ./fib.exe > output

// iteration 45
// sample size 45

/**
 * You'll notice that we need to include a header file that
 * contains functions we need to use. Being a compiled language,
 * it's inefficient to include functions that aren't needed.
 * stdio.h contains functions for reading from and writing to the console
 */

#include <stdio.h>

/**
 * In C, the program executes the main function. You should also take note
 * that we must declare a return type for the function. In this case, it's
 * an integer, and we return 0 to indicate successful completion of the 
 * program.
 */
const int output[45] = {            1, 2, 3, 5, 8, 
                                    13, 21, 34, 55, 89, 
                                    144, 233, 377, 610, 987, 
                                    1597, 2584, 4181, 6765, 10946, 
                                    17711, 28657, 46368, 75025, 121393, 
                                    196418, 317811, 514229, 832040, 1346269, 
                                    2178309, 3524578, 5702887, 9227465, 14930352, 
                                    24157817, 39088169, 63245986, 102334155, 165580141, 
                                    267914296, 433494437, 701408733, 1134903170, 1836311903/*, 
                                    2971215073, 512559680, 3483774753, 3996334433, 3185141890*/ }; // warning: this decimal constant is unsigned only in ISO C90

int main ()
{
  /* Notice that we need to declare our variables, and their type */
    
  //int counter = 0;
  int n = 45;
  int a = 0;
  int b = 1;
  int i;
  
  volatile int sum[n];
  
  int main_result = 0;
    
    for ( i = 0; i < n; i++)			
    {							 
        sum[i] = a + b;
        a = b;
        b = sum[i];

        //counter = counter + 1;
    }
    
    for (i = 0; i < n; i++){
        main_result += (output[i] != sum[i]);
        //printf("%u, ", sum[i]);
    }
        //printf ("%d\n", main_result);
        //printf("%d\n", counter);
    
  return main_result;
}
