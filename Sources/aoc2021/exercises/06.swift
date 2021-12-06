//
//  06.swift
//
//
//  Created by Antonin on 06/12/2021.
//

import Foundation
import XCTest

class Ex06: Exercise {
    var name: String = "06"
   
    typealias InputPart1 = String
    typealias InputPart2 = String
    typealias OutputPart1 = Int
    typealias OutputPart2 = Int
    
    private init() {
        let result = Exercises.shared.register(self.name)
        if result == .alreadyExists {
            fatalError("exercise with name \(self.name) already exists - cannot register...")
        }
    }
    
    internal func part1(from: String) -> Result<Int> {
        do {
            let result: Result<[String]> = try getInput(from: from)
            switch result {
            case .ok(let input):
                return self.part1(value: input[0])
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part2(from: String) -> Result<Int> {
        do {
            let result: Result<[String]> = try getInput(from: from)
            switch result {
            case .ok(let input):
                return self.part2(value: input[0])
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    private func playRound(data: [Int], rounds: Int) -> Int {
        var fishes: [Int] = Array.init(repeating: 0, count: 9)
        data.forEach({ fishes[$0] += 1 })
        for _ in 0..<rounds {
            // Solution here is rotating arrays
            let newFishes = fishes.removeFirst()
            fishes.append(newFishes)
            fishes[6] += newFishes
        }
        return fishes.reduce(0, { accumulate, fishes in return accumulate + fishes })
    }
    
    internal func part1(value input: String) -> Result<Int> {
        let data: [Int] = input.split(separator: ",").map { Int($0)! }
        return .ok(self.playRound(data: data, rounds: 80))
    }
    
    internal func part2(value input: String) -> Result<Int> {
        let data: [Int] = input.split(separator: ",").map { Int($0)! }
        return .ok(self.playRound(data: data, rounds: 256))
    }
    
    public static let shared = Ex06()
}
