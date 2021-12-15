//
//  15.swift
//  
//
//  Created by Antonin on 15/12/2021.
//

import Foundation
import XCTest

class Ex15: Exercise {
    var name: String = "15"
   
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
    
    internal func part1(value weights: [String]) -> Result<Int> {
        if weights.count == 0 {
            return .ok(0)
        }
        let weights = weights.filter({ $0.count > 0 })
        let maxY = weights.count - 1
        let maxX = weights[0].count - 1
        let grid: [[Point]] = weights.enumerated().map { x, line in line.enumerated().map{ y, _ in Point(x: x, y: y) } }
        let (departure, arrival) = (grid[0][0], grid[maxY][maxX])
        var visited: Set<Point> = []
        var toVisit: [Point] = [departure]
        var paths: [[Int?]] = Array(repeating: Array(repeating: nil, count: maxX + 1), count: maxY + 1)
        while toVisit.count > 0 {
            let cVisit = toVisit.removeFirst()
            if visited.contains(cVisit) {
                continue
            }
            visited.insert(cVisit)
            if cVisit == arrival {
                continue
            }
            let cWeight = weights[cVisit.y][cVisit.x]
            let existingWeight = paths[cVisit.y][cVisit.x] ?? 0
            let adjacentPositions = findAdjacentPositions(cPosition: (cVisit.x, cVisit.y), maxX: maxX, maxY: maxY)
                .filter({ !visited.contains(Point(position: $0)) })
            for adjacentPosition in adjacentPositions {
                let (x, y) = adjacentPosition
                paths[y][x] = paths[y][x] == nil ? Int(cWeight)! + existingWeight : min(paths[y][x]!, Int(cWeight)! + existingWeight)
                toVisit.append(Point(position: adjacentPosition))
            }
        }
        guard let result = paths[arrival.y][arrival.x] else {
            fatalError("never arrived to the end (nil), should not happen")
        }
        return .ok(result - Int(weights[0][0])!)
    }
    
    internal func part2(value weights: [String]) -> Result<Int> {
        if weights.count == 0 {
            return .ok(0)
        }
        let nbMaps: Int = 5
        let weights = weights.filter({ $0.count > 0 })
        let maxY = weights.count - 1
        let maxX = weights[0].count - 1
        let maxGridX = ((maxX + 1) * nbMaps) - 1
        let maxGridY = ((maxY + 1) * nbMaps) - 1
        let (departure, arrival) = (Point(x: 0, y: 0), Point(x: maxGridX, y: maxGridY))
        var visited: Set<Point> = []
        var toVisit: [Point] = [departure]
        var paths: [[Int?]] = Array(repeating: Array(repeating: nil, count: maxGridX + 1), count: maxGridY + 1)
        while toVisit.count > 0 {
            let cVisit = toVisit.removeFirst()
            if visited.contains(cVisit) {
                continue
            }
            if cVisit == arrival {
                continue
            }
            visited.insert(cVisit)
            // Position in the map
            let px: Int = cVisit.x % weights[0].count
            let py: Int = cVisit.y % weights.count
            // The map
            let mx: Int = cVisit.x / weights[0].count
            let my: Int = cVisit.y / weights.count
            var cWeight = mx + my + Int(weights[py][px])!
            if cWeight > 9 {
                cWeight = cWeight % 9
            }
            let existingWeight = paths[cVisit.y][cVisit.x] ?? 0
            let adjacentPositions = findAdjacentPositions(cPosition: (cVisit.x, cVisit.y), maxX: maxGridX, maxY: maxGridY)
                .filter({ !visited.contains(Point(position: $0)) })
            for adjacentPosition in adjacentPositions {
                let (x, y) = adjacentPosition
                paths[y][x] = paths[y][x] == nil ? cWeight + existingWeight : min(paths[y][x]!, cWeight + existingWeight)
                toVisit.append(Point(position: adjacentPosition))
            }
        }
        guard let result = paths[arrival.y][arrival.x] else {
            fatalError("never arrived to the end (nil), should not happen")
        }
        return .ok(result - Int(weights[0][0])!)
    }
    
    public static let shared = Ex15()
}
