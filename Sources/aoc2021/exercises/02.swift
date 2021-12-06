//
//  02.swift
//  
//
//  Created by Antonin on 02/12/2021.
//

import Foundation
import XCTest

enum Direction: String {
    case up      = "up"
    case down    = "down"
    case forward = "forward"
}

typealias OpCode = (Direction, Int)

func commandProcessor(command: String) -> OpCode? {
    if command.isEmpty {
        return nil
    }
    let parts: [String] = command.components(separatedBy: " ")
    if parts.count != 2 {
        return nil
    }
    guard let direction = Direction(rawValue: parts[0]) else {
        return nil
    }
    guard let number = Int(parts[1]) else {
        return nil
    }
    return (direction, number)
}

struct World {
    var x: Int = 0
    var depth: Int = 0
    var aim: Int = 0
    
    var result: Int {
        return x * depth
    }
    
    mutating func process_part1(opCode: OpCode) {
        switch opCode.0 {
        case .up:
            self.depth -= opCode.1
        case .down:
            self.depth += opCode.1
        case .forward:
            self.x += opCode.1
        }
    }
    
    mutating func process_part1(opCodes: [OpCode]) {
        for opCode in opCodes {
            self.process_part1(opCode: opCode)
        }
    }
    
    mutating func process_part2(opCode: OpCode) {
        switch opCode.0 {
        case .up:
            self.aim -= opCode.1
        case .down:
            self.aim += opCode.1
        case .forward:
            self.x += opCode.1
            self.depth += (self.aim * opCode.1)
        }
    }
    
    mutating func process_part2(opCodes: [OpCode]) {
        for opCode in opCodes {
            self.process_part2(opCode: opCode)
        }
    }
    
    mutating func clear() {
        self.x = 0
        self.depth = 0
        self.aim = 0
    }
}

class Ex02: Exercise {
    var name: String = "02"
    var world: World = World()
   
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
            case .ok(let rawCodes):
                return self.part1(value: rawCodes)
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
            case .ok(let rawCodes):
                return self.part2(value: rawCodes)
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value rawCodes: [String]) -> Result<Int> {
        let opCodes = rawCodes.map { commandProcessor(command: $0) }
        self.world.clear()
        self.world.process_part1(opCodes: opCodes.compactMap { $0 })
        return .ok(self.world.result)
    }
    
    internal func part2(value rawCodes: [String]) -> Result<Int> {
        let opCodes = rawCodes.map { commandProcessor(command: $0) }
        self.world.clear()
        self.world.process_part2(opCodes: opCodes.compactMap { $0 })
        return .ok(self.world.result)
    }
    
    public static let shared = Ex02()
}
