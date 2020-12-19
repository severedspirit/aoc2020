//
//  Day13.swift
//  AdventOfCode2020
//
//  Created by Apple  on 19/12/2020.
//

import Foundation

struct Day13 {
    
    struct BusGrouping {
        let busNumber: Int
        let difference: Int
    }
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day13p1)
        return getSmallestBusGrouping(from: data)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day13p1)
        return getAlignmentRow(from: data)
    }
    
    static func getSmallestBusGrouping(from data: String) -> Int {
        let rows = data.components(separatedBy: "\n")
        let numberToReach = Int(rows[0])!
        let busNumbers = rows[1].components(separatedBy: ",").filter({ $0 != "x" }).compactMap({ Int(String($0)) })
        
        var currentBusGrouping: BusGrouping!
        for busNumber in busNumbers {
            let difference = (((numberToReach / busNumber) * busNumber) + busNumber) - numberToReach
            let previousDifference = currentBusGrouping?.difference ?? Int.max
            if difference < previousDifference {
                currentBusGrouping = BusGrouping(busNumber: busNumber, difference: difference)
            }
        }
        
        return currentBusGrouping!.busNumber * currentBusGrouping.difference
    }
    
    static func getAlignmentRow(from data: String) -> Int {
        let rows = data.components(separatedBy: "\n")
        let values = rows[1].components(separatedBy: ",").enumerated().filter({ $0.1 != "x" }).compactMap({ (Double(String($0.1))!,Double($0.0)) }) //.sorted(by: { $0.0 < $1.0})

        var allOtherBusses = values.dropFirst()
        
        let firstBus = values.first!.0
        let lastBus = values.last!.0
        var currentNumber: Double = firstBus
        var amountToJumpBy = firstBus
        
        while true {
            
            for (busNumber, index) in allOtherBusses {
                let numberToReach = currentNumber + index
                if numberToReach.truncatingRemainder(dividingBy: busNumber) != 0 {
                    break
                }
                
                if let index = allOtherBusses.firstIndex(where: { $0 == (busNumber, index) }) {
                    allOtherBusses.remove(at: index)
                    amountToJumpBy *= busNumber
                }
                if busNumber == lastBus {
                    return Int(currentNumber)
                }
            }
            
            currentNumber += amountToJumpBy
        }
        
        fatalError()
    }
}
