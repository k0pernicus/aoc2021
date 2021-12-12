//
//  12.swift
//  
//
//  Created by Antonin on 12/12/2021.
//

import Foundation
import XCTest

let startRoute: Cave = Cave(name: "start")
let endRoute: Cave = Cave(name: "end")

enum Cave: Hashable {
    case small(String)
    case big(String)
    
    init(name: String) {
        self = name.isLowercase ? .small(name) : .big(name)
    }
    
    init(name: Substring) {
        self = name.isLowercase ? .small(String(name)) : .big(String(name))
    }
    
    func name() -> String {
        switch self {
        case .small(let name): return name
        case .big(let name): return name
        }
    }
    
    // TODO: Pass the default value for .small as parameter
    func canBeVisited(defaultSmallValue: Int = 1) -> Int? {
        switch self {
        case startRoute, endRoute: return 1
        case .small: return defaultSmallValue
        case .big: return nil
        }
    }
    
    func isBig() -> Bool {
        switch self {
        case startRoute, endRoute, .small: return false
        default: return true
        }
    }
}

struct Map {
    let routesMapper: [Cave: [Cave]]
    
    init(input: [String]) {
        var routesMapper: [Cave: [Cave]] = [:]
        for route in input {
            let mapper = route.split(separator: "-")
            if mapper.count != 2 {
                continue
            }
            let (from, to): (Cave, Cave) = (Cave(name: mapper[0]), Cave(name: mapper[1]))
            // Obliged to do the X <-> Y stuff as the input
            // is not directed...
            var toArray = routesMapper[from] ?? []
            toArray.append(to)
            routesMapper.updateValue(toArray, forKey: from)
            var fromArray = routesMapper[to] ?? []
            fromArray.append(from)
            routesMapper.updateValue(fromArray, forKey: to)
        }
        self.routesMapper = routesMapper
    }
    
    /// Recursive function to find all paths here
    func traverse(from: Cave, to: Cave, visited: Set<Cave>, count: inout Int) {
        if (to == endRoute) { count += 1; return }
        if visited.contains(from) && from.canBeVisited() ?? 0 == 1 { return }
        var newVisited = visited
        newVisited.insert(from)
        (self.routesMapper[to] ?? [])
            .filter { cave in !newVisited.contains(cave) || cave.canBeVisited() == nil }
            .forEach{ destination in
                return self.traverse(from: to, to: destination, visited: newVisited, count: &count)
            }
    }
    
    /// Recursive function to find all paths here
    func traverseLoop(from: Cave, to: Cave, visited: [Cave: Int], count: inout Int) {
        // Only one small can be visited twice - check this before
        if !from.isBig() {
            // Check if at least one small value has been visited twice
            let smallVisited = visited.filter({ !$0.0.isBig() }).values.contains(2)
            // Stop if the current node has been visited already
            if visited[from] != nil && smallVisited && visited[from]! >= 1 { return }
        }
        if (to == endRoute) { count += 1; return }
        var newVisited = visited
        newVisited.updateValue((visited[from] ?? 0) + 1, forKey: from)
        (self.routesMapper[to] ?? [])
            .filter { cave in newVisited[cave] == nil || cave.canBeVisited() == nil || newVisited[cave]! < cave.canBeVisited(defaultSmallValue: 2)! }
            .forEach{ destination in
                return self.traverseLoop(from: to, to: destination, visited: newVisited, count: &count)
            }
    }
    
    func findNbRoutesNoLoop() -> Int {
        if self.routesMapper[startRoute]?.count == 0 {
            return 0
        }
        var count = 0
        for destination in self.routesMapper[startRoute] ?? [] {
            let visited: Set<Cave> = []
            traverse(from: startRoute, to: destination, visited: visited, count: &count)
        }
        return count
    }
    
    func findNbRoutesWithOneLoop() -> Int {
        if self.routesMapper[startRoute]?.count == 0 {
            return 0
        }
        var count = 0
        for destination in self.routesMapper[startRoute] ?? [] {
            let visited: [Cave: Int] = [:]
            traverseLoop(from: startRoute, to: destination, visited: visited, count: &count)
        }
        return count
    }
}

class Ex12: Exercise {
    var name: String = "12"
   
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
        let map = Map(input: input)
        let nbRoutes = map.findNbRoutesNoLoop()
        return .ok(nbRoutes)
    }
    
    internal func part2(value input: [String]) -> Result<Int> {
        let map = Map(input: input)
        let nbRoutes = map.findNbRoutesWithOneLoop()
        return .ok(nbRoutes)
    }
    
    public static let shared = Ex12()
}

