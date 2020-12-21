//
//  Day16.swift
//  AdventOfCode2020
//
//  Created by Apple  on 21/12/2020.
//

import Foundation

struct Day16 {
    
    struct TicketData {
        let ticketValidations: [TicketValidations]
        let myTicket: [Int]
        let nearbyTickets: [[Int]]
    }
    
    struct TicketValidations: Equatable {
        let name: String
        let ranges: [ClosedRange<Int>]
    }
    
    static let data = """
    class: 1-3 or 5-7
    row: 6-11 or 33-44
    seat: 13-40 or 45-50

    your ticket:
    7,1,14

    nearby tickets:
    7,3,47
    40,4,50
    55,2,20
    38,6,12
    """
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day16p1)
        return getErrorRate(from: data)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day16p1)
        return getDepartureValue(from: data)
    }
    
    static func getTicketValidations(from stringValue: String) -> [TicketValidations] {
        let splitSections = stringValue.components(separatedBy: "\n\n")[0]
        let lines = splitSections.components(separatedBy: "\n")
        
        var ticketValidations: [TicketValidations] = []
        for line in lines {
            let split1 = line.components(separatedBy: ": ")
            var ranges: [ClosedRange<Int>] = []
            for strRange in split1[1].components(separatedBy: " or ") {
                let intRanges = strRange.components(separatedBy: "-").compactMap({ Int($0) })
                let range = intRanges[0]...intRanges[1]
                ranges.append(range)
            }
            ticketValidations.append(.init(name: split1[0], ranges: ranges))
        }
        
        return ticketValidations
    }
    
    static func getErrorRate(from tickets: [[Int]], validations: [TicketValidations]) -> Int {
        let allValidations = validations.compactMap({ $0.ranges }).flatMap({ $0 })
        let ticketIds = tickets.flatMap({ $0 })
        
        return ticketIds
            .filter({ ticketId in !allValidations.contains(where: { $0.contains(ticketId) }) })
            .reduce(0, +)
    }
    
    static func filterOutErroredTickets(from tickets: [[Int]], validations: [TicketValidations]) -> [[Int]] {
        let allValidations = validations.compactMap({ $0.ranges }).flatMap({ $0 })
        
        var validTickets: [[Int]] = []
        for ticket in tickets {
            if ticket.contains(where: { id in !allValidations.contains(where: { $0.contains(id) }) }) {
                continue
            }
            validTickets.append(ticket)
        }
        
        return validTickets
    }
    
    static func getTicketValidationIndexes(from tickets: [[Int]], validations: [TicketValidations]) -> [Int: TicketValidations] {
        var validationIndexes: [Int: TicketValidations] = [:]
        var remainingValidations = validations

        while validationIndexes.count != validations.count {
            for ticketIndex in 0..<tickets[0].count {
                let allIndexes = tickets.compactMap({ $0[ticketIndex] })
                var possibleValidations: [TicketValidations] = []
                
                // Loop through all of the remaining validations and store when each id is suffice
                for validation in remainingValidations {
                    let allSatisfy = allIndexes.allSatisfy({ id in validation.ranges.contains(where: { $0.contains(id) }) })
                    if allSatisfy {
                        possibleValidations.append(validation)
                    }
                }
                
                if possibleValidations.count == 1 {
                    // There is only one possible solution
                    validationIndexes[ticketIndex] = possibleValidations[0]
                    remainingValidations.remove(at: remainingValidations.firstIndex(where: { $0 == possibleValidations[0] })!)
                }
            }
        }
        return validationIndexes
    }
    
    static func getDepartureValue(from stringValue: String) -> Int {
        let ticketData = generateTicketData(from: stringValue)
        let validNearbyTickets = filterOutErroredTickets(from: ticketData.nearbyTickets, validations: ticketData.ticketValidations)
        let items = getTicketValidationIndexes(from: validNearbyTickets, validations: ticketData.ticketValidations)
        let indexes = items.filter({ $0.value.name.hasPrefix("departure") }).keys
        return indexes.compactMap({ ticketData.myTicket[$0] }).reduce(1, *)
    }
    
    static func generateTicketData(from stringValue: String) -> TicketData {
        let ticketValidations = getTicketValidations(from: stringValue)
        let splitSections = stringValue.components(separatedBy: "\n\n")
        let myTicket = splitSections[1].components(separatedBy: "\n")[1].components(separatedBy: ",").compactMap({ Int($0) })
        let nearbyTicketLines = splitSections[2].components(separatedBy: "\n")
        let nearbyTickets = nearbyTicketLines[1...(nearbyTicketLines.count - 1)].filter({ !$0.isEmpty }).compactMap( { $0.components(separatedBy: ",").compactMap({ Int($0 )})})
        
        return .init(ticketValidations: ticketValidations, myTicket: myTicket, nearbyTickets: nearbyTickets)
    }
    
    static func getErrorRate(from stringValue: String) -> Int {
        let ticketData = generateTicketData(from: stringValue)
        return getErrorRate(from: ticketData.nearbyTickets, validations: ticketData.ticketValidations)
    }
}
