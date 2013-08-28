#include<stdio.h>

// iteration 125 
// sample size 5x5

const int a[5][5] = { {1, 2, 3, 4, 5},
                    {6, 7, 8, 9, 10},
                    {11, 12, 13, 14, 15},
                    {16, 17, 18, 19, 20},
                    {21, 22, 23, 24, 25}};

const int b[5][5] = { {1, 0, 1, 0, 1},
                    {1, 1, 1, 1, 1},
                    {1, 1, 1, 0, 0},
                    {0, 0, 0, 1, 1},
                    {1, 0, 1, 0, 1}};

const int output[5][5] = {  {11, 5, 11, 6, 12}, 
                            {31, 15, 31, 16, 32},
                            {51, 25, 51, 26, 52},
                            {71, 35, 71, 36, 72},
                            {91, 45, 91, 46, 92}};

int main()
{
    //int counter = 0;

    int volatile c[5][5]; 
    int i, j, k;
    int x, y;
    int sum = 0;

    int main_result = 0;

    for (i = 0; i < 5; i++) {
        for (j = 0; j < 5; j++) {
            sum = 0;
            for (k = 0; k < 5 ; k++) {
                sum = sum + a[i][k] * b[k][j];
                c[i][j]=sum;

                //counter = counter + 1;
            }
        }
    }
    
    for (x = 0; x < 5; x++){
        for (y = 0; y < 5; y++) {
            main_result += (output[x][y] != c[x][y]);
            // printf("c[%i][%i] = %i\n", i, j, c[i][j]);
        }
    }

    //printf("%d\n", counter);
    //printf("%d\n", main_result);

    return main_result;
}
