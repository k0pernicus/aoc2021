//
//  05.swift
//
//
//  Created by Antonin on 05/12/2021.
//

import Foundation
import XCTest

typealias Vent = (Int, Int)

func ventColumn(_ segment: VentSegment) -> [Vent]? {
    if segment.from.1 != segment.to.1 {
        return nil
    }
    let (xmin, xmax) = segment.from.0 < segment.to.0 ? (segment.from.0, segment.to.0) : (segment.to.0, segment.from.0)
    return (xmin...xmax).map({ ($0, segment.from.1) })
}

func ventDiagonal(_ segment: VentSegment) -> [Vent]? {
    if abs(segment.from.0 - segment.to.0) != abs(segment.from.1 - segment.to.1) {
        return nil
    }
    return zip(
        stride(from: segment.from.0, through: segment.to.0, by: segment.from.0 > segment.to.0 ? -1 : 1),
        stride(from: segment.from.1, through: segment.to.1, by: segment.from.1 > segment.to.1 ? -1 : 1)
    ).map { $0 }
}

func ventRow(_ segment: VentSegment) -> [Vent]? {
    if segment.from.0 != segment.to.0 {
        return nil
    }
    let (ymin, ymax) = segment.from.1 < segment.to.1 ? (segment.from.1, segment.to.1) : (segment.to.1, segment.from.1)
    return (ymin...ymax).map({ (segment.from.0, $0) })
}

enum VentValidator {
    case column
    case diagonal
    case row
}

let VentValidators : [VentValidator:(VentSegment) -> [Vent]?] = [
    .column: ventColumn,
    .diagonal: ventDiagonal,
    .row: ventRow,
]

struct VentSegment {
    let from: Vent
    let to: Vent
    
    init?(line: String) {
        if line.isEmpty {
            return nil
        }
        let vent = line.components(separatedBy: " -> ")
        if vent.count != 2 {
            return nil
        }
        let from = vent[0].split(separator: ",").map({ Int($0) }).compactMap { $0 }
        let to = vent[1].split(separator: ",").map({ Int($0) }).compactMap { $0 }
        if from.count != 2 || to.count != 2 {
            return nil
        }
        self.from = (from[0], from[1])
        self.to = (to[0], to[1])
    }
    
    func range(validators: [VentValidator]) -> [Vent]? {
        for validator in validators {
            guard let fn = VentValidators[validator] else {
                continue
            }
            guard let vents = fn(self) else {
                continue
            }
            return vents
        }
        return nil
    }
}

struct VentsBoard {
    let board: [Int: [Int: Int]]
    var maxY: Int? {
        let y: [Int] = Array(self.board.keys)
        return y.max()
    }
    var maxX: Int? {
        let x: [Int] = Array(self.board.values.map({ $0.keys }).flatMap({ $0 }))
        return x.max()
    }
    
    init(segments: [VentSegment], allows: VentValidator...) {
        var board: [Int: [Int: Int]] = [:]
        for segment in segments {
            guard let vents = segment.range(validators: allows) else {
                continue
            }
            for vent in vents {
                var subMap = board[vent.0] ?? [:]
                subMap.updateValue((subMap[vent.1] ?? 0) + 1, forKey: vent.1)
                board.updateValue(subMap, forKey: vent.0)
            }
        }
        self.board = board
    }
    
    func draw() {
        for y in 0...(maxY ?? 0) {
            for x in 0...(maxX ?? 0) {
                print(self.board[x]?[y] ?? ".", terminator: "")
            }
            print()
        }
    }
    
    func getNbElements(cmp: (Int, Int) -> Bool, for checked: Int) -> Int {
        var sum = 0
        for (_, x) in self.board {
            for (_, value) in x {
                sum += cmp(value, checked) ? 1 : 0
            }
        }
        return sum
    }
}

class Ex05: Exercise {
    var name: String = "05"
   
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
            let input: Result<[String]> = try getInput(from: from, encodeFrom: toString)
            switch input {
            case .ok(let vents):
                return self.part1(value: vents)
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
            let input: Result<[String]> = try getInput(from: from, encodeFrom: toString)
            switch input {
            case .ok(let vents):
                return self.part2(value: vents)
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value input: [String]) -> Result<Int> {
        let segments: [VentSegment] = input.compactMap({ VentSegment(line: $0) })
        let board: VentsBoard = VentsBoard(segments: segments, allows: .row, .column)
        return .ok(board.getNbElements(cmp: >=, for: 2))
    }
    
    internal func part2(value input: [String]) -> Result<Int> {
        let segments: [VentSegment] = input.compactMap({ VentSegment(line: $0) })
        let board: VentsBoard = VentsBoard(segments: segments, allows: .row, .column, .diagonal)
        return .ok(board.getNbElements(cmp: >=, for: 2))
    }
    
    public static let shared = Ex05()
}
