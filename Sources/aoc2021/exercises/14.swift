//
//  14.swift
//  
//
//  Created by Antonin on 14/12/2021.
//

import Foundation
import XCTest

class Ex14: Exercise {
    var name: String = "14"
   
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
    
    private func compute(data: [String], steps: Int) -> Int {
        if data.count == 0 { return 0 }
        // Initialize all pairs
        let pairs: [String: [String]] = data[1...]
            .filter({ $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 })
            .reduce(into: [:], { accumulator, pair in
                let data: [String] = pair.components(separatedBy: " -> ")
                accumulator[data[0]] = [data[0][0] + data[1], data[1] + data[0][1]]
            })
        // Initialize the first step
        var template: [String: Int] = data[0]
            .group(every: 2)
            .reduce(into: [:], {
                accumulator, pattern in accumulator.updateValue((accumulator[pattern] ?? 0) + 1, forKey: pattern)
            })
        for _ in 0..<steps {
            var update: [String: Int] = [:]
            for (key, value) in template {
                if (value == 0) { continue }
                if pairs[key] == nil || pairs[key]?.count != 2 { continue }
                pairs[key]!.forEach({ update.updateValue((update[$0] ?? 0) + value, forKey: $0) })
            }
            template = update
        }
        let letters: [String: Int] = template
            .reduce(into: [:], { (accumulator, d: (String, Int)) in
                let (key, occurences): (String, Int) = d
                accumulator.updateValue((accumulator[key[0]] ?? 0) + occurences, forKey: key[0])
                accumulator.updateValue((accumulator[key[1]] ?? 0) + occurences, forKey: key[1])
            })
            .mapValues { value in (value % 2) == 0 ? (value / 2) : (value / 2) + 1 }
        let range = letters.values.sorted(by: >)
        return range[0] - range[range.count - 1]
    }
    
    internal func part1(value data: [String]) -> Result<Int> {
        return .ok(self.compute(data: data, steps: 10))
    }
    
    internal func part2(value data: [String]) -> Result<Int> {
        return .ok(self.compute(data: data, steps: 40))
    }
    
    public static let shared = Ex14()
}
