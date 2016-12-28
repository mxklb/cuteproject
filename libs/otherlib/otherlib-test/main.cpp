#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch.hpp"
#include "otherclass.h"

TEST_CASE( "MyMath", "[mymath]" ) {
    SECTION("Subtraction") {
        OtherClass my;
        REQUIRE((float)my.subtraction(5.5,4.4) == (float)1.1);
        REQUIRE(my.subtraction(5,4) == 1);
    }
}
