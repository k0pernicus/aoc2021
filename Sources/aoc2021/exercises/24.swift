//
//  24.swift
//
//
//  Created by Antonin on 26/12/2021.
//

import Foundation
import XCTest

class Ex24: Exercise {
    var name: String = "24"
   
    typealias InputPart1 = [String]
    typealias InputPart2 = [String]
    typealias OutputPart1 = String
    typealias OutputPart2 = String
    
    private init() {
        let result = Exercises.shared.register(self.name)
        if result == .alreadyExists {
            fatalError("exercise with name \(self.name) already exists - cannot register...")
        }
    }
    
    internal func parseBlocks(data: [String]) -> [(Int, Int, Int)] {
        let data = data.filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 }
        let blocks: [(Int, Int, Int)] = data.chunked(into: 18)
            .map { block in
                let a = Int(block[4].substring(fromIndex: 6))!
                let b = Int(block[5].substring(fromIndex: 6))!
                let c = Int(block[15].substring(fromIndex: 6))!
                return (a,b,c)
            }
        return blocks
    }
    
    struct VisitBlock: Hashable {
        let index: Int
        let z: Int
        
        init(index: Int, z: Int) {
            self.index = index
            self.z = z
        }
    }
    
    internal func computeModelNumber(visited: Set<VisitBlock>, blocks: [(Int, Int, Int)], blockIndex: Int, z: Int, range: [Int]) -> Int? {
        print("blocks: \(blocks), with index \(blockIndex)")
        if blockIndex == blocks.count {
            return z == 0 ? 0 : nil
        }
        if visited.contains(VisitBlock(index: blockIndex, z: z)) {
            return nil
        }
        let (a,b,c) = blocks[blockIndex]
        print("a, b, c : \(a), \(b), \(c)")
        for i in range {
            print("computing x...")
            let x: Int = (z % 26 + (b != i ? 1 : 0))
            print("computing z (\(z))...")
            let z: Int = (z/a) * (25 * x + 1) + (i + c) * x
            print("computing number...")
            let number = computeModelNumber(visited: visited, blocks: blocks, blockIndex: blockIndex + 1, z: z, range: range)
            if number != nil {
                return number! * 10 + i
            }
        }
        var visited = visited
        visited.insert(VisitBlock(index: blockIndex, z: z))
        return nil
      }
    
    internal func part1(from: String) -> Result<String> {
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
    
    internal func part2(from: String) -> Result<String> {
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
    
    internal func part1(value data: [String]) -> Result<String> {
        let blocks = parseBlocks(data: data)
        let range = [9,8,7,6,5,4,3,2,1]
        guard let revModelNumber: Int = computeModelNumber(visited: Set([]), blocks: blocks, blockIndex: 0, z: 0, range: range) else {
            return .error("error computing the modelNumber: got nil !")
        }
        return .ok(String(revModelNumber).reversed().map({ String($0) }).joined(separator: ""))
    }
    
    internal func part2(value data: [String]) -> Result<String> {
        let blocks = parseBlocks(data: data)
        let range = [1,2,3,4,5,6,7,8,9]
        guard let revModelNumber = computeModelNumber(visited: Set([]), blocks: blocks, blockIndex: 0, z: 0, range: range) else {
            return .error("error computing the modelNumber: got nil !")

        }
        return .ok(String(revModelNumber).reversed().map({ String($0) }).joined(separator: ""))
    }
    
    public static let shared = Ex24()
}
