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
    
    func canBeVisited() -> Int? {
        switch self {
        case startRoute: return 1
        case endRoute: return 1
        case .small : return 1
        case .big: return nil
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
                print("route \(route) has no two destinations, should not happen...")
                continue
            }
            let (from, to): (Cave, Cave) = (Cave(name: mapper[0]), Cave(name: mapper[1]))
            var toArray = routesMapper[from] ?? []
            toArray.append(to)
            routesMapper.updateValue(toArray, forKey: from)
            var fromArray = routesMapper[to] ?? []
            fromArray.append(from)
            routesMapper.updateValue(fromArray, forKey: to)
        }
        self.routesMapper = routesMapper
    }
    
    func printD() -> Void {
        for (key, values) in self.routesMapper {
            for value in values {
                print("\(key) -> \(value)")
            }
        }
    }
    
    func route(from: Cave, to: Cave, visited: Set<Cave>, routes: [Cave], count: inout Int) {
        var newRoutes = routes
        newRoutes.append(from)
        if (to == endRoute) {
            count += 1
            return
        }
        if visited.contains(from) && from.canBeVisited() ?? 0 == 1 { return }
        var newVisited = visited
        newVisited.insert(from)
        (self.routesMapper[to] ?? [])
            .filter { cave in !newVisited.contains(cave) || cave.canBeVisited() == nil }
            .forEach{ destination in
                return self.route(from: to, to: destination, visited: newVisited, routes: newRoutes, count: &count)
            }
    }
    
    func findNbRoutes() -> Int {
        if self.routesMapper[startRoute]?.count == 0 {
            return 0
        }
        var count = 0
        for destination in self.routesMapper[startRoute] ?? [] {
            let visited: Set<Cave> = []
            route(from: startRoute, to: destination, visited: visited, routes: [], count: &count)
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
        let nbRoutes = map.findNbRoutes()
        return .ok(nbRoutes)
    }
    
    internal func part2(value input: [String]) -> Result<Int> {
        return .ok(0)
    }
    
    public static let shared = Ex12()
}

