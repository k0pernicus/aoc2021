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
            die += 3; nbDie += 3
            if scores[cPlayer] >= 1000 { break }
            cPlayer = cPlayer == 1 ? 0 : 1
        }
        return .ok(scores[cPlayer == 1 ? 0 : 1] * nbDie)
    }
    
    struct State: Equatable, Hashable {
        var p1Position: Int
        var p1Score: Int
        var p2Position: Int
        var p2Score: Int
        var p1ToPlay: Bool
        
        init(p1Position: Int, p2Position: Int) {
            self.p1Position = p1Position
            self.p2Position = p2Position
            self.p1Score = 0
            self.p2Score = 0
            self.p1ToPlay = true
        }
    }
    
    internal func part2(value data: [String]) -> Result<Int> {
        // Tip for the dice roll outcomes:
        // 3 4 4 5 5 5 6 6 7
        // 4 5 5 6 6 6 7 7 8
        // 5 6 6 7 7 7 8 8 9
        let diceOutcomes: [(Int, Int)] = [(3, 1), (4, 3), (5, 6), (6, 7), (7, 6), (8, 3), (9, 1)]
        
        guard let positions = findPositions(rawStrings: data) else {
            return .error("cannot parse and find players positions")
        }
        
        func countWins(state: State, cache: inout [State: (Int, Int)]) -> (Int, Int) {
            if state.p1Score >= 21 {
                return (1, 0)
            }
            if state.p2Score >= 21 {
                return (0, 1)
            }
            var total = (0, 0)
            for (steps, frequency) in diceOutcomes {
                var nextState: State = state
                if state.p1ToPlay {
                    nextState.p1Position = ((state.p1Position + steps - 1) % 10) + 1
                    nextState.p1Score += nextState.p1Position
                    nextState.p1ToPlay = false
                } else {
                    nextState.p2Position = ((state.p2Position + steps - 1) % 10) + 1
                    nextState.p2Score += nextState.p2Position
                    nextState.p1ToPlay = true
                }
                
                var cacheState = cache[nextState]
                if cacheState == nil {
                    let res = countWins(state: nextState, cache: &cache);
                    cache[nextState] = res;
                    cacheState = res
                }
                
                total.0 += (cacheState!.0 * frequency)
                total.1 += (cacheState!.1 * frequency)
            }
            
            return total
        }
        
        var cache: [State: (Int, Int)] = [:]
        
        let wins = countWins(state: State(p1Position: positions[0], p2Position: positions[1]), cache: &cache)
        
        return .ok(max(wins.0, wins.1))
    }
    
    public static let shared = Ex21()
}
