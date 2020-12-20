//
//  Day15Tests.swift
//  AdventOfCode2020
//
//  Created by Apple  on 20/12/2020.
//

import XCTest

class Day15Tests: XCTestCase {

    func testGetMemoryGameNumber() {
        XCTAssertEqual(Day15.getMemoryGameNumber(from: "1,3,2", turnNumber: 2020), 1)
        XCTAssertEqual(Day15.getMemoryGameNumber(from: "2,1,3", turnNumber: 2020), 10)
        XCTAssertEqual(Day15.getMemoryGameNumber(from: "1,2,3", turnNumber: 2020), 27)
        XCTAssertEqual(Day15.getMemoryGameNumber(from: "2,3,1", turnNumber: 2020), 78)
        XCTAssertEqual(Day15.getMemoryGameNumber(from: "3,2,1", turnNumber: 2020), 438)
        XCTAssertEqual(Day15.getMemoryGameNumber(from: "3,1,2", turnNumber: 2020), 1836)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day15.generatePart1Value(), 1373)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day15.generatePart2Value(), 112458)
    }
}
