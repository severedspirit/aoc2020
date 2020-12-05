//
//  Day05Tests.swift
//  AOCTests
//
//  Created by Apple  on 05/12/2020.
//

import XCTest

class Day05Tests: XCTestCase {

    func testPart1Example() {
        XCTAssertEqual(Day05.generateLocation(from: "BFFFBBFRRR").row, 70)
        XCTAssertEqual(Day05.generateLocation(from: "BFFFBBFRRR").column, 7)
        XCTAssertEqual(Day05.generateLocation(from: "BFFFBBFRRR").id, 567)
        
        XCTAssertEqual(Day05.generateLocation(from: "FFFBBBFRRR").row, 14)
        XCTAssertEqual(Day05.generateLocation(from: "FFFBBBFRRR").column, 7)
        XCTAssertEqual(Day05.generateLocation(from: "FFFBBBFRRR").id, 119)
        
        XCTAssertEqual(Day05.generateLocation(from: "BBFFBBFRLL").row, 102)
        XCTAssertEqual(Day05.generateLocation(from: "BBFFBBFRLL").column, 4)
        XCTAssertEqual(Day05.generateLocation(from: "BBFFBBFRLL").id, 820)
    }
    
    
    func testPart1Result() {
        XCTAssertEqual(Day05.generatePart1Value(), 838)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day05.generatePart2Value(), 714)
    }
}
