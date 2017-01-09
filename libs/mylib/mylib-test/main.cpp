#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch.hpp"
#include "mylib.h"

TEST_CASE( "MyMath", "[addition]" ) {
    SECTION("Addition") {
        MyLib my;
        REQUIRE(my.addition(3,4) == 7);
    }
}
