//
//  13.swift
//  
//
//  Created by Antonin on 13/12/2021.
//

import Foundation
import XCTest

struct Origami{

    enum Case: String, CustomStringConvertible  {
        case marked = "#"
        case unmarked = " "
        
        var description: String {
            get {
                return self.rawValue
            }
        }
    }
    
    enum Fold {
        case horizontal(Int)
        case vertical(Int)
        
        init?(s: String) {
            if !s.hasPrefix("fold along ") {
                return nil
            }
            let rawFold = s.deletingPrefix("fold along ").split(separator: "=")
            if rawFold.count != 2 {
                return nil
            }
            switch rawFold[0] {
            case "x": self = .vertical(Int(rawFold[1])!)
            case "y": self = .horizontal(Int(rawFold[1])!)
            default: fatalError("found fold \(rawFold[0]) but expected `x` or `y`")
            }
        }
    }
    
    var boards: [
        [[Case]]
    ] = []
    
    init(input: [String]) {
        var points: [Point] = []
        for data in input {
            if data.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
                continue
            }
            if data.hasPrefix("fold") {
                continue
            }
            let data = data.split(separator: ",")
            if data.count != 2 {
                fatalError("line '\(data)' does not match the required pattern")
            }
            guard let x = Int(data[0]) else {
                fatalError("in line '\(data)', x position (\(data[0])) is not an integer")
            }
            guard let y = Int(data[1]) else {
                fatalError("in line '\(data)', y position (\(data[1])) is not an integer")
            }
            points.append(Point(x: x, y: y))
        }
        let (maxX, maxY) = (points.map({ $0.x }).max()!, points.map({ $0.y }).max()!)
        var board: [[Case]] = Array.init(repeating: Array.init(repeating: .unmarked, count: maxX + 1), count: maxY + 1)
        for markedPoint in points {
            board[markedPoint.y][markedPoint.x] = .marked
        }
        self.boards.append(board)
    }
    
    mutating func fold(along: Fold) {
        guard let lastBoard: [[Case]] = self.boards.last else {
            return
        }
        let maxY: Int = lastBoard.count
        let maxX: Int = lastBoard[0].count
        var boardA: [[Case]]
        let boardB: [[Case]]
        switch along {
        case .horizontal(let splitIndex):
            if splitIndex >= maxY {
                return
            }
            boardA = lastBoard.prefix(splitIndex).map { $0 }
            boardB = lastBoard.reversed().prefix(splitIndex).map { $0 }
        case .vertical(let splitIndex):
            if splitIndex >= maxX {
                return
            }
            boardA = lastBoard.map { line in line.prefix(splitIndex).map { $0 } }
            boardB = lastBoard.map { line in line.reversed().prefix(splitIndex).map{ $0 } }
        }
        for (y, line) in boardB.enumerated() {
            for (x, element) in line.enumerated() {
                if element == .marked && boardA[y][x] == .unmarked {
                    boardA[y][x] = .marked
                }
            }
        }
        self.boards.append(boardA)
    }
    
    func printDebug(index: Int) {
        if index >= self.boards.count {
            return
        }
        print("index \(index)")
        for line in self.boards[index] {
            for element in line {
                print(element, terminator: "")
            }
            print()
        }
        print()
    }
    
    func printDebug() {
        let index = self.boards.count - 1
        print("index \(index)")
        for line in self.boards[index] {
            for element in line {
                print(element, terminator: "")
            }
            print()
        }
        print()
    }
    
    func getMarked(index: Int) -> Int? {
        if index >= self.boards.count {
            return nil
        }
        let board = self.boards[index]
        var sum = 0
        for line in board {
            for element in line {
                if element == .marked { sum += 1}
            }
        }
        return sum
    }
    
    func getMarked() -> Int {
        let board = self.boards[self.boards.count - 1]
        var sum = 0
        for line in board {
            for element in line {
                if element == .marked { sum += 1}
            }
        }
        return sum
    }
}

class Ex13: Exercise {
    var name: String = "13"
   
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
        // Origami setup
        let origamiPositions = data.filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && !$0.hasPrefix("fold") }
        var origami = Origami(input: origamiPositions)
        
        // Prepare the fold
        let folds = data.filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && $0.hasPrefix("fold") }
        if folds.count == 0 {
            fatalError("no fold found")
        }
        guard let firstFold = Origami.Fold(s: folds[0]) else {
            fatalError("first fold is not correct")
        }
        origami.fold(along: firstFold)
        
        guard let nbMarked = origami.getMarked(index: 1) else {
            return .error("no marked in origami")
        }
        return .ok(nbMarked)
    }
    
    internal func part2(value data: [String]) -> Result<Int> {
        // Origami setup
        let origamiPositions = data.filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && !$0.hasPrefix("fold") }
        var origami = Origami(input: origamiPositions)
        
        // Prepare the fold
        data
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && $0.hasPrefix("fold") }
            .forEach({ fold in origami.fold(along: Origami.Fold(s: fold)!); origami.printDebug() })
        origami.printDebug()
        return .ok(0)
    }
    
    public static let shared = Ex13()
}
