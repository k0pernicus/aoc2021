//
//  09.swift
//
//
//  Created by Antonin on 09/12/2021.
//

import Foundation
import XCTest

func findAdjacentHeights(heightmap: [[Int]], cPosition: (Int, Int), maxX: Int, maxY: Int) -> [Int] {
    let (x, y) = cPosition
    let adjacentPositions: [(Int?, Int?)] = [
        (x == 0 ? nil : x - 1, y),
        (x == maxX ? nil : x + 1, y),
        (x, y == 0 ? nil : y - 1),
        (x, y == maxY ? nil : y + 1)
    ]
    let adjacentHeights: [Int?] = adjacentPositions.map({ ($0.0 == nil || $0.1 == nil) ? nil : heightmap[$0.1!][$0.0!] })
    return adjacentHeights.compactMap({ $0 })
}

func findAdjacentPositions(cPosition: (Int, Int), maxX: Int, maxY: Int) -> [(Int, Int)] {
    let (x, y) = cPosition
    let adjacentPositions: [(Int?, Int?)] = [
        (x == 0 ? nil : x - 1, y),
        (x == maxX ? nil : x + 1, y),
        (x, y == 0 ? nil : y - 1),
        (x, y == maxY ? nil : y + 1)
    ]
    let adjacentHeights: [(Int, Int)?] = adjacentPositions.map({ ($0.0 == nil || $0.1 == nil) ? nil : ($0.0!, $0.1!) })
    return adjacentHeights.compactMap({ $0 })
}

struct Point: Hashable {
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    init(position: (Int, Int)) {
        self.x = position.0
        self.y = position.1
    }
}

class Ex09: Exercise {
    var name: String = "09"
   
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
        var heightmap: [[Int]] = []
        for element in data {
            let char = Array(element)
            if char.count != 0 {
                heightmap.append(char.map { Int(String($0))! })
            }
        }
        let (maxX, maxY) = (heightmap[0].count - 1, heightmap.count - 1)
        var risks: [Int] = []
        for (y, line) in heightmap.enumerated() {
            for (x, element) in line.enumerated() {
                let adjacentHeights = findAdjacentHeights(heightmap: heightmap, cPosition: (x, y), maxX: maxX, maxY: maxY)
                if adjacentHeights.allSatisfy({ height in height > element }) { risks.append(element + 1) }
            }
        }
        return .ok(risks.count == 0 ? 0 : risks.reduce(0, +))
    }
    
    internal func part2(value data: [String]) -> Result<Int> {
        var heightmap: [[Int]] = []
        for element in data {
            let char = Array(element)
            if char.count != 0 {
                heightmap.append(char.map { Int(String($0))! })
            }
        }
        let (maxX, maxY) = (heightmap[0].count - 1, heightmap.count - 1)
        var minHeightsPositions: [(Int, Int)] = []
        for (y, line) in heightmap.enumerated() {
            for (x, element) in line.enumerated() {
                let adjacentPositions = findAdjacentPositions(cPosition: (x, y), maxX: maxX, maxY: maxY)
                if adjacentPositions.allSatisfy({ x, y in heightmap[y][x] > element }) { minHeightsPositions.append((x, y)) }
            }
        }
        // Now, find the bassins around each adjacent position
        var bassins: [Int] = []
        for minHeightPoint in minHeightsPositions {
            var visited: Set<Point> = []
            var toVisit: [(Int, Int)] = [minHeightPoint]
            while toVisit.count != 0 {
                let point = Point(position: toVisit.removeFirst())
                let cHeight = heightmap[point.y][point.x]
                if visited.contains(point) || cHeight == 9 { continue }
                visited.insert(point)
                let cAdjacentPositions = findAdjacentPositions(cPosition: (point.x, point.y), maxX: maxX, maxY: maxY)
                let newVisit = cAdjacentPositions.filter({ x, y in !visited.contains(Point(x: x, y: y)) && heightmap[y][x] != 9 })
                if newVisit.count == 0 { continue }
                newVisit.forEach({ position in toVisit.append(position) })
            }
            bassins.append(visited.count)
        }
        return .ok(bassins.sorted(by: >=)[0..<3].reduce(1, *))
    }
    
    public static let shared = Ex09()
}
