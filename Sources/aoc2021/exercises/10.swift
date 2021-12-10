//
//  10.swift
//
//
//  Created by Antonin on 10/12/2021.
//

import Foundation
import XCTest

enum Token: Character {
    case O_PAR = "("
    case O_BRA = "{"
    case O_SQU = "["
    case O_TAG = "<"
    case E_BRA = "}"
    case E_SQU = "]"
    case E_PAR = ")"
    case E_TAG = ">"
}

let tokenMatching: [Token: Token] = [
    Token.E_PAR: Token.O_PAR,
    Token.E_BRA: Token.O_BRA,
    Token.E_SQU: Token.O_SQU,
    Token.E_TAG: Token.O_TAG,
]

struct NavigationSubsystem {
    
    var chunks: [String]
    
    init(chunks: [String]) {
        self.chunks = chunks
    }
    
    func findIllegalTokens() -> [(Int, Token)] {
        var illegalTokens: [(Int, Token)] = []
        for (chunkNumber, chunk) in self.chunks.enumerated() {
            var queue: [Token] = []
            let tokens: [Character] = Array(chunk)
            for token in tokens {
                guard let token = Token(rawValue: token) else {
                    fatalError("Token \(token) is not registered as a legal program token, should not happen...")
                }
                switch token {
                case Token.O_PAR, Token.O_BRA, Token.O_SQU, Token.O_TAG: queue.append(token)
                case Token.E_PAR, Token.E_BRA, Token.E_SQU, Token.E_TAG:
                    if queue.count == 0 {
                        illegalTokens.append((chunkNumber, token))
                        break
                    }
                    guard let match: Token = tokenMatching[token] else {
                        fatalError("Token \(token) is not registered as a legal program token, should not happen...")
                    }
                    if match != queue.removeLast() {
                        illegalTokens.append((chunkNumber, token))
                        break
                    }
                }
            }
        }
        return illegalTokens
    }
    
    mutating func filterIllegalLines() {
        let illegalLines: [Int] = self.findIllegalTokens().map { $0.0 }
        self.chunks = self.chunks.enumerated().filter { line, _ in !illegalLines.contains(line) }.map { $0.1 }
    }
    
    func completeLines() -> [[Token]] {
        var missingTokens: [[Token]] = []
        let inverseMatching = tokenMatching.reduce(into: [:], {accumulator, element in accumulator[element.1] = element.0 })
        for chunk in self.chunks {
            var queue: [Token] = []
            let tokens: [Character] = Array(chunk)
            for token in tokens {
                guard let token = Token(rawValue: token) else {
                    fatalError("Token \(token) is not registered as a legal program token, should not happen...")
                }
                switch token {
                case Token.O_PAR, Token.O_BRA, Token.O_SQU, Token.O_TAG: queue.append(token)
                case Token.E_PAR, Token.E_BRA, Token.E_SQU, Token.E_TAG: _ = queue.removeLast()
                }
            }
            missingTokens.append(queue.reversed().map { inverseMatching[$0]! })
        }
        return missingTokens
    }
    
}

class Ex10: Exercise {
    var name: String = "10"
   
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
    
    internal func part1(value input: [String]) -> Result<Int> {
        let scores: [Token: Int] = [
            Token.E_PAR: 3,
            Token.E_SQU: 57,
            Token.E_BRA: 1197,
            Token.E_TAG: 25137
        ]
        let program = NavigationSubsystem.init(chunks: input)
        let illegalTokens = program.findIllegalTokens().map({ $0.1 })
        // We can force $0! as we know that all tokens returned by
        // `findIllegalTokens` are valid
        return .ok(illegalTokens.map({ scores[$0]! }).reduce(0, +))
    }
    
    internal func part2(value input: [String]) -> Result<Int> {
        let scores: [Token: Int] = [
            Token.E_PAR: 1,
            Token.E_SQU: 2,
            Token.E_BRA: 3,
            Token.E_TAG: 4
        ]
        var program = NavigationSubsystem.init(chunks: input)
        program.filterIllegalLines()
        let missingTokens: [[Token]] = program.completeLines()
        let total = missingTokens.map({ chunk in chunk.reduce(into: 0, {accumulator, token in accumulator = accumulator * 5 + scores[token]!} )}).sorted(by: >)
        let middle = total.count % 2 == 0 ? total[(total.count / 2) - 1]: total[total.count / 2]
        return .ok(middle)
    }
    
    public static let shared = Ex10()
}
