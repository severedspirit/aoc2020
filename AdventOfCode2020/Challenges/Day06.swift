//
//  Day06.swift
//  AdventOfCode2020
//
//  Created by Apple  on 06/12/2020.
//

import Foundation

struct Day06 {
    
    static let seperator: String = "*"
    
    static func getUnaminousYesAnswers(fromAll data: String) -> Int {
        let split = StringHelper.splitDataIntoGroups(data: data).compactMap({ $0.replacingOccurrences(of: " ", with: seperator)})
        let values = split.compactMap({ getUnaminousYesAnswers(fromGroup: $0) })
        let total = values.reduce(0, +)
        return total
    }
    
    static func getTotalYesAnswers(fromAll data: String) -> Int {
        let split = StringHelper.splitDataIntoGroups(data: data).compactMap({ $0.replacingOccurrences(of: " ", with: seperator)})
        let values = split.compactMap({ getPossibleAnswers(from: $0).count })
        let total = values.reduce(0, +)
        return total
    }
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day06p1)
        return getTotalYesAnswers(fromAll: data)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day06p1)
        return getUnaminousYesAnswers(fromAll: data)
    }
    
    // MARK: - Private Static Functions
    
    private static func getUnaminousYesAnswers(fromGroup data: String) -> Int {
        let answers = getPossibleAnswers(from: data)
        let responses = data.split(separator: Character(seperator))
        
        var unaminousAnswers = 0
        for answer in answers {
            let allYesAnswers = !responses.contains(where: { !$0.contains(answer) })
            if allYesAnswers {
                unaminousAnswers += 1
            }
        }
        return unaminousAnswers
    }
    
    private static func getPossibleAnswers(from data: String) -> [String.Element] {
        var charsFound: [String.Element] = []
        let invalidCharacters = [String.Element(seperator)]
        for char in data {
            guard !invalidCharacters.contains(char) else { continue }
            guard !charsFound.contains(char) else { continue }
            charsFound.append(char)
        }
        return charsFound
    }
}
