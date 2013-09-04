#include "stdio.h"
// gcc -o fir fir.c
// ./fir.exe

// iteration 250
// sample size 50

const int data[54] = {   45, 1, 22, 53, 10, 12, 13, 25, 33, 14, 
                        12, 36, 12, 2, 24, 15, 5, 3, 42, 13,
                        33, 25, 35, 25, 14, 31, 41, 17, 15, 22,
                        16, 26, 22, 29, 25, 11, 33, 20, 21, 9,
                        25, 21, 4, 21, 14, 14, 32, 30, 13, 1,
                        0, 0, 0, 0}; // Padded line for y[49]

const int output[50] =  {   1176, 1112, 716, 720, 816, 970, 911, 846, 865, 800,
                            588, 591, 621, 432, 552, 710, 1047, 985, 1231, 1174,
                            1147, 1010, 1099, 1221, 1121, 887, 809, 830, 861, 1003,
                            1031, 1000, 949, 913, 1012, 813, 797, 747, 763, 662,
                            590, 664, 719, 937, 1043, 815, 453, 170, 44, 3}; 

int main () {

    //int counter = 0;
    int i;
    int main_result = 0;

    int k, n;
    int sum;
    
    int ndata = 50;
    int ncoeff = 5;
    int /*short*/ coeff[5] = { 3, 5, 15, 12, 7};
    int y[50];

    for (n = 0; n < ndata; n++) {
        sum = 0;
        for (k = 0; k < ncoeff; k++) {
            sum = sum + coeff[k] * data[k+n];
            y[n] = sum;  

            //counter = counter + 1;         
        }
    }
    
    for (i = 0; i < 50; i++){
        main_result += (output[i] != y[i]);
    }
    //printf ("%d\n", main_result);
    //printf ("%d\n", counter);
    
    return main_result;
}
