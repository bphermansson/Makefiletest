/**
 * @file main.c
 * @author Patrik Hermansson (hermansson.patrik@gmail.com)
 * @brief 
 * 
 * gcc src/main.c lib/lib1/libfile1.c -o main -Ilib/lib1
 * 
 * https://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
 * 
 * @version 0.1
 * @date 2022-05-10
 * 
 * @copyright (c) Patrik Hermansson 2022
 * 
 */

#include <stdio.h>
#include <libfile1.h>

int main()
{
    printf("In main\n");
    libfile1();
    return 0;
}