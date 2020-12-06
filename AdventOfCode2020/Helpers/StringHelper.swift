//
//  StringHelper.swift
//  AdventOfCode2020
//
//  Created by Apple  on 06/12/2020.
//

import Foundation

struct StringHelper {
    
    static func splitDataIntoGroups(data: String) -> [String] {
        let seperator: String = "*"
        if data.contains(seperator) {
            // If the seperator is used in the data just kill the command as the split will fail
            fatalError()
        }
        return data
            .replacingOccurrences(of: "\n\n", with: seperator)
            .replacingOccurrences(of: "\n", with: " ")
            .split(separator: Character(seperator))
            .compactMap({ String($0) })
    }
}
