//
//  Day08Tests.swift
//  AOCTests
//
//  Created by Apple  on 08/12/2020.
//

import XCTest

class Day08Tests: XCTestCase {
    

    
    func testPart1Example() {
        
        let data = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """
        XCTAssertEqual(Day08.getValue(from: data).0, 5)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day08.generatePart1Value(), 1137)
    }
    
    func testPart2Example() {
        let data = """
        nop +0
        acc +1
        jmp +4
        acc +3
        jmp -3
        acc -99
        acc +1
        jmp -4
        acc +6
        """
        XCTAssertEqual(Day08.getAttemptAccumulationFix(data), 8)
    }

    func testPart2Result() {
        XCTAssertEqual(Day08.generatePart2Value(), 1125)
    }
}
