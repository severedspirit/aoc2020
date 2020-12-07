//
//  Day07.swift
//  AdventOfCode2020
//
//  Created by Apple  on 07/12/2020.
//

import Foundation

struct Day07 {
    
    // MARK: - Structs
    
    struct Bag: Equatable {
        let name: String
        let available: [String: Int]
    }
    
    // MARK: - Functions (General)
    
    static func generateBag(from data: String) -> Bag {
        let split = data.split(separator: " ")
        let name = "\(split[0]) \(split[1])"
        guard !data.contains("no other bags") else { return .init(name: name, available: [:]) }
        
        // Bag can hold other bags
        var availableBags: [String: Int] = [:]
        let additionalBags = data.components(separatedBy:  " contain ")[1].components(separatedBy: ", ")
        for strBag in additionalBags {
            let bagSplit = strBag.components(separatedBy: " ")
            let bagName = "\(bagSplit[1]) \(bagSplit[2])"
            let number = Int(bagSplit[0])!
            availableBags[bagName] = number
        }
        
        return Bag(name: name, available: availableBags)
    }
    
    // MARK: - Task 1
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day07p1)
        return getBagsThatCanContainGold(data: data)
    }
    
    static func canBagContainGold(bag: Bag, allBags: [Bag]) -> Bool {
        var currentlyCheckedBags: [Bag] = []
        var checkBags: ((Bag) -> Bool)!
        checkBags = { bag in
            
            if bag.available.keys.contains("shiny gold") {
                return true
            }
            let newBags = bag.available
                .keys
                .compactMap({ bagName in allBags.first(where: { $0.name == bagName } )})
                .filter({ !currentlyCheckedBags.contains($0) })
            
            currentlyCheckedBags.append(contentsOf: newBags)
            return newBags.contains(where: { checkBags($0) })
        }
        
        return checkBags(bag)
    }
    
    static func getBagsThatCanContainGold(data: String) -> Int {
        let bags = data
            .components(separatedBy: "\n")
            .filter({ !$0.isEmpty })
            .compactMap({ generateBag(from: $0) })
        let bagsThatCanContainGold = bags.filter({ canBagContainGold(bag: $0, allBags: bags) })
        return bagsThatCanContainGold.count
    }
    
    // MARK: - Task 2
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day07p1)
        return getBagsRequiredForShiny(from: data)
    }
    
    static func getBagsRequired(for bag: Bag, allBags: [Bag]) -> Int {
        return bag.available.compactMap({ (key, amount) in
            let foundBag = allBags.first(where: { $0.name == key })!
            return (getBagsRequired(for: foundBag, allBags: allBags) * amount) + amount
        }).reduce(0, +)
    }
    
    static func getBagsRequiredForShiny(from data: String) -> Int {
        let bags = data
            .components(separatedBy: "\n")
            .filter({ !$0.isEmpty })
            .compactMap({ generateBag(from: $0) })
        
        let shiny = bags.first(where: { $0.name == "shiny gold" })!
        return getBagsRequired(for: shiny, allBags: bags)
    }
}
