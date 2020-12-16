//
//  Day11Tests.swift
//  AOCTests
//
//  Created by Apple  on 12/12/2020.
//

import XCTest

class Day12Tests: XCTestCase {

    let data = """
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
    """

    func testPart1Example() {
        XCTAssertEqual(Day11.applyBasicSeatingRules(data: data, version: .version1), 37)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day11.generatePart1Value(), 2183)
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day11.applyBasicSeatingRules(data: data, version: .version2), 26)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day11.generatePart2Value(), 1990)
    }
}
