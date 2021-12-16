//
//  Ex16Tests.swift
//
//
//  Created by Antonin on 16/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex16Tests: XCTestCase {
    func testParseLiteral() throws {
        let inputTest: String = "D2FE28"
        switch Ex16.shared.part1(value: inputTest) {
        case .ok(let count):
            XCTAssertEqual(count, 6)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testParseOperator() throws {
        let inputTests: [String: Int] = [
            "38006F45291200": 9,
            "EE00D40C823060": 14,
        ]
        for (input, result) in inputTests {
            switch Ex16.shared.part1(value: input) {
            case .ok(let count):
                XCTAssertEqual(count, result)
            case .error(let err):
                print("Error for part1: \(err)")
                XCTFail()
            }
        }
    }
    
    func testPart1() throws {
        let inputTests: [String: Int] = [
            "8A004A801A8002F478": 16,
            "620080001611562C8802118E34": 12,
            "C0015000016115A2E0802F182340": 23,
            "A0016C880162017C3686B18A3D4780": 31,
        ]
        for (input, result) in inputTests {
            switch Ex16.shared.part1(value: input) {
            case .ok(let count):
                XCTAssertEqual(count, result)
            case .error(let err):
                print("Error for part1: \(err)")
                XCTFail()
            }
        }
    }
    
    func testPart2() throws {
        let inputTests: [String: Int] = [
            "C200B40A82": 3,
            "04005AC33890": 54,
            "880086C3E88112": 7,
            "CE00C43D881120": 9,
            "D8005AC2A8F0": 1,
            "F600BC2D8F": 0,
            "9C005AC2F8F0": 0,
            "9C0141080250320F1802104A08": 1,
        ]
        for (input, result) in inputTests {
            switch Ex16.shared.part2(value: input) {
            case .ok(let count):
                XCTAssertEqual(count, result)
            case .error(let err):
                print("Error for part1: \(err)")
                XCTFail()
            }
        }
    }
}
