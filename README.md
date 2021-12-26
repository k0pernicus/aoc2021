# aoc2021

This package proposes some solutions for Advent of Code 2021,
in order to have some fun and learn Swift (in a good way).

This package avoids **a maximum** to be macOS-specific.  
If you are using another operating system and found some
platform issues, do not hesitate to fill an issue, or propose
a modification.

This project does not attempts to propose the best architecture
for a Swift project at all, but an attempt to "just solve" aoc exercises.  
You can propose changes as well to update the architecture, use
a more the standard library (the lack of "good" documentation for Swift
was my main nightmare for this project), etc.

**Personal note**
After spending time on this, I don't think I will try to solve aoc 
in Swift again.  
Swift was fun but the lack of good documentation, Xcode mistakes,
an immature standard library (coming from Rust), 
Swift compiler "dumb" bugs, ... disappointed me a lot.  
I will maybe come back to Rust, or switch to Zig.

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

## Exercices

✔️ = solved  
❌ = unsolved (yet)

Ex01 ✔️ - ✔️  
Ex02 ✔️ - ✔️  
Ex03 ✔️ - ✔️  
Ex04 ✔️ - ✔️  
Ex05 ✔️ - ✔️  
Ex06 ✔️ - ✔️  
Ex07 ✔️ - ✔️  
Ex08 ✔️ - ✔️  
Ex09 ✔️ - ✔️  
Ex10 ✔️ - ✔️  
Ex11 ✔️ - ✔️  
Ex12 ✔️ - ✔️  
Ex13 ✔️ - ✔️  
Ex14 ✔️ - ✔️  
Ex15 ✔️ - ✔️  
Ex16 ✔️ - ✔️  
Ex17 ✔️ - ✔️  
Ex18 ❌- ❌  
Ex19 ❌- ❌  
Ex20 ✔️ - ✔️   
Ex21 ✔️ - ✔️  
Ex22 ❌- ❌   
Ex23 ❌- ❌  
Ex24 ✔️ - ✔️  
Ex25 ✔️ - ❌   
