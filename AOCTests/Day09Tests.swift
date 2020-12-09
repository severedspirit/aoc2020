//
//  Day09Tests.swift
//  AOCTests
//
//  Created by Apple  on 09/12/2020.
//

import XCTest

class Day09Tests: XCTestCase {
    let data = """
    35
    20
    15
    25
    47
    40
    62
    55
    65
    95
    102
    117
    150
    182
    127
    219
    299
    277
    309
    576
    """
    
    func testPart1Example() {
        XCTAssertEqual(Day09.getInvalidNumber(from: data, subsetLength: 5), 127)
    }

    func testPart1Result() {
        XCTAssertEqual(Day09.generatePart1Value(), 50047984)
    }
    
    func testPart2Example() {
        let invalidNumber = Day09.getInvalidNumber(from: data, subsetLength: 5)
        XCTAssertEqual(Day09.getEncryptionWeakness(from: data, invalidNumber: invalidNumber), 62)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day09.generatePart2Value(), 5407707)
    }
}
