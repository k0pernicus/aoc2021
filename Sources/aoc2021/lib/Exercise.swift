//
//  Exercise.swift
//  
//
//  Created by Antonin on 11/12/2021.
//

/// Everything we need to implement a solution for an Advent of Code exercise
protocol Exercise {
    /// The name of the exercise
    var name: String { get set }
    /// The type taken  from part_1
    associatedtype InputPart1: Equatable
    /// The type taken from part_2
    associatedtype InputPart2: Equatable
    /// The type returned from part_1
    associatedtype OutputPart1: Equatable
    /// The type returned from part_2
    associatedtype OutputPart2: Equatable
    /// The process to run in order to get the solution for the first part of the exercise
    /// Takes a path file as parameter
    func part1(from: String) -> Result<OutputPart1>;
    /// The process to run in order to get the solution for the first part of the exercise
    /// Takes any value as parameter
    func part1(value: InputPart1) -> Result<OutputPart1>;
    /// The process to run in order to get the solution for the second part of the exercise
    /// Takes a path file as parameter
    func part2(from: String) -> Result<OutputPart2>;
    /// The process to run in order to get the solution for the second part of the exercise
    /// Takes any value as parameter
    func part2(value: InputPart2) -> Result<OutputPart2>;
}

/// Register for the Advent of Code exercises
class Exercises {
    /// The available exercises that can be run
    private var avail: [String]
    
    /// Singleton
    public static let shared = Exercises()
    
    private init() {
        self.avail = Array.init()
    }
    
    /// Result of a register
    enum RegisterResult {
        case ok
        case alreadyExists
    }
    
    /// Register the name of an exercise, in order to
    /// know which exercise is available or not to get the
    /// solution
    func register(_ exercise: String) -> RegisterResult {
        if self.avail.contains(exercise) {
            return .alreadyExists
        }
        self.avail.append(exercise)
        return .ok
    }
    
    /// Returns if an exercise is registered or not, based on
    /// exercise name
    func isRegistered(_ exercise: String) -> Bool {
        return self.avail.contains(exercise)
    }
    
    /// Returns all the registered exercises
    func registered() -> [String] {
        return avail
    }
}
