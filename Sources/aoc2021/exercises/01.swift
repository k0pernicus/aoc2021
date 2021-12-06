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
            let input: Result<[Int?]> = try getInput(from: from, encodeTo: toInt)
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
            let input: Result<[Int?]> = try getInput(from: from, encodeTo: toInt)
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
        let count = depths[1...].indices.reduce(into: 0) { count, index in
            if depths[index] > depths[index - 1] {
                count += 1
            }
        }
        return .ok(count)
    }
    
    internal func part2(value depths: [Int]) -> Result<Int> {
        let slidingWindowLength = 3
        if depths.count < slidingWindowLength {
            return .ok(0)
        }
        let depths: [Int] = depths.indices.reduce(into: []) { slidingWindow, index in
            guard (index + slidingWindowLength - 1) < depths.count else { return }
            let window = depths[index...(index + slidingWindowLength - 1)]
            slidingWindow.append(window.reduce(0, +))
        }
        return self.part1(value: depths)
    }
    
    public static let shared = Ex01()
}
