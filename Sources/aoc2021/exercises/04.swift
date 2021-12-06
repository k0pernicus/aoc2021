//
//  04.swift
//
//
//  Created by Antonin on 04/12/2021.
//

import Foundation
import XCTest

enum RoundResult {
    case won(Int)
    case noWin
}

/// Parses the input and returns a couple: The numbers selected by lottery, and the bingo game boards
func boardsParser(input: [String]) -> ([Int], [BingoBoard])? {
    if input.count <= 2 {
        return nil
    }
    let guessedNumbers: [Int] = input[0].split(separator: ",").map { Int($0)! }
    var board: [String] = []
    var boards: [BingoBoard] = []
    for line in input[2...] {
        guard line.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 else {
            boards.append(BingoBoard.init(boardLines: board))
            board = []
            continue
        }
        board.append(line)
    }
    // Handle the missing new line in test file
    if board.count != 0 {
        boards.append(BingoBoard.init(boardLines: board))
    }
    return (guessedNumbers, boards)
}

struct BingoBoard {
    let numbers: NSMutableOrderedSet
    let rows: [Int:NSOrderedSet]
    let columns: [Int:NSOrderedSet]
    
    init(boardLines: [String]) {
        let rawNumbers = boardLines.map(
            { $0.split(separator: " ").map({ Int($0)! }) }
        )
        self.rows = rawNumbers.enumerated().reduce(into: [Int:NSOrderedSet]()) {
            $0[$1.0] = NSOrderedSet(array: $1.1)
        }
        // TODO: better code initialization for columns ?
        let columns: [Int:NSMutableOrderedSet] = (0..<rawNumbers.count).reduce(into: [:]) {
            $0[$1] = NSMutableOrderedSet()
        }
        for i in 0..<rawNumbers[0].count {
            for j in 0..<rawNumbers.count {
                columns[i]?.add(rawNumbers[j][i])
            }
        }
        self.columns = columns
        let numbers = rawNumbers.flatMap { $0 }
        self.numbers = NSMutableOrderedSet(array: numbers)
    }
    
    /// Print the current state of the board (debug only)
    func printBoard() {
        print("  \(self.columns.keys.sorted().map({ String($0) }).joined(separator: "\t"))")
        for (index, row) in self.rows {
            print("\(index) \(row.map({ self.numbers.contains($0) ? String($0 as! Int) : "_" }).joined(separator: "\t"))")
        }
    }
    
    /// Returns the unchecked numbers in the current board, multiplied by the
    /// last lottery number (passed as parameter)
    func getResult(lotteryNumber: Int) -> Int {
        lotteryNumber * (self.numbers.array as! [Int]).reduce(0, +)
    }
    
    /// Play a round
    mutating func round(number: Int) -> RoundResult {
        guard self.numbers.contains(number) else {
            return .noWin
        }
        self.numbers.remove(number)
        // Check if one row won
        for (_, row) in self.rows {
            if row.allSatisfy({ !self.numbers.contains($0) }) {
                return .won(self.getResult(lotteryNumber: number))
            }
        }
        // Check if one column won
        for (_, column) in self.columns {
            if column.allSatisfy({ !self.numbers.contains($0) }) {
                return .won(self.getResult(lotteryNumber: number))
            }
        }
        return .noWin
    }
}

class Ex04: Exercise {
    var name: String = "04"
   
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
            let input: Result<[String]> = try getInput(from: from)
            switch input {
            case .ok(let bingo):
                return self.part1(value: bingo)
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
            let input: Result<[String]> = try getInput(from: from)
            switch input {
            case .ok(let bingo):
                return self.part2(value: bingo)
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value input: [String]) -> Result<Int> {
        guard let (guessedNumbers, boards) = boardsParser(input: input) else {
            return .error("cannot parse the input")
        }
        for number in guessedNumbers {
            for board in boards {
                // Mutate
                var board = board
                switch board.round(number: number) {
                case .won(let result): return .ok(result)
                case .noWin: continue
                }
            }
        }
        return .error("did not found the winner...")
    }
    
    internal func part2(value input: [String]) -> Result<Int> {
        guard let (guessedNumbers, boards) = boardsParser(input: input) else {
            return .error("cannot parse the input")
        }
        var remainingBoards = boards
        var lastScore: Int? = nil
        for number in guessedNumbers {
            var indexToRemove: [Int] = []
            for (index, var board) in remainingBoards.enumerated() {
                switch board.round(number: number) {
                case .won(let result):
                    indexToRemove.append(index)
                    lastScore = result
                case .noWin: continue
                }
            }
            indexToRemove.enumerated().forEach( { remainingBoards.remove(at: $0.1 - $0.0) } )
        }
        if (lastScore == nil) {
            return .error("did not found the winner...")
        }
        return .ok(lastScore!)
    }
    
    public static let shared = Ex04()
}
