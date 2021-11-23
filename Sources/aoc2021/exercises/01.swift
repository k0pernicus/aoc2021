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
    
    private init() {
        let result = Exercises.shared.register(self.name)
        if result == .alreadyExists {
            print("exercise with name \(self.name) already exists - cannot register...")
        }
    }
    
    internal func part1(from: String) -> Result<Int> {
        do {
            let input: Result<[Int?]> = try getInput(from: from, encodeFrom: toInt)
            switch input {
            case .ok(_):
                // TODO: Process
                return .ok(0)
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
            case .ok(_):
                // TODO: Process
                return .ok(0)
            case .error(let err):
                return .error(err)
            }
        }
        catch {
            return .error("\(error)")
        }
    }
    
    internal func part1(value: Int) -> Result<Int> {
        return .ok(0)
    }
    
    internal func part2(value: Int) -> Result<Int> {
        return .ok(0)
    }
    
    public static let shared = Ex01()
}
