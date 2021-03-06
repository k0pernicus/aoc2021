//
//  AOC.swift
//
//
//  Created by Antonin on 21/11/2021.
//

import ArgumentParser
import Foundation

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
        for ex in [
            Ex01.shared,
            Ex02.shared,
            Ex03.shared,
            Ex04.shared,
            Ex05.shared,
            Ex06.shared,
            Ex07.shared,
            Ex08.shared,
            Ex09.shared,
            Ex10.shared,
            Ex11.shared,
            Ex12.shared,
            Ex13.shared,
            Ex14.shared,
            Ex15.shared,
            Ex16.shared,
            Ex17.shared,
            Ex20.shared,
            Ex21.shared,
            Ex24.shared,
            Ex25.shared,
        ] as [Any] {
            _ = ex
        }
        
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
        
        if !FileManager.default.fileExists(atPath: file) {
            print("Input \(file) does not exist")
            return
        }
        
        switch exercise {
            // TODO: Find a solution in order to register the name of the exercise *and* the exercise itself
        case Ex01.shared.name:
            Ex01.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex01.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex02.shared.name:
            Ex02.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex02.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex03.shared.name:
            Ex03.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex03.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex04.shared.name:
            Ex04.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex04.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex05.shared.name:
            Ex05.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex05.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex06.shared.name:
            Ex06.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex06.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex07.shared.name:
            Ex07.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex07.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex08.shared.name:
            Ex08.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex08.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex09.shared.name:
            Ex09.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex09.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex10.shared.name:
            Ex10.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex10.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex11.shared.name:
            Ex11.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex11.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex12.shared.name:
            Ex12.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex12.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex13.shared.name:
            Ex13.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex13.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex14.shared.name:
            Ex14.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex14.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex15.shared.name:
            Ex15.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex15.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex16.shared.name:
            Ex16.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex16.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex17.shared.name:
            Ex17.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex17.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex20.shared.name:
            Ex20.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex20.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex21.shared.name:
            Ex21.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex21.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex24.shared.name:
            Ex24.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex24.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        case Ex25.shared.name:
            Ex25.shared.part1(from: file).unwrap(prefix: "Ex\(exercise!),part1 ")
            Ex25.shared.part2(from: file).unwrap(prefix: "Ex\(exercise!),part2 ")
        default:
            print("Exercise not found, should not happen")
        }
        
        return
    }
}
