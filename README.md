# math_formula_convertor

A dart package for resolving the math formula which are in string.

## Getting Started

This is the package in which you can able to resolve the math formula very easily from the string.

For example,

Consider you have this equation in string "add(1,5)" this package provide to resolve this equation
and provide you the exact math equation result as "6"

multiply(5,10) -->> 5*10 -->> 50 divide(5,10) -->> 5/10 -->> 0.5 subtract(5,10) -->> 5-10 -->> -5

And also this package can support nesting of equations like below,

add(multiply(5,10),add(1,2)) -->>  (5*10) + (1+2) -->> 50 + 3 -->> 53

History of evolving this package,

This is the package created for certain reason the one here i explained below,

We the team(ATC) work in the project called FreshFlows the project management tool, that need this
formula conversion package. We searched a lot but not find the exact one that matches our needs.

So we have created this formula conversion ourself by analysing all the math stuffs. As it need to
be grow.

Here we have created this package to support the needy who want the exact things to be happen.

So we have created this package.

Please have a look and report if any issues.

**Please check main.dart file in the git repo for the example.**