#include <iostream>
#include "stdio.h"

int solve1(const char *filename);
int solve2(const char *filename);

int main() {
    const char *test1 = "data/test1";
    const char *test2 = "data/test2";
    const char *input = "data/input";
    
    int test1_val = 0;
    int result1 = solve1(test1);
    
    if (result1 == test1_val) {
        printf("Test 1 result %d\n", solve1(input));
    } else {
        printf("Test1 failed");
        return -1;
    }

    int test2_val = 0;
    int result2 = solve2(test2);

    if (result2 == test2_val) {
        printf("Test 2 result %d\n", solve2(input));
    } else {
        printf("Test2 failed");
        return -1;
    }

    return 0;
}