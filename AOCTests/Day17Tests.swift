//
//  Day17Tests.swift
//  AOCTests
//
//  Created by Apple  on 25/12/2020.
//

import XCTest

class Day17Tests: XCTestCase {

    static let example = """
    .#.
    ..#
    ###
    """

    func testPart1Example() {
        XCTAssertEqual(Day17.generateValue(from: Self.example, for: .three), 112)
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day17.generateValue(from: Self.example, for: .four), 848)
    }

    func testPart1Result() {
        XCTAssertEqual(Day17.generatePart1Value(), 386)
    }

    func testPart2Result() {
        XCTAssertEqual(Day17.generatePart2Value(), 2276)
    }
}
