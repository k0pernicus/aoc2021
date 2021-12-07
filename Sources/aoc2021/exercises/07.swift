//
//  07.swift
//
//
//  Created by Antonin on 07/12/2021.
//

import Foundation
import XCTest

class Ex07: Exercise {
    var name: String = "07"
   
    typealias InputPart1 = String
    typealias InputPart2 = String
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
            let result: Result<[String]> = try getInput(from: from)
            switch result {
            case .ok(let input):
                return self.part1(value: input[0])
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
            let result: Result<[String]> = try getInput(from: from)
            switch result {
            case .ok(let input):
                return self.part2(value: input[0])
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value input: String) -> Result<Int> {
        let positions: [Int: Int] = input.split(separator: ",").reduce(into: [:], { accumulator, position in
            let pos = Int(position)!;
            accumulator.updateValue((accumulator[pos] ?? 0) + 1, forKey: pos)
        })
        let sortedPositions = positions.sorted(by: { $0.1 > $1.1 }).filter { $0.1 > 1 }.map { $0.0 }
        if sortedPositions.count == 0 { return .ok(0) }
        var minFuel: Int? = nil
        let crabs: [Int] = input.split(separator: ",").reduce(into: [], { accumulator, position in accumulator.append(Int(position)!) })
        for cPosition in sortedPositions {
            let cSum = crabs.map { abs($0 - cPosition) }.reduce(0, +)
            if minFuel == nil || minFuel! > cSum { minFuel = cSum }
        }
        guard let fuel = minFuel else { return .error("no fuel found") }
        return .ok(fuel)
    }
    
    internal func part2(value input: String) -> Result<Int> {
        let crabs: [Int] = input.split(separator: ",").reduce(into: [], { accumulator, position in accumulator.append(Int(position)!) })
        let mean = Int(round(Double(crabs.reduce(0, +)) / Double(crabs.count)))
        var minFuel: Int? = nil
        // Range around the mean value to find the optimum... -1 / +1 should be enough for most cases
        for cPosition in mean-1...mean+1 {
            let cSum = crabs.map { (0...abs($0 - cPosition)).reduce(0, +) }.reduce(0, +)
            if minFuel == nil || cSum < minFuel! { minFuel = cSum }
        }
        guard let fuel = minFuel else { return .error("no fuel found") }
        return .ok(fuel)
    }
    
    public static let shared = Ex07()
}
