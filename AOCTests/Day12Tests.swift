//
//  Day12Tests.swift
//  AOCTests
//
//  Created by Apple  on 16/12/2020.
//

import XCTest

class Day12Tests: XCTestCase {
    
    let data = """
    F10
    N3
    F7
    R90
    F11
    """

    func testGetCompassDirection_TurnRight() {
        XCTAssertEqual(Day12.Orientation.generate(from: "R")!.getCompassDirection(from: .east, rotation: -90), .north)
        XCTAssertEqual(Day12.Orientation.generate(from: "R")!.getCompassDirection(from: .east, rotation: 0), .east)
        XCTAssertEqual(Day12.Orientation.generate(from: "R")!.getCompassDirection(from: .east, rotation: 90), .south)
        XCTAssertEqual(Day12.Orientation.generate(from: "R")!.getCompassDirection(from: .east, rotation: 180), .west)
        XCTAssertEqual(Day12.Orientation.generate(from: "R")!.getCompassDirection(from: .east, rotation: 270), .north)
        XCTAssertEqual(Day12.Orientation.generate(from: "R")!.getCompassDirection(from: .east, rotation: 360), .east)
        XCTAssertEqual(Day12.Orientation.generate(from: "R")!.getCompassDirection(from: .east, rotation: 450), .south)
    }
    
    func testGetCompassDirection_TurnLeft() {
        XCTAssertEqual(Day12.Orientation.generate(from: "L")!.getCompassDirection(from: .east, rotation: 0), .east)
        XCTAssertEqual(Day12.Orientation.generate(from: "L")!.getCompassDirection(from: .east, rotation: 90), .north)
        XCTAssertEqual(Day12.Orientation.generate(from: "L")!.getCompassDirection(from: .east, rotation: 180), .west)
        XCTAssertEqual(Day12.Orientation.generate(from: "L")!.getCompassDirection(from: .east, rotation: 270), .south)
        XCTAssertEqual(Day12.Orientation.generate(from: "L")!.getCompassDirection(from: .east, rotation: 360), .east)
        XCTAssertEqual(Day12.Orientation.generate(from: "L")!.getCompassDirection(from: .east, rotation: 450), .north)
    }
    
    func testPart1Example() {
        XCTAssertEqual(Day12.executePart1(from: data), 25)
    }
    
    func testPart1Result() {
        XCTAssertEqual(Day12.generatePart1Value(), 590)
    }
    
    func testPart2Example() {
        XCTAssertEqual(Day12.executePart2(from: data), 286)
    }
    
    func testPart2Result() {
        XCTAssertEqual(Day12.generatePart2Value(), 42013)
    }
}
