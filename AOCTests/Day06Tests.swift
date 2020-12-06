//
//  Day06Tests.swift
//  AOCTests
//
//  Created by Apple  on 06/12/2020.
//

import XCTest

class Day06Tests: XCTestCase {
    let data = """
    abc
    
    a
    b
    c
    
    ab
    ac
    
    a
    a
    a
    a
    
    b
    """
    
    func testPart1Example() {
        XCTAssertEqual(Day06.getTotalYesAnswers(fromAll: data), 11)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day06.generatePart1Value(), 6297)
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day06.getUnaminousYesAnswers(fromAll: data), 6)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day06.generatePart2Value(), 3158)
    }
    
}
