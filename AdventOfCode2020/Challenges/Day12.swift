//
//  Day12.swift
//  AdventOfCode2020
//
//  Created by Apple  on 16/12/2020.
//

import Foundation

struct Day12 {
    
    enum CompassDirection {
        case north
        case east
        case south
        case west
        
        static func generate(from character: Character) -> CompassDirection? {
            switch character {
            case "N": return .north
            case "S": return .south
            case "E": return .east
            case "W": return .west
            default:
                return nil
            }
        }
        
        func getLocation(from location: Location, value: Int) -> Location {
            switch self {
            case .east: return .init(x: location.x + value, y: location.y)
            case .south: return .init(x: location.x, y: location.y - value)
            case .west: return .init(x: location.x - value, y: location.y)
            case .north: return .init(x: location.x, y: location.y + value)
            }
        }
    }
    
    enum Orientation {
        case left
        case right
        
        static func generate(from character: Character) -> Orientation? {
            switch character {
            case "L": return .left
            case "R": return .right
            default:
                return nil
            }
        }
        
        func getCompassDirection(from compassDirection: CompassDirection, rotation: Int) -> CompassDirection {
            switch self {
            case .left:
                return Orientation.right.getCompassDirection(from: compassDirection, rotation: -rotation)
            case .right:
                let compassDirections: [CompassDirection] = [.north, .east, .south, .west]
                let currentIndex = compassDirections.firstIndex(of: compassDirection)!
                let rotations = rotation / 90
                
                let arrayLoopsToRemove = Int(floor(Double(rotations + currentIndex) / Double(compassDirections.count)))
                
                let compassIndex = (rotations - (arrayLoopsToRemove * compassDirections.count)) + currentIndex
                return compassDirections[compassIndex]
            }
        }
        
        func rotateWaypoint(shipLocation: Location, waypointLocation: Location, rotation: Int) -> Location {
            let rotationWithoutDegrees = rotation / 90
            let rotations = Double(rotationWithoutDegrees) / 4
            let rotationsLeft = rotationWithoutDegrees - Int(floor(rotations))
            var newWaypoint = waypointLocation
            for _ in 0..<rotationsLeft {
                
                switch self {
                case .right:
                    newWaypoint = .init(x: newWaypoint.y, y: -newWaypoint.x)
                case .left:
                    newWaypoint = .init(x: -newWaypoint.y, y: newWaypoint.x)
                }
            }
            return newWaypoint
            
        }
    }
    
    struct Location {
        let x: Int
        let y: Int
        
        func getLocation(using value: Int, relativeToWaypoint waypoint: Location) -> Location {
            return .init(x: self.x + (value * waypoint.x), y: self.y + (value * waypoint.y))
        }
    }
    
    struct CurrentLocation {
        let location: Location
        let compassDirection: CompassDirection
    }
    
    
    static func executePart2(from data: String) -> Int {
        let split = data.components(separatedBy: "\n").filter({ !$0.isEmpty })
        
        var shipLocation = CurrentLocation(location: .init(x: 0, y: 0), compassDirection: .east)
        var waypointLocation = Location(x: 10, y: 1)
        for line in split {
            
            var value = line
            
            let char = value.remove(at: value.startIndex)
            let intValue = Int(value)!
            if char == "F" {
                let newLocation = shipLocation.location.getLocation(using: intValue, relativeToWaypoint: waypointLocation)
                shipLocation = CurrentLocation(location: newLocation, compassDirection: shipLocation.compassDirection)
            } else if let compassDirection = CompassDirection.generate(from: char) {
                waypointLocation = compassDirection.getLocation(from: waypointLocation, value: intValue)
            } else if let orienation = Orientation.generate(from: char) {
                waypointLocation = orienation.rotateWaypoint(shipLocation: shipLocation.location, waypointLocation: waypointLocation, rotation: intValue)
            } else {
                fatalError()
            }
        }
        
        return abs(shipLocation.location.x) + abs(shipLocation.location.y)
    }
    
    static func executePart1(from data: String) -> Int {
        let split = data.components(separatedBy: "\n").filter({ !$0.isEmpty })
        
        var currentLocation = CurrentLocation(location: .init(x: 0, y: 0), compassDirection: .east)
        for line in split {
            
            var value = line
            
            let char = value.remove(at: value.startIndex)
            let intValue = Int(value)!
            if char == "F" {
                let newLocation = currentLocation.compassDirection.getLocation(from: currentLocation.location, value: intValue)
                currentLocation = CurrentLocation(location: newLocation, compassDirection: currentLocation.compassDirection)
            } else if let compassDirection = CompassDirection.generate(from: char) {
                let newLocation = compassDirection.getLocation(from: currentLocation.location, value: intValue)
                currentLocation = CurrentLocation(location: newLocation, compassDirection: currentLocation.compassDirection)
            } else if let orienation = Orientation.generate(from: char) {
                let newDirection = orienation.getCompassDirection(from: currentLocation.compassDirection, rotation: intValue)
                currentLocation = CurrentLocation(location: currentLocation.location, compassDirection: newDirection)
            } else {
                fatalError()
            }
        }
        
        return abs(currentLocation.location.x) + abs(currentLocation.location.y)
    }
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day12p1)
        return executePart1(from: data)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day12p1)
        return executePart2(from: data)
    }
}
