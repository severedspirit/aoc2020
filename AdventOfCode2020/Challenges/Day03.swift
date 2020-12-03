//
//  Day03.swift
//  AdventOfCode2020
//
//  Created by Apple  on 03/12/2020.
//

import Foundation

struct Day03 {
    
    // MARK: - Struct
    
    struct Status {
        let location: SledLocation
        let currentValue: LocationValueStatus
    }
    
    struct SledLocation {
        let right: Int
        let down: Int
        
        static func +(lhs: SledLocation, rhs: SledLocation) -> SledLocation {
            return SledLocation(right: lhs.right + rhs.right, down: lhs.down + rhs.down)
        }
    }
    
    // MARK: - Enums
    
    enum LocationValueStatus {
        case notStarted
        case finished
        case value(LocationValue)
        
        var canMove: Bool {
            switch self {
            case .notStarted, .value(_):
                return true
            case .finished:
                return false
            }
        }
    }
    
    enum LocationValue: String {
        case openSquare = "."
        case tree = "#"
    }
    
    // MARK: - Properties
    
    static var part2Slopes: [SledLocation] = [.init(right: 1, down: 1), .init(right: 3, down: 1), .init(right: 5, down: 1), .init(right: 7, down: 1), .init(right: 1, down: 2)]
    
    // MARK: - Functions
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day03p1)
        return getTreesHit(from: .init(right: 3, down: 1), data: data)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day03p1)
        return part2Slopes.compactMap({ Day03.getTreesHit(from: $0, data: data) }).reduce(1, *)
    }

    static func getValue(at location: SledLocation, data: String) -> LocationValueStatus {
        let rows = data.split(separator: "\n")
        guard location.down < rows.count else { return .finished }
        
        let width = rows[0].count
        
        let column = Int(floor(Double(location.right / width)))
        let correctedRight = location.right - (column * width)
        
        let strValue = String(rows[location.down]).character(at: correctedRight)
        return .value(LocationValue(rawValue: String(strValue))!)
    }
    
    static func move(currentLocation: SledLocation, moveByLocation: SledLocation, data: String) -> Status {
        let newLocation = currentLocation + moveByLocation
        return Status(location: newLocation, currentValue: getValue(at: newLocation, data: data))
    }
    
    static func getTreesHit(from slope: SledLocation, data: String) -> Int {
        var treesHit = 0
        var status = Status.init(location: .init(right: 0, down: 0), currentValue: .notStarted)
        
        while status.currentValue.canMove {
            status = move(currentLocation: status.location, moveByLocation: slope, data: data)
            switch status.currentValue {
            case .finished, .notStarted:
                break
            case .value(let value):
                switch value {
                case .openSquare:
                    break
                case .tree:
                    treesHit += 1
                }
            }
        }
        return treesHit
    }
}
