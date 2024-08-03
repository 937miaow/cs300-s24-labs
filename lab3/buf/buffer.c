#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#define BUFSIZE 32

// unused...?
void hack()
{
    printf("you've been hacked!\n");
    exit(0);
}

void foo()
{
    // stack allocate some variables
    const int fav_number = 937; // your favorite number is a constant so it can't change
    char buf[BUFSIZE];

    // print favorite number
    printf("My favorite number is %d and it will always be %d and nothing can change that\n", fav_number, fav_number);

    // get a string from stdin
    gets(buf);

    /*
    (gdb) p &buf
    $1 = (char (*)[32]) 0x7fffffffdf40
    (gdb) p &fav_number
    $2 = (const int *) 0x7fffffffdf6c

    两个变量之间的距离是 0x2c，也就是 44 字节
    所以get44个字符就可以覆盖fav_number

    43:937-937-937-937-937-937-937-937-937-973-937
    44:937-937-937-937-937-937-937-937-937-973-937-
    */

    // print favorite number again bc its a great number and you want the world to know
    printf("My favorite number is %d and it will always be %d and nothing can change that\n", fav_number, fav_number);
}

int main(int argc, char **argv)
{

    foo();

    printf("Returned to main safe and sound\n");

    return 0;
}
