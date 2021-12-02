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

func commandProcessor(command: String) -> (Direction, Int)? {
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

typealias OpCode = (Direction, Int)

struct World {
    var x: Int = 0
    var depth: Int = 0
    var aim: Int = 0
    
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
    
}

class Ex02: Exercise {
    var name: String = "02"
   
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
            let input: Result<[String]> = try getInput(from: from, encodeFrom: toString)
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
        var world = World()
        world.process_part1(opCodes: opCodes.compactMap { $0 })
        return .ok(abs(world.x * world.depth))
    }
    
    internal func part2(value rawCodes: [String]) -> Result<Int> {
        let opCodes = rawCodes.map { commandProcessor(command: $0) }
        var world = World()
        world.process_part2(opCodes: opCodes.compactMap { $0 })
        return .ok(abs(world.x * world.depth))
    }
    
    public static let shared = Ex02()
}
