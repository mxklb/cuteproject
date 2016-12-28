#include <iostream>
#include "myclass.h"
#include "otherclass.h"

using namespace std;

int main()
{
    MyClass adder;
    OtherClass subtr;
    cout << adder.addition(10, 50) << endl;
    cout << subtr.subtraction(50, 10) << endl;
    return 0;
}
