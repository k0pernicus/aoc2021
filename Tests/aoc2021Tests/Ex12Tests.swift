//
//  Ex12Tests.swift
//
//
//  Created by Antonin on 12/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex12Tests: XCTestCase {
    let inputTests: [([String], Int)] = [
        ([
            "start-A",
            "start-b",
            "A-c",
            "A-b",
            "b-d",
            "A-end",
            "b-end"
        ],
        10),
//        ([
//            "dc-end",
//            "HN-start",
//            "start-kj",
//            "dc-start",
//            "dc-HN",
//            "LN-dc",
//            "HN-end",
//            "kj-sa",
//            "kj-HN",
//            "kj-dc"
//        ],
//        19),
//        ([
//            "fs-end",
//            "he-DX",
//            "fs-he",
//            "start-DX",
//            "pj-DX",
//            "end-zg",
//            "zg-sl",
//            "zg-pj",
//            "pj-he",
//            "RW-he",
//            "fs-DX",
//            "pj-RW",
//            "zg-RW",
//            "start-pj",
//            "he-WI",
//            "zg-he",
//            "pj-fs",
//            "start-RW"
//        ],
//        226),
    ]
    
    func testPart1() throws {
        for inputTest in inputTests {
            let (inputTest, toFind) = inputTest
            switch Ex12.shared.part1(value: inputTest) {
            case .ok(let count):
                XCTAssertEqual(count, toFind)
            case .error(let err):
                print("Error for part1: \(err)")
                XCTFail()
            }
        }
    }
    
    func testPart2() throws {
//        let (inputTest, toFind) = inputTests[0]
//
//        switch Ex12.shared.part2(value: inputTest) {
//        case .ok(let count):
//            XCTAssertEqual(count, toFind)
//        case .error(let err):
//            print("Error for part1: \(err)")
//            XCTFail()
//        }
    }
}
