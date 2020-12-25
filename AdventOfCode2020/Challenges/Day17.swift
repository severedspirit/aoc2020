//
//  Day17.swift
//  AdventOfCode2020
//
//  Created by Apple  on 25/12/2020.
//

import Foundation

struct Day17 {
    
    // MARK: - Enums
    
    enum Cube {
        case active
        case inactive
        
        static func generate(from character: Character) -> Day17.Cube {
            switch character {
            case "#": return .active
            case ".": return .inactive
            default: fatalError()
            }
        }
    }
    
    enum Dimensions {
        case three
        case four
    }
    
    // MARK: - Classes
    
    class LocationStorage3D: LocationStorageProtocol {
        static var length: Int = 3
        private(set) var locations: [[Int]: Day17.Cube] = [:]
        
        required init(locations: [[Int]: Day17.Cube] = [:]) {
            self.locations = locations
        }
        
        func setValue(_ value: Day17.Cube, at location: [Int]) {
            self.locations[location] = value
        }
    }

    class LocationStorage4D: LocationStorageProtocol {
        static var length: Int = 4
        private(set) var locations: [[Int]: Day17.Cube] = [:]
        
        required init(locations: [[Int]: Day17.Cube] = [:]) {
            self.locations = locations
        }
        
        func setValue(_ value: Day17.Cube, at location: [Int]) {
            self.locations[location] = value
        }
    }
    
    // MARK: - Functions
    
    static func updateLocation<T: LocationStorageProtocol>(originalLocationStorage: T) -> T {
        let newLocationStorage = T(locations: originalLocationStorage.locations)
        for initialLocation in originalLocationStorage.cubeLocations {
            
            for possibleLocation in initialLocation.possibleLocations(length: T.length) {
                if let newValue = originalLocationStorage.getNewValue(from: possibleLocation) {
                    newLocationStorage.setValue(newValue, at: possibleLocation)
                }
            }
        }
        
        return newLocationStorage
    }
    
    static func generateValue(from data: String, for dimensions: Dimensions) -> Int {
        switch dimensions {
        case .three:
            var currentStorage = LocationStorage3D.generate(with: data)
            for _ in 0..<6 {
                currentStorage = Day17.updateLocation(originalLocationStorage: currentStorage)
            }
            return currentStorage.activeCubes
        case .four:
            var currentStorage = LocationStorage4D.generate(with: data)
            for _ in 0..<6 {
                currentStorage = Day17.updateLocation(originalLocationStorage: currentStorage)
            }
            return currentStorage.activeCubes
        }
    }
    
    static func generatePart1Value() -> Int {
        return generateValue(from: DataHandler.getFileContents(for: .day17p1), for: .three)
    }
    
    static func generatePart2Value() -> Int {
        return generateValue(from: DataHandler.getFileContents(for: .day17p1), for: .four)
    }
}

fileprivate extension Array where Element == Int {
    func possibleLocations(length: Int) -> [Self] {
        var locations: [Self] = []
        
        for x in -1...1 {
            for y in -1...1 {
                for z in -1...1 {
                    if length == 4 {
                        for w in -1...1 {
                            guard !(x == 0 && y == 0 && z == 0 && w == 0) else { continue }
                            locations.append([x + self[0], y + self[1], z + self[2], w + self[3]])
                        }
                    } else if length == 3 {
                        guard !(x == 0 && y == 0 && z == 0) else { continue }
                        locations.append([x + self[0], y + self[1], z + self[2]])
                    }
                }
            }
        }
        return locations
    }
}

protocol LocationStorageProtocol {
    func getValue(at location: [Int]) -> Day17.Cube
    func setValue(_ value: Day17.Cube, at location: [Int])
    var locations: [[Int]: Day17.Cube] { get }
    var activeCubes: Int { get }
    var cubeLocations: [[Int]] { get }
    init(locations: [[Int]: Day17.Cube])
    static var length: Int { get }
}

extension LocationStorageProtocol {
    static func generate(with data: String) -> Self {
        let locationStorage = Self(locations: [:])
        let lines = data.components(separatedBy: "\n").filter({ !$0.isEmpty })
        
        let minusOffset = (lines.count - 1) / 2
        
        for (yIndex, line) in lines.enumerated() {
            for (xIndex, character) in line.enumerated() {
                if Self.length == 4 {
                    locationStorage.setValue(.generate(from: character), at: [xIndex - minusOffset, yIndex - minusOffset, 0, 0])
                } else if Self.length == 3 {
                    locationStorage.setValue(.generate(from: character), at: [xIndex - minusOffset, yIndex - minusOffset, 0])
                }
            }
        }
        return locationStorage
    }
    
    
    func getNewValue(from location: [Int]) -> Day17.Cube? {

        var activeCount = 0
        
        let hasNewValue: (([Int]) -> Bool) = { newLocation in
            activeCount += self.getValue(at: newLocation) == .active ? 1 : 0
            return activeCount > 3
        }
        
        
        mainLoop: for x in -1...1 {
            for y in -1...1 {
                for z in -1...1 {
                    if Self.length == 4 {
                        for w in -1...1 {
                            guard !(x == 0 && y == 0 && z == 0 && w == 0) else { continue }
                            let item = [x + location[0], y + location[1], z + location[2], w + location[3]]
                            let isComplete = hasNewValue(item)
                            guard !isComplete else { break mainLoop }

                        }
                    } else if Self.length == 3 {
                        guard !(x == 0 && y == 0 && z == 0) else { continue }
                        let item = [x + location[0] ,y + location[1], z + location[2]]
                        let isComplete = hasNewValue(item)
                        guard !isComplete else { break mainLoop }
                    }
                }
            }
        }
        
        switch self.getValue(at: location) {
        case .active:
            if !(activeCount == 2 || activeCount == 3) {
                return .inactive
            }
        case .inactive:
            if activeCount == 3 {
                return .active
            }
        }
        
        return nil
    }

    func getValue(at location: [Int]) -> Day17.Cube {
        return locations[location] ?? .inactive
    }
    
    var activeCubes: Int {
        return locations.values.filter({ $0 == .active }).count
    }
    
    var cubeLocations: [[Int]] {
        return locations.keys.compactMap({ $0 })
    }
}
