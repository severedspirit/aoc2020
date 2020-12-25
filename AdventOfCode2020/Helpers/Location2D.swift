//
//  Location2D.swift
//  AdventOfCode2020
//
//  Created by Apple  on 21/12/2020.
//

import Foundation

struct Location2D {
    let x: Int
    let y: Int
    
    func getIndex(width: Int) -> Int {
        return (width * self.y) + self.x
    }
    
    func isWithBounds(width: Int, height: Int) -> Bool {
        return x >= 0 && y >= 0 && x < width && y < height
    }
    
    func moveBy(location: Location2D) -> Location2D {
        return .init(x: self.x + location.x, y: self.y + location.y)
    }
    
    static let possibleDirections: [Location2D] = [
        .init(x: -1, y: -1), .init(x: 0, y: -1), .init(x: 1, y: -1),
        .init(x: -1, y: 0),                      .init(x: 1, y: 0),
        .init(x: -1, y: 1),  .init(x: 0, y: 1),  .init(x: 1, y: 1)
    ]
    
    func getValidLocationsXAndYRanges(width: Int, height: Int) -> (ClosedRange<Int>, ClosedRange<Int>) {
        let location = self
        let fromX = location.x - 1 >= 0 ? location.x - 1 : 0
        let toX = location.x + 1 < width ? location.x + 1 : width - 1
        let fromY = location.y - 1 >= 0 ? location.y - 1 : 0
        let toY = location.y + 1 < height ? location.y + 1 : height - 1
        return (fromX...toX, fromY...toY)
    }
}
