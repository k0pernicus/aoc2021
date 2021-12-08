//
//  08.swift
//
//
//  Created by Antonin on 08/12/2021.
//

import Foundation
import XCTest

class Ex08: Exercise {
    var name: String = "08"
   
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
            case .ok(let input):
                return self.part1(value: input)
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
            case .ok(let input):
                return self.part2(value: input)
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value input: [String]) -> Result<Int> {
        let uniqueNumbersSegments: Set<Int> = [1, 4, 7, 8]
        var sum = 0
        for line in input {
            let data = line.split(separator: "|")
            if data.count != 2 {
                continue
            }
            let outputValues = data[1].split(separator: " ")
            sum += outputValues.filter({ uniqueNumbersSegments.contains($0.count)  }).count
        }
        return .ok(sum)
    }
    
    internal func part2(value input: [String]) -> Result<Int> {
        var outputs: [Int] = []
        for line in input {
            let data = line.split(separator: "|")
            if data.count != 2 {
                continue
            }
            let inputValues: [Set<Character>] = data[0].split(separator: " ").map({ Set(Array($0)) })
            var digitsMapping: [Int: Set<Character>] = [:]
            var fiveLengthNumbers: [Set<Character>] = []
            var sixLengthNumbers: [Set<Character>] = []
            for value in inputValues {
                switch value.count {
                case 2: digitsMapping[1] = value
                case 3: digitsMapping[7] = value
                case 4: digitsMapping[4] = value
                case 7: digitsMapping[8] = value
                case 5: fiveLengthNumbers.append(value)
                case 6: sixLengthNumbers.append(value)
                default: print("Warning: \(value) not found...")
                }
            }
            for fiveLengthNumber in fiveLengthNumbers {
                if (fiveLengthNumber.intersection(digitsMapping[1]!)).count == 1 && (fiveLengthNumber.intersection(digitsMapping[4]!).count == 2) {
                    digitsMapping[2] = fiveLengthNumber
                    continue
                }
                if (fiveLengthNumber.intersection(digitsMapping[7]!)).count == 3 {
                    digitsMapping[3] = fiveLengthNumber
                    continue
                }
                digitsMapping[5] = fiveLengthNumber
            }
            for sixLengthNumber in sixLengthNumbers {
                if (sixLengthNumber.intersection(digitsMapping[1]!)).count == 1 {
                    digitsMapping[6] = sixLengthNumber
                    continue
                }
                if (sixLengthNumber.intersection(digitsMapping[4]!)).count == 4 {
                    digitsMapping[9] = sixLengthNumber
                    continue
                }
                digitsMapping[0] = sixLengthNumber
            }
            // Now, process the output
            let reverseMapping: [Set<Character>: Int] = digitsMapping.reduce(into: [:], { accumulator, register in accumulator[register.value] = register.key })
            let outputValues: [Set<Character>] = data[1].split(separator: " ").map({ Set(Array($0)) })
            outputs.append(Int(outputValues.map({ String(reverseMapping[$0]!) }).joined())!)
        }
        return .ok(outputs.reduce(0, +))
    }
    
    public static let shared = Ex08()
}
