//
//  17.swift
//
//
//  Created by Antonin on 17/12/2021.
//

import Foundation
import XCTest

/// Returns if, based on velocity at time `t`, the probe reaches the land (specified by coordinates
/// `landX` and `landY`, or not.
private func reachedLand(velocity: (Int, Int), landX: (Int, Int), landY: (Int, Int)) -> Bool {
    var velocity = velocity
    var probePosition: (Int, Int) = (0, 0)
    let minY = min(landY.0, landY.1)
    let maxY = max(landY.0, landY.1)
    var maxHeight = 0
    while true {
        maxHeight = max(maxHeight, probePosition.1)
        // Probe traversed the land...
        if probePosition.0 > landX.1 || (velocity.1 < 0 && probePosition.1 < minY) {
            return false
        }
        // Probe reached the land
        if landX.0 <= probePosition.0 && probePosition.0 <= landX.1 && minY <= probePosition.1 && probePosition.1 <= maxY {
            return true
        }
        probePosition.0 += velocity.0
        probePosition.1 += velocity.1
        var c = 0
        if velocity.0 != 0 {
            c = probePosition.0 / abs(probePosition.0)
        }
        velocity.0 -= c
        velocity.1 -= 1
    }
}

/// Returns the highest y peak based on the minimum one.
/// We can compute it by: `y + (y-1) + (y-2) + ... + 1`, which can be represented by
/// the following formula: `(y * y-1) / 2`
private func findMaxHeight(minY: Int) -> Int {
    return (minY * (minY + 1)) / 2
}

class Ex17: Exercise {
    var name: String = "17"
   
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
    
    static func parseInput(input: String) -> ((Int, Int), (Int, Int))? {
        if input.count == 0 {
            return nil
        }
        var data = input.split(separator: " ")[2...]
        if data.count != 2 {
            return nil
        }
        let fstData = data.removeFirst()
        let sndData = data.removeFirst()
        let x = fstData.substring(from: fstData.index(fstData.startIndex, offsetBy: 2)).dropLast()
        let y = sndData.substring(from: sndData.index(sndData.startIndex, offsetBy: 2))
        let xRange = x.components(separatedBy: "..").map { Int($0)! }
        let yRange = y.components(separatedBy: "..").map { Int($0)! }
        if xRange.count != 2 || yRange.count != 2 {
            return nil
        }
        return ((xRange[0], xRange[1]), (yRange[0], yRange[1]))
    }
    
    internal func part1(from: String) -> Result<Int> {
        do {
            let data: Result<[String]> = try getInput(from: from)
            switch data {
            case .ok(let data):
                return self.part1(value: data[0])
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
                return self.part2(value: data[0])
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value data: String) -> Result<Int> {
        guard let ((_), (y1, y2)) = Ex17.parseInput(input: data) else {
            return .error("Cannot parse input")
        }
        return .ok(findMaxHeight(minY: min(y1, y2)))
    }
    
    internal func part2(value data: String) -> Result<Int> {
        guard let ((x1, x2), (y1, y2)) = Ex17.parseInput(input: data) else {
            return .error("Cannot parse input")
        }
        let maxY = max(abs(y1), abs(y2))
        var positions = 0
        let xBoundMin: Int = min(x2 + (x2/abs(x2)), 0)
        let xBoundMax: Int = max(x2 + (x2/abs(x2)), 0)
        // Filter the initial velocity values
        for x in xBoundMin...xBoundMax {
            for y in (-maxY - 1)...(maxY + 1) {
                if reachedLand(velocity: (x, y), landX: (x1, x2), landY: (y1, y2)) { positions += 1 }
            }
        }
        return .ok(positions)
    }
    
    public static let shared = Ex17()
}
