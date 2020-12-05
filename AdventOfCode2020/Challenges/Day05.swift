//
//  Day05.swift
//  AdventOfCode2020
//
//  Created by Apple  on 05/12/2020.
//

import Foundation

struct Day05 {
    
    struct Location {
        let row: Int
        let column: Int
        
        var id: Int {
            return (row * 8) + column
        }
    }
    
    enum LocationRow: String {
        case front = "F"
        case back = "B"
        
        var locationIndex: LocationIndex {
            switch self {
            case .back: return .upper
            case .front: return .lower
            }
        }
    }
    
    enum LocationColumn: String {
        case left = "L"
        case right = "R"
        
        var locationIndex: LocationIndex {
            switch self {
            case .left: return .lower
            case .right: return .upper
            }
        }
    }
    
    enum LocationIndex {
        case upper
        case lower
    }
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day05p1).split(separator: "\n")
        let values = data.compactMap({ generateLocation(from: String($0)).id }).sorted(by: { $0 > $1 }).first!
        return values
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day05p1).split(separator: "\n")
        let ids = data.compactMap({ Day05.generateLocation(from: String($0)).id }).sorted(by: { $0 < $1 })
        
        for id in ids.first!...ids.last! {
            guard !ids.contains(id) else { continue }
            
            let emptySeats = ids.contains(id - 1) && ids.contains(id + 1)
            guard emptySeats else { continue }
            return id
        }

        fatalError()
    }
    
    static func generateLocation(from stringValue: String) -> Location {
        if stringValue.count != 10 {
            fatalError()
        }
        
        let rowChars = stringValue[stringValue.startIndex..<stringValue.index(stringValue.endIndex, offsetBy: -3)]
        let rowIndexTasks = rowChars.compactMap({ LocationRow(rawValue: String($0))!.locationIndex })
        let row = generateIntValue(from: rowIndexTasks, maximumIndex: 127)

        let columnChars = stringValue[stringValue.index(stringValue.endIndex, offsetBy: -3)..<stringValue.endIndex]
        let columnIndexTasks = columnChars.compactMap({ LocationColumn(rawValue: String($0))!.locationIndex })
        let column = generateIntValue(from: columnIndexTasks, maximumIndex: 7)
        
        return Location(row: row, column: column)
    }
    
    private static func generateIntValue(from tasks: [LocationIndex], maximumIndex: Int) -> Int {
        var range = 0...maximumIndex
        for task in tasks {
            let distance = range.distance(from: range.startIndex, to: range.endIndex)
            switch task {
            case .lower:
                range = range.first!...(range.last! - distance/2)
            case .upper:
                range = (range.first! + distance/2)...range.last!
            }
        }
        return range.first!
    }
}
