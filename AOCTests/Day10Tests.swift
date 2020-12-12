//
//  Day10Tests.swift
//  AOCTests
//
//  Created by Apple  on 12/12/2020.
//

import XCTest

class Day10Tests: XCTestCase {
    
    let exampleData1 = """
    28
    33
    18
    42
    31
    14
    46
    20
    48
    47
    24
    23
    49
    45
    19
    38
    39
    11
    1
    32
    25
    35
    8
    17
    7
    9
    4
    2
    34
    10
    3
    """
    
    
    func testPart1Example() {
        XCTAssertEqual(Day10.getNumbersInt(from: exampleData1), 220)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day10.generatePart1Value(), 2432)
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day10.calculateValue(data: exampleData1), 19208)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day10.generatePart2Value(), 453551299002368)
    }
}
