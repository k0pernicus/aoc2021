//
//  20.swift
//  
//
//  Created by antonin on 26/12/2021.
//

import Foundation
import CartesianProduct

class Ex20: Exercise {
    var name: String = "20"
   
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
    
    internal func parseGrid(input: [String]) -> [[Int]] {
        return input.map {
            line in Array(line.trimmingCharacters(in: .whitespacesAndNewlines)).map({ $0 == "#" ? 1 : 0 })
        }
    }
    
    internal func enhance(grid: [[Int]], map: [Character], value: Int) -> [[Int]] {
        var ans = Array(repeating: Array(repeating: 0, count: grid[0].count), count: grid.count)
        for (r, c) in product((0..<ans.count), (0..<ans[0].count)) {
            let neighbors = [(r-1, c-1), (r-1, c), (r-1,c+1), (r, c-1), (r, c), (r, c+1), (r+1, c-1), (r+1, c), (r+1,c+1)]
            let i = neighbors.reduce(into: 0, { (accumulator, v) in
                let (r, c) = v
                if r < 0 || r >= grid.count {
                    accumulator = (accumulator << 1 | value)
                    return
                }
                let row = grid[r]
                if c < 0 || c >= row.count {
                    accumulator = (accumulator << 1 | value)
                    return
                }
                accumulator = (accumulator << 1 | row[c])
            })
            ans[r][c] = map[i] == "#" ? 1 : 0
        }
        return ans
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
        let map = Array(data[0])
        var grid = parseGrid(input: data[2...].map { $0 })
        for i in 0..<2 {
            grid = enhance(grid: grid, map: map, value: i & 1)
        }
        let res = grid.flatMap({ $0 }).filter({ c in c == 1 }).count
        return .ok(res)
    }
    
    internal func part2(value data: [String]) -> Result<Int> {
        let map = Array(data[0])
        var grid = parseGrid(input: data[2...].map { $0 })
        for i in 2..<50 {
            grid = enhance(grid: grid, map: map, value: i & 1)
        }
        let res = grid.flatMap({ $0 }).filter({ c in c == 1 }).count
        return .ok(res)
    }
    
    public static let shared = Ex20()
}
