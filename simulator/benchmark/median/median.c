#include <stdio.h>
// iteration 144 
// sample size 20

// Good tutorial on median filter: http://www.librow.com/articles/article-1
// window size 5
const int signal[20] = {1, 2, 3, 4, 5,
                        6, 7, 8, 9, 10,
                        11, 12, 13, 14, 15,
                        16, 17, 18, 19, 20};

const int output[16] = {3, 4, 5, 6, 7,
                        8, 9, 10, 11, 12,
                        13, 14, 15, 16, 17,
                        18}; /*N - window_size - 1*/

int main () {

    //int counter = 0;

    int i, j, k;
    int min, temp;
    int N = 20; 
    int window[5];
    int result[20];

    int main_result = 0;
    
    // Move window through all elements of input signal
    for (i = 2; i < N - 2; i++) {
        // Pick up the window elements
        for (j = 0; j < 5; j++) {
            window[j] = signal[i - 2 + j];        
        }
        // Sort the elements (only half of them)
        for (j = 0; j < 3; j++) {
            min = j;
            for (k = j + 1; k < 5; k++) {
                if (window[k] < window[min]) {
                    min = k;
                }

                //counter = counter + 1;
            }
            // Put found minimum element in temp
            temp = window[j];
            window[j] = window[min];
            window[min] = temp;
        }
        // Get the result
        result[i - 2] = window[2];    
    }

    for (i = 0; i < 16 /*N - (window size -1)*/; i++){
        main_result += (result[i] != output[i]);
        //printf("%i: %i\n", i, result[i]);
    }
    //printf("%d\n", counter);
    //printf("%i\n", main_result);
    
return main_result;
}
