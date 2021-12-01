//
//  01.swift
//  
//
//  Created by Antonin on 21/11/2021.
//

import Foundation
import XCTest

class Ex01: Exercise {
    var name: String = "01"
   
    typealias InputPart1 = [Int]
    typealias InputPart2 = [Int]
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
            let input: Result<[Int?]> = try getInput(from: from, encodeFrom: toInt)
            switch input {
            case .ok(let anyDepths):
                return self.part1(value: anyDepths.compactMap{ $0 })
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
            let input: Result<[Int?]> = try getInput(from: from, encodeFrom: toInt)
            switch input {
            case .ok(let anyDepths):
                return self.part2(value: anyDepths.compactMap{ $0 })
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value depths: [Int]) -> Result<Int> {
        if depths.count == 0 {
            return .ok(0)
        }
        var previousMeasure: Int = depths[0]
        var count = 0
        for measure in depths[1...] {
            if measure > previousMeasure {
                count += 1
            }
            previousMeasure = measure
        }
        return .ok(count)
    }
    
    internal func part2(value depths: [Int]) -> Result<Int> {
        let slidingWindowLength = 3
        if depths.count < slidingWindowLength {
            return .ok(0)
        }
        var slidingWindow: [Int] = [depths[0], depths[1], depths[2]]
        var previousMeasure = slidingWindow.reduce(0, +)
        var count = 0
        var slidingIndex = 0
        for measure in depths[slidingWindowLength...] {
            slidingWindow[slidingIndex % slidingWindowLength] = measure
            slidingIndex += 1
            let newMeasure = slidingWindow.reduce(0, +)
            if newMeasure > previousMeasure {
                count += 1
            }
            previousMeasure = newMeasure
        }
        return .ok(count)
    }
    
    public static let shared = Ex01()
}
