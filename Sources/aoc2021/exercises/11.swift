//
//  11.swift
//
//
//  Created by Antonin on 11/12/2021.
//

import Foundation
import XCTest

struct Grid {
    
    var energyLevels: [[Int]]
    var maxX: Int {
        return energyLevels.count == 0 ? 0 : energyLevels[0].count - 1
    }
    var maxY: Int {
        return energyLevels.count - 1
    }
    
    init(levels: [[Int]]) {
        self.energyLevels = levels
    }
    
    func printLevels(_ step: Int) {
        print("-> \(step)")
        for y in 0...self.maxY {
            for x in 0...self.maxX {
                print(self.energyLevels[y][x], terminator: " ")
            }
            print()
        }
        print()
    }
    
    mutating func step(_ step: Int) -> Int {
        if self.maxY == 0 {
            return 0
        }
        var positionsToCheck: [Point] = []
        for y in 0...self.maxY {
            for x in 0...self.maxX {
                positionsToCheck.append(Point(x: x, y: y))
            }
        }
        var visited: Set<Point> = []
        while positionsToCheck.count > 0 {
            let point = positionsToCheck.removeFirst()
            self.energyLevels[point.y][point.x] += 1
            if self.energyLevels[point.y][point.x] > 9 && !visited.contains(point) {
                visited.insert(point)
                for adjacentPosition in findFullAdjacentPositions(cPosition: (point.x, point.y), maxX: self.maxX, maxY: self.maxY) {
                    if !visited.contains(Point(position: adjacentPosition)) {
                        positionsToCheck.append(Point(position: adjacentPosition))
                    }
                }
            }
        }
        var totalFlashes = 0
        for (y, line) in self.energyLevels.enumerated() {
            for (x, element) in line.enumerated() {
                if element > 9 {
                    self.energyLevels[y][x] = 0
                    totalFlashes += 1
                }
            }
        }
        return totalFlashes
    }
    
}

class Ex11: Exercise {
    var name: String = "11"
   
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
        var levels: [[Int]] = []
        for element in data {
            let char = Array(element)
            if char.count != 0 {
                levels.append(char.map { Int(String($0))! })
            }
        }
        var grid = Grid.init(levels: levels)
        var totalLights = 0
        for step in 0..<100 {
            totalLights += grid.step(step)
        }
        return .ok(totalLights)
    }
    
    internal func part2(value data: [String]) -> Result<Int> {
        var levels: [[Int]] = []
        for element in data {
            let char = Array(element)
            if char.count != 0 {
                levels.append(char.map { Int(String($0))! })
            }
        }
        var grid = Grid.init(levels: levels)
        var step = 0
        while !grid.energyLevels.flatMap({ $0 }).allSatisfy({$0 == 0}) {
            _ = grid.step(step)
            step += 1
        }
        return .ok(step)
    }
    
    public static let shared = Ex11()
}
