#include <iostream>
#include "mylib.h"
#include "otherlib.h"

using namespace std;

int main()
{
    MyLib adder;
    OtherLib subtr;
    cout << adder.addition(10, 50) << endl;
    cout << subtr.subtraction(50, 10) << endl;
    return 0;
}
