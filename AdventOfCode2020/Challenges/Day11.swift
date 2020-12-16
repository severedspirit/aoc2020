//
//  Day11.swift
//  AdventOfCode2020
//
//  Created by Apple  on 16/12/2020.
//

import Foundation

struct Day11 {
    
    enum SupportVersion {
        case version1
        case version2
    }
    
    enum CharacterRepresentation: Equatable {
        case emptySeat
        case occupiedSeat
        case floor
        
        var rawValue: Character {
            switch self {
            case .emptySeat: return "L"
            case .occupiedSeat: return "#"
            case .floor: return "."
            }
        }
        
        static func generate(from character: Character) -> CharacterRepresentation {
            switch character {
            case "L": return .emptySeat
            case "#": return .occupiedSeat
            case ".": return .floor
            default: fatalError()
            }
        }
        
        static func generate(from data: [CharacterRepresentation], at location: Location, width: Int) -> CharacterRepresentation {
            let index = (width * location.y) + location.x
            return data[index]
            
        }
    }

    
    struct Location {
        let x: Int
        let y: Int
        
        func getIndex(width: Int) -> Int {
            return (width * self.y) + self.x
        }
        
        func isWithBounds(width: Int, height: Int) -> Bool {
            return x >= 0 && y >= 0 && x < width && y < height
        }
        
        func moveBy(location: Location) -> Location {
            return .init(x: self.x + location.x, y: self.y + location.y)
        }
    }
    
    enum Validation {
        case doesNotContainOccupiedSeat
        case fourOrMoreOccupiedSeats
    }
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day11p1)
        return applyBasicSeatingRules(data: data, version: .version1)
    }
    

    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day11p1)
        return applyBasicSeatingRules(data: data, version: .version2)
    }
    
    static func canVisiblySeeChairs(amount: Int, from data: [CharacterRepresentation], width: Int, height: Int, currentLocation location: Location) -> Bool {
        
        var timesFoundChair = 0
        for locationPostion in possibleDirections {
            
            var newLocation = location.moveBy(location: locationPostion)
            
            while newLocation.isWithBounds(width: width, height: height) {
                
                let itemAtPlace = data[newLocation.getIndex(width: width)]
                if itemAtPlace == .emptySeat {
                    // Person cannot see behind a chair
                    break
                } else if itemAtPlace == .occupiedSeat {
                    timesFoundChair += 1
                    break
                } else {
                    newLocation = newLocation.moveBy(location: locationPostion)
                }
            }
            
            if timesFoundChair >= amount {
                return true
            }
        }
        
        return timesFoundChair >= amount
    }
    
    static let possibleDirections: [Location] = [
        .init(x: -1, y: -1), .init(x: 0, y: -1), .init(x: 1, y: -1),
        .init(x: -1, y: 0),                      .init(x: 1, y: 0),
        .init(x: -1, y: 1),  .init(x: 0, y: 1),  .init(x: 1, y: 1)
    ]
    
    static func isCheckValid(for validation: Validation, from data: [CharacterRepresentation], width: Int, height: Int, currentLocation location: Location) -> Bool {
        let fromX = location.x - 1 >= 0 ? location.x - 1 : 0
        let toX = location.x + 1 < width ? location.x + 1 : width - 1
        let fromY = location.y - 1 >= 0 ? location.y - 1 : 0
        let toY = location.y + 1 < height ? location.y + 1 : height - 1
        
        var occupiedSeats = 0
        for x in fromX...toX {
            for y in fromY...toY {
                guard !(x == location.x && y == location.y) else { continue }
                
                let rep = CharacterRepresentation.generate(from: data, at: .init(x: x, y: y), width: width)
                if rep == .occupiedSeat {
                    occupiedSeats += 1
                }
                
                switch validation {
                case .doesNotContainOccupiedSeat:
                    if occupiedSeats >= 1 {
                        return false
                    }
                case .fourOrMoreOccupiedSeats:
                    if occupiedSeats >= 4 {
                        return true
                    }
                }
            }
        }
        
        switch validation {
        case .doesNotContainOccupiedSeat:
            return true
        case .fourOrMoreOccupiedSeats:
            return false
        }
    }
    
    static func getWidthAndHeight(from data: String) -> (Int, Int) {
        let split = data.components(separatedBy: "\n").filter({ !$0.isEmpty })
        let height = split.count
        let width = split.first!.count
        return (width, height)
    }
    
    static func updateLayout(from charactersBefore: [CharacterRepresentation], version: SupportVersion, width: Int, height: Int, allLocations: [Location]) -> [CharacterRepresentation] {
        
        var charactersAfter = charactersBefore

        for (index, location) in allLocations.enumerated() {
            let currentRep = charactersBefore[index]
            switch currentRep {
            case .emptySeat:
                switch version {
                case .version1:
                    guard isCheckValid(for: .doesNotContainOccupiedSeat, from: charactersBefore, width: width, height: height, currentLocation: location) else { continue }
                case .version2:
                    guard !canVisiblySeeChairs(amount: 1, from: charactersBefore, width: width, height: height, currentLocation: location) else { continue }
                }
                charactersAfter[location.getIndex(width: width)] = .occupiedSeat
            case .occupiedSeat:
                switch version {
                case .version1:
                    guard isCheckValid(for: .fourOrMoreOccupiedSeats, from: charactersBefore, width: width, height: height, currentLocation: location) else { continue }
                case .version2:
                    guard canVisiblySeeChairs(amount: 5, from: charactersBefore, width: width, height: height, currentLocation: location) else { continue }
                }
                charactersAfter[location.getIndex(width: width)] = .emptySeat

            case .floor:
                // People cannot sit on floor
                break
            }
        }
        
        return charactersAfter
    }
    
    static func applyBasicSeatingRules(data: String, version: SupportVersion) -> Int {
        
        // Pre-generate required vars
        let (width, height) = getWidthAndHeight(from: data)
        var allLocations: [Location] = []
        for y in 0..<height {
            for x in 0..<width {
                allLocations.append(Location(x: x, y: y))
            }
        }
        let charactersBefore = Array(data.replacingOccurrences(of: "\n", with: "")).compactMap({ CharacterRepresentation.generate(from: $0) })

        
        // Loop through array until array doesnt change
        var currentValue = charactersBefore
        while true {
            let newVersion = updateLayout(from: currentValue, version: version, width: width, height: height, allLocations: allLocations)
            if newVersion == currentValue {
                break
            }
            currentValue = newVersion
        }
        return currentValue.filter({ $0 == .occupiedSeat }).count
    }
}
