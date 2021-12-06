//
//  03.swift
//
//
//  Created by Antonin on 03/12/2021.
//

import Foundation
import XCTest

class Ex03: Exercise {
    var name: String = "03"
   
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
            let input: Result<[String]> = try getInput(from: from)
            switch input {
            case .ok(let report):
                return self.part1(value: report)
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
            let input: Result<[String]> = try getInput(from: from)
            switch input {
            case .ok(let report):
                return self.part2(value: report)
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value report: [String]) -> Result<Int> {
        let nbOfLines = report.count
        if nbOfLines == 0 {
            return .ok(0)
        }
        var sumOfOne = Array.init(repeating: 0, count: report[0].count)
        for line in report {
            for (index, char) in line.enumerated() {
                sumOfOne[index] += char == "1" ? 1 : 0
            }
        }
        let gammaRate = sumOfOne.map( { $0 > (nbOfLines / 2) ? "1" : "0" }).joined(separator:"")
        let epsilonRate = sumOfOne.map( { $0 > (nbOfLines / 2) ? "0" : "1"}).joined(separator:"")
        guard let gamma = Int(gammaRate, radix: 2) else {
            return .error("gammaRate cannot be converted")
        }
        guard let epsilon = Int(epsilonRate, radix: 2) else {
            return .error("epsilonRate cannot be converted")
        }
        return .ok(gamma * epsilon)
    }
    
    internal func part2(value report: [String]) -> Result<Int> {
        if report.count == 0 {
            return .ok(0)
        }
        var oxygenItems: Set<String> = Set(report)
        var co2Items: Set<String> = Set(report)
        for index in 0..<report[0].count {
            if (oxygenItems.count == 1 && co2Items.count == 1) {
                break
            }
            // oxygen
            if oxygenItems.count != 1 {
                let oxyOnes: Set<String> = oxygenItems.filter({ $0[index] == "1" })
                let oxyZeros: Set<String> = oxygenItems.filter({ $0[index] == "0" })
                oxygenItems = oxygenItems.intersection(oxyOnes.count >= oxyZeros.count ? oxyOnes : oxyZeros)
            }
            // co2
            if co2Items.count != 1 {
                let co2Ones: Set<String> = co2Items.filter({ $0[index] == "1" })
                let co2Zeros: Set<String> = co2Items.filter({ $0[index] == "0" })
                co2Items = co2Items.intersection(co2Zeros.count <= co2Ones.count ? co2Zeros : co2Ones)
            }
        }
        guard let oxygen = Int(oxygenItems.first ?? "", radix: 2) else {
            return .error("oxygen cannot be converted")
        }
        guard let co2 = Int(co2Items.first ?? "", radix: 2) else {
            return .error("co2 cannot be converted")
        }
        return .ok(oxygen * co2)
    }
    
    public static let shared = Ex03()
}
