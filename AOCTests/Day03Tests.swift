//
//  Day03Tests.swift
//  AOCTests
//
//  Created by Apple  on 03/12/2020.
//

import XCTest

class Day03Tests: XCTestCase {
    
    static let exampleData = """
    ..##.......
    #...#...#..
    .#....#..#.
    ..#.#...#.#
    .#...##..#.
    ..#.##.....
    .#.#.#....#
    .#........#
    #.##...#...
    #...##....#
    .#..#...#.#
    """

    func testPart1Example() {
        XCTAssertEqual(Day03.getTreesHit(from: .init(right: 3, down: 1), data: Self.exampleData), 7)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day03.generatePart1Value(), 220)
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day03.part2Slopes.compactMap({ Day03.getTreesHit(from: $0, data: Self.exampleData) }).reduce(1, *),336)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day03.generatePart2Value(), 2138320800)
    }
}
