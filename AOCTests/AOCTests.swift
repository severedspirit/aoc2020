//
//  AOCTests.swift
//  AOCTests
//
//  Created by Apple  on 01/12/2020.
//

import XCTest

class AOCTests: XCTestCase {
    func testPart1Example() {
        XCTAssertEqual(Day01.getMultipliedValue(from: [1721, 979, 366, 299, 675, 1456], thatAddUpTo: 2020, size: 2), 514579)
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day01.getMultipliedValue(from: [1721, 979, 366, 299, 675, 1456], thatAddUpTo: 2020, size: 3), 241861950)
    }
    
    func testPart1() {
        XCTAssertEqual(Day01.generatePart1Value(), 357504)
    }
    
    func testPart2() {
        XCTAssertEqual(Day01.generatePart2Value(), 12747392)
    }
}
