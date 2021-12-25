//
//  25.swift
//  
//
//  Created by antonin on 26/12/2021.
//

import Foundation

class Ex25: Exercise {
    var name: String = "25"
   
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
    
    enum Region {
        case east
        case south
        case none
    }
    
    private func next(entryPoint: Int, max: Int) -> Int {
        var next = entryPoint + 1
        if next < 0 {
            next = max
        } else if next >= max {
            next = 0
        }
        return next
    }
    
    internal func parseInput(data: [String]) -> [[Region]] {
        var regions: [[Region]] = []
        for line in data {
            let line = line.trimmingCharacters(in: .whitespacesAndNewlines)
            if line.count == 0 {
                continue
            }
            let characters = Array(line)
            let region: [Region] = characters.map {
                switch $0 {
                case ">": return .east
                case "v": return .south
                default: return .none
                }
            }
            regions.append(region)
        }
        return regions
    }
    
    internal func round(regions: [[Region]]) -> [[Region]] {
        var eastRegions = regions
        let maxY = regions.count
        let maxX = regions[0].count
        // Move east
        for (y, line) in regions.enumerated() {
            for (x, cucumber) in line.enumerated() {
                if cucumber != .east {
                    continue
                }
                let nextX = next(entryPoint: x, max: maxX)
                if regions[y][nextX] == .none {
                    eastRegions[y][nextX] = cucumber
                    eastRegions[y][x] = .none
                }
            }
        }
        var southRegions = eastRegions
        for (y, line) in eastRegions.enumerated() {
            for (x, cucumber) in line.enumerated() {
                if cucumber != .south {
                    continue
                }
                let nextY = next(entryPoint: y, max: maxY)
                if eastRegions[nextY][x] == .none {
                    southRegions[nextY][x] = cucumber
                    southRegions[y][x] = .none
                }
            }
        }
        // Move south
        return southRegions
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
        var regions = parseInput(data: data)
        var roundNumber = 1
        while true {
            let newRegions = round(regions: regions)
            if newRegions == regions {
                break
            }
            regions = newRegions
            roundNumber += 1
        }
        return .ok(roundNumber)
    }
    
    internal func part2(value data: [String]) -> Result<Int> {
        return .ok(0)
    }
    
    public static let shared = Ex25()
}
