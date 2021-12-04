//
//  Ex04Tests.swift
//  
//
//  Created by Antonin on 04/12/2021.
//

import XCTest
@testable import aoc2021

final class Ex04Tests: XCTestCase {
    let bingoTest: [String] = [
        "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1",
        "",
        "22 13 17 11  0",
        "8  2 23  4 24",
        "21  9 14 16  7",
        "6 10  3 18  5",
        "1 12 20 15 19",
        "",
        "3 15  0  2 22",
        "9 18 13 17  5",
        "19  8  7 25 23",
        "20 11 10 24  4",
        "14 21 16 12  6",
        "",
        "14 21 17 24  4",
        "10 16 15  9 19",
        "18  8 23 26 20",
        "22 11 13  6  5",
        "2  0 12  3  7",
    ]
    
    func testBingoParser() throws {
        let boardTest = [
            "22 13 17 11  0",
            "8  2 23  4 24",
            "21  9 14 16  7",
            "6 10  3 18  5",
            "1 12 20 15 19",
        ]
        let allNumbers = NSMutableOrderedSet(array: [22, 13, 17, 11, 0, 8, 2, 23, 4, 24, 21, 9, 14, 16, 7, 6, 10, 3, 18, 5, 1, 12, 20, 15, 19])
        let board = BingoBoard(boardLines: boardTest)
        XCTAssert(allNumbers.isEqual(to: board.numbers))
        XCTAssert(board.rows.count == 5)
        XCTAssert(board.rows[0] == NSOrderedSet(array: [22, 13, 17, 11, 0]))
        XCTAssert(board.rows[1] == NSOrderedSet(array: [8, 2, 23, 4, 24]))
        XCTAssert(board.rows[2] == NSOrderedSet(array: [21, 9, 14, 16, 7]))
        XCTAssert(board.rows[3] == NSOrderedSet(array: [6, 10, 3, 18, 5]))
        XCTAssert(board.rows[4] == NSOrderedSet(array: [1, 12, 20, 15, 19]))
        XCTAssert(board.columns.count == 5)
        XCTAssert(board.columns[0] == NSOrderedSet(array: [22, 8, 21, 6, 1]))
        XCTAssert(board.columns[1] == NSOrderedSet(array: [13, 2, 9, 10, 12]))
        XCTAssert(board.columns[2] == NSOrderedSet(array: [17, 23, 14, 3, 20]))
        XCTAssert(board.columns[3] == NSOrderedSet(array: [11, 4, 16, 18, 15]))
        XCTAssert(board.columns[4] == NSOrderedSet(array: [0, 24, 7, 5, 19]))
    }
    
    func testParser() throws {
        guard let result = boardsParser(input: bingoTest) else {
            print("Cannot parse the board test example")
            XCTFail()
            return
        }
        let guessedNumbers = [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]
        XCTAssert(result.0 == guessedNumbers)
        XCTAssert(result.1.count == 3)
        //Bingo parser is handled in testBingoParser
    }
    
    func testPart1() throws {
        let toFind: Int = 4512
        
        switch Ex04.shared.part1(value: bingoTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part1: \(err)")
            XCTFail()
        }
    }
    
    func testPart2() throws {
        let toFind: Int = 1924
        
        switch Ex04.shared.part2(value: bingoTest) {
        case .ok(let count):
            XCTAssertEqual(count, toFind)
        case .error(let err):
            print("Error for part2: \(err)")
            XCTFail()
        }
    }
}

