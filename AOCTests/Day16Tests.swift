//
//  Day16Tests.swift
//  AOCTests
//
//  Created by Apple  on 21/12/2020.
//

import XCTest

class Day16Tests: XCTestCase {

    static let data1 = """
    class: 1-3 or 5-7
    row: 6-11 or 33-44
    seat: 13-40 or 45-50

    your ticket:
    7,1,14

    nearby tickets:
    7,3,47
    40,4,50
    55,2,20
    38,6,12
    """
    
    
    func testPart1Example() {
        XCTAssertEqual(Day16.getErrorRate(from: Self.data1), 71)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day16.generatePart1Value(), 19240)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day16.generatePart2Value(), 21095351239483)
    }
}
