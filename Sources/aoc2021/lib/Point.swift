//
//  Point.swift
//  
//
//  Created by Antonin on 11/12/2021.
//

func findAdjacentHeights(heightmap: [[Int]], cPosition: (Int, Int), maxX: Int, maxY: Int) -> [Int] {
    let (x, y) = cPosition
    let adjacentPositions: [(Int?, Int?)] = [
        (x == 0 ? nil : x - 1, y),
        (x == maxX ? nil : x + 1, y),
        (x, y == 0 ? nil : y - 1),
        (x, y == maxY ? nil : y + 1)
    ]
    let adjacentHeights: [Int?] = adjacentPositions.map({ ($0.0 == nil || $0.1 == nil) ? nil : heightmap[$0.1!][$0.0!] })
    return adjacentHeights.compactMap({ $0 })
}

func findAdjacentPositions(cPosition: (Int, Int), maxX: Int, maxY: Int) -> [(Int, Int)] {
    let (x, y) = cPosition
    let adjacentPositions: [(Int?, Int?)] = [
        (x == 0 ? nil : x - 1, y),
        (x == maxX ? nil : x + 1, y),
        (x, y == 0 ? nil : y - 1),
        (x, y == maxY ? nil : y + 1)
    ]
    let adjacentHeights: [(Int, Int)?] = adjacentPositions.map({ ($0.0 == nil || $0.1 == nil) ? nil : ($0.0!, $0.1!) })
    return adjacentHeights.compactMap({ $0 })
}

func findFullAdjacentPositions(cPosition: (Int, Int), maxX: Int, maxY: Int) -> [(Int, Int)] {
    let (x, y) = cPosition
    let adjacentPositions: [(Int?, Int?)] = [
        (x == 0 ? nil : x - 1, y),
        (x == maxX ? nil : x + 1, y),
        (x, y == 0 ? nil : y - 1),
        (x, y == maxY ? nil : y + 1),
        (x == 0 ? nil : x - 1, y == 0 ? nil : y - 1),
        (x == maxX ? nil : x + 1, y == maxY ? nil : y + 1),
        (x == 0 ? nil : x - 1, y == maxY ? nil : y + 1),
        (x == maxX ? nil : x + 1, y == 0 ? nil : y - 1)
    ]
    let adjacentHeights: [(Int, Int)?] = adjacentPositions.map({ ($0.0 == nil || $0.1 == nil) ? nil : ($0.0!, $0.1!) })
    return adjacentHeights.compactMap({ $0 })
}

struct Point: Hashable {
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    init(position: (Int, Int)) {
        self.x = position.0
        self.y = position.1
    }
}

