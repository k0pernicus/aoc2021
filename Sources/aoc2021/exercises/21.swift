//
//  21.swift
//
//
//  Created by Antonin on 21/12/2021.
//

import Foundation
import XCTest

public func findPositions(rawStrings: [String]) -> [Int]? {
    if rawStrings.count == 0 {
        return nil
    }
    var positions: [Int] = []
    for rawString in rawStrings {
        let parsedString = rawString.split(separator: ":")
        if parsedString.count != 2 {
            continue
        }
        positions.append(Int(parsedString[1].trimmingCharacters(in: .whitespaces))!)
    }
    return positions
}

class Ex21: Exercise {
    var name: String = "21"
   
    typealias InputPart1 = [String]
    typealias InputPart2 = [String]
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
            let data: Result<[String]> = try getInput(from: from)
            switch data {
            case .ok(let data):
                return self.part1(value: data)
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
            let data: Result<[String]> = try getInput(from: from)
            switch data {
            case .ok(let data):
                return self.part2(value: data)
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value data: [String]) -> Result<Int> {
        guard let positions = findPositions(rawStrings: data) else {
            return .error("cannot parse and find players positions")
        }
        let board = (1...10).map{ $0 }
        var die: Int = 1
        var nbDie: Int = 0
        var scores: [Int] = [0, 0]
        var spaces: [Int] = [board[positions[0] - 1], board[positions[1] - 1]]
        var cPlayer: Int = 0
        while true {
            let sumDie: Int = (die..<die+3).map { $0 }.reduce(0, +)
            let newBoardSpace = board[(spaces[cPlayer] + sumDie - 1) % board.count]
            scores[cPlayer] += newBoardSpace; spaces[cPlayer] = newBoardSpace
            print("Player \(cPlayer + 1) rolls \((die..<die+3).map { String($0) }.joined(separator: "+")) and moves to space \(spaces[cPlayer]) for a total score of \(scores[cPlayer]).")
            die += 3; nbDie += 3
            if scores[cPlayer] >= 1000 { break }
            cPlayer = cPlayer == 1 ? 0 : 1
        }
        print("nb die: \(nbDie), player \(cPlayer) won!")
        return .ok(scores[cPlayer == 1 ? 0 : 1] * nbDie)
    }
    
    internal func part2(value data: [String]) -> Result<Int> {
        return .ok(0)
    }
    
    public static let shared = Ex21()
}
