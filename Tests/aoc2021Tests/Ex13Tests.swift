//
//  Ex13Tests.swift
//
//
//  Created by Antonin on 13/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex13Tests: XCTestCase {
    let inputTests: [String] = [
        "6,10",
        "0,14",
        "9,10",
        "0,3",
        "10,4",
        "4,11",
        "6,0",
        "6,12",
        "4,1",
        "0,13",
        "10,12",
        "3,4",
        "3,0",
        "8,4",
        "1,10",
        "2,14",
        "8,10",
        "9,0",
        "",
        "fold along y=7",
        "fold along x=5"
    ]
    
    func testHorizontalFold() throws {
        let toFind: Int = 17
        
        let input: [String] = [
            "6,10",
            "0,14",
            "9,10",
            "0,3",
            "10,4",
            "4,11",
            "6,0",
            "6,12",
            "4,1",
            "0,13",
            "10,12",
            "3,4",
            "3,0",
            "8,4",
            "1,10",
            "2,14",
            "8,10",
            "9,0",
        ]
        
        let horizontalFold: String = "fold along y=7"
        
        var origami = Origami(input: input)
        origami.fold(along: Origami.Fold(s: horizontalFold)!)
        let nbMarked = origami.getMarked(index: 1)
        
        XCTAssertEqual(nbMarked, toFind)
    }
    
    func testVerticalFold() throws {
        let toFind: Int = 16
        
        let input: [String] = [
            "6,10",
            "0,14",
            "9,10",
            "0,3",
            "10,4",
            "4,11",
            "6,0",
            "6,12",
            "4,1",
            "0,13",
            "10,12",
            "3,4",
            "3,0",
            "8,4",
            "1,10",
            "2,14",
            "8,10",
            "9,0",
        ]
        
        let horizontalFold: String = "fold along y=7"
        let verticalFold: String = "fold along x=5"
        
        var origami = Origami(input: input)
        origami.fold(along: Origami.Fold(s: horizontalFold)!)
        origami.fold(along: Origami.Fold(s: verticalFold)!)
        let nbMarked = origami.getMarked(index: 2)
        
        XCTAssertEqual(nbMarked, toFind)
    }
    
    func testPart1() throws {
        let toFind: Int = 17
        
        switch Ex13.shared.part1(value: inputTests) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testRange() throws {
        let test = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        let cut = 6
        
        let testA = test.prefix(cut).map { $0 }
        let testB = test.suffix(cut)
        XCTAssertEqual(testA.count, cut)
        XCTAssertEqual(testB.count, cut)
        XCTAssertEqual(testA, [0, 1, 2, 3, 4, 5])
        XCTAssertEqual(testB, [7, 8, 9, 10, 11, 12])
    }
    
    func testPart2() throws {
        let toFind: Int = 0
        
        switch Ex13.shared.part2(value: inputTests) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
}
