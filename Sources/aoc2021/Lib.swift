//
//  Lib.swift
//  
//
//  Created by Antonin on 21/11/2021.
//

import Foundation

/// Returned from Exercise to describe a process result
enum Result<T: Equatable>: Equatable {
    /// Process has been fine, and return the value
    case ok(T)
    /// Process resulted in an error, return it as a String
    // TODO: Replace the String type to another generic one?
    case error(String)
    
    func unwrap(prefix: String = "") {
        switch self {
        case .ok(let result): print("\(prefix)solution is \(result)")
        case .error(let error): print("\(prefix)error: \(error)")
        }
    }
}

/// Extends String  with usefull methods for the project
extension String {
    /// Returns the character at index `i`, as a string
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    /// Returns a range of characters based on `r`, the Range type passed as parameter
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    /// Returns the substring of `Self` from `fromIndex` to the end of the string
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, count) ..< count]
    }
    /// Returns the substring of `Self` from `0` to `toIndex`
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
}

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

/// Returns an array of generic type `T` from a file determined by `from`
func getInput<T>(from: String, encodeFrom: ((_ str: String) -> T)) throws -> Result<[T]> {
    do {
        let data = try String(contentsOfFile: from, encoding: .utf8)
        let lines = data.components(separatedBy: .newlines)
        return .ok(lines.map { encodeFrom($0) })
    } catch {
        return .error("\(error)")
    }
}

/// From String to Int
func toInt(s: String) -> Int? {
    return Int(s)
}

/// From String to Float
func toFloat(s: String) -> Float? {
    return Float(s)
}

/// From String to String
func toString(s: String) -> String {
    return s
}
