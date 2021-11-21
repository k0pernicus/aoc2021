# aoc2021

This package proposes some solutions for Advent of Code 2021,
in order to have some fun and learn Swift (in a good way).

This package avoids **a maximum** to be macOS-specific.  
If you are using another operating system and found some
platform issues, do not hesitate to fill an issue, or propose
a modification.

## Build

In this repository: `swift build`.  
To build a faster and optimised version of aoc2021,
you can run `swift build -c release`.

## Run

You can run the tests you want using `swift test`.  
All the tests have generic and public inputs from the Advent of Code 2021 website.

You can solve **your** specific inputs in putting your inputs in a dedicated folder called `Inputs`,
like this:  
* `Inputs/01.txt`
* `Inputs/02.txt`
* `Inputs/03.txt`
* ...
