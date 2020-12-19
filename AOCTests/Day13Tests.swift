//
//  Day13Tests.swift
//  AOCTests
//
//  Created by Apple  on 19/12/2020.
//

import XCTest

class Day13Tests: XCTestCase {

    func testPart1Example() {
        let data = """
        939
        7,13,x,x,59,x,31,19
        """
        XCTAssertEqual(Day13.getSmallestBusGrouping(from: data), 295)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day13.generatePart1Value(), 4938)
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day13.getAlignmentRow(from: "\n1789,37,47,1889"), 1202161486)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day13.generatePart2Value(), 230_903_629_977_901)
    }
}
