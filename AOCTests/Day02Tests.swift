//
//  Day02Tests.swift
//  AOCTests
//
//  Created by Apple  on 02/12/2020.
//

import XCTest
@testable import AdventOfCode2020

class Day02Tests: XCTestCase {

    func testPart1Example() {
        XCTAssertTrue(Day02.PasswordVerification.generate(from: "1-3 a: abcde").isValid(for: .sledRental))
        XCTAssertFalse(Day02.PasswordVerification.generate(from: "1-3 b: cdefg").isValid(for: .sledRental))
        XCTAssertTrue(Day02.PasswordVerification.generate(from: "2-9 c: ccccccccc").isValid(for: .sledRental))
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day02.generatePart1Value(), 582)
    }
    
    func testPart2Example() {
        XCTAssertTrue(Day02.PasswordVerification.generate(from: "1-3 a: abcde").isValid(for: .officialToboggan))
        XCTAssertFalse(Day02.PasswordVerification.generate(from: "1-3 b: cdefg").isValid(for: .officialToboggan))
        XCTAssertFalse(Day02.PasswordVerification.generate(from: "2-9 c: ccccccccc").isValid(for: .officialToboggan))
    }
    
    func testPart2result() {
        XCTAssertEqual(Day02.generatePart2Value(), 729)
    }
}
