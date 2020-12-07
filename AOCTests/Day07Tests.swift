//
//  Day07Tests.swift
//  AOCTests
//
//  Created by Apple  on 07/12/2020.
//

import XCTest

class Day07Tests: XCTestCase {
    
    let data1 = """
    light red bags contain 1 bright white bag, 2 muted yellow bags.
    dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    bright white bags contain 1 shiny gold bag.
    muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
    shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
    dark olive bags contain 3 faded blue bags, 4 dotted black bags.
    vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
    faded blue bags contain no other bags.
    dotted black bags contain no other bags.
    """
    let data2 = """
    shiny gold bags contain 2 dark red bags.
    dark red bags contain 2 dark orange bags.
    dark orange bags contain 2 dark yellow bags.
    dark yellow bags contain 2 dark green bags.
    dark green bags contain 2 dark blue bags.
    dark blue bags contain 2 dark violet bags.
    dark violet bags contain no other bags.
    """
    
    func testPart1Example1() {
        XCTAssertEqual(Day07.getBagsThatCanContainGold(data: data1), 4)
    }

    func testPart1Result() {
        XCTAssertEqual(Day07.generatePart1Value(), 242)
    }
    
    func testPart2Example1() {
        XCTAssertEqual(Day07.getBagsRequiredForShiny(from: data1), 32)
    }
    
    func testPart2Example2() {
        XCTAssertEqual(Day07.getBagsRequiredForShiny(from: data2), 126)
    }

    func testPart2Result() {
        XCTAssertEqual(Day07.generatePart2Value(), 176035)
    }
}
