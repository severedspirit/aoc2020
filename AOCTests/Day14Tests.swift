//
//  Day14Tests.swift
//  AOCTests
//
//  Created by Apple  on 20/12/2020.
//

import XCTest

class Day14Tests: XCTestCase {
    
    static let data = """
    mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
    mem[8] = 11
    mem[7] = 101
    mem[8] = 0
    """
    
    static let data2 = """
    mask = 000000000000000000000000000000X1001X
    mem[42] = 100
    mask = 00000000000000000000000000000000X0XX
    mem[26] = 1
    """

    func testPart1Example() {
        XCTAssertEqual(Day14.computeValue(from: Self.data), 165)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day14.generatePart1Value(), 17765746710228)
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day14.executeV2(from: Self.data2), 208)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day14.generatePart2Value(), 4401465949086)
    }
}
