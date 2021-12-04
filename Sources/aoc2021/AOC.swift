//
//  AOC.swift
//
//
//  Created by Antonin on 21/11/2021.
//

import ArgumentParser

@main
struct App: ParsableCommand {
    @Argument(help: "The exercise to run.")
    var exercise: String?
    
    @Flag(help: "Prints the list of available exercises.")
    var printExercises = false
    
    @Option(name: [.customShort("i"), .long], help: "Path of the input file")
    var inputFile: String?
   
    static func checkIfExerciseExists(exercise registered: String) -> Bool {
        return Exercises.shared.isRegistered(registered)
    }
    
    mutating func run() throws {
        // Such a shame that compile time arbitrary code
        // is not a priority in Swift... :/
        _ = Ex01.shared
        _ = Ex02.shared
        _ = Ex03.shared
        _ = Ex04.shared
        
        if (printExercises) {
            let availableExercises = Exercises.shared.registered();
            print("Available exercises:")
            for exercise in availableExercises {
                print("* \(exercise)")
            }
            return
        }
        
        guard let exerciseName = exercise else {
            print("Please provide an exercise to run")
            return
        }
        
        if !(App.checkIfExerciseExists(exercise: exerciseName)) {
            print("The exercise does not exists")
            return
        }
        
        func getInputFile(exerciseName: String, inputFile: String?) -> String {
            return inputFile ?? "Inputs/\(exerciseName).txt"
        }
        
        let file = getInputFile(exerciseName: exerciseName, inputFile: inputFile)
        
        switch exercise {
            // TODO: Find a solution in order to register the name of the exercise *and* the exercise itself
        case Ex01.shared.name:
            Ex01.shared.part1(from: file).unwrap(prefix: "Ex01,part1 ")
            Ex01.shared.part1(from: file).unwrap(prefix: "Ex01,part2 ")
        case Ex02.shared.name:
            Ex02.shared.part1(from: file).unwrap(prefix: "Ex02,part1 ")
            Ex02.shared.part1(from: file).unwrap(prefix: "Ex02,part2 ")
        case Ex03.shared.name:
            Ex03.shared.part1(from: file).unwrap(prefix: "Ex03,part1 ")
            Ex03.shared.part1(from: file).unwrap(prefix: "Ex03,part2 ")
        case Ex04.shared.name:
            Ex04.shared.part1(from: file).unwrap(prefix: "Ex04,part1 ")
            Ex04.shared.part1(from: file).unwrap(prefix: "Ex04,part2 ")
        default:
            print("Exercise not found, should not happen")
        }
        
        return
    }
}
