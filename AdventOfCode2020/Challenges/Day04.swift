//
//  Day04.swift
//  AdventOfCode2020
//
//  Created by Apple  on 04/12/2020.
//

import Foundation

struct Day04 {
    
    // MARK: - Struct
    
    struct PassportFieldWithValue {
        let field: PassportField
        let value: String
    }
    
    // MARK: - Enum
    
    enum PassportField: String, CaseIterable {
        case birthYear = "byr"
        case issueYear = "iyr"
        case expirationYear = "eyr"
        case height = "hgt"
        case hairColor = "hcl"
        case eyeColor = "ecl"
        case passportId = "pid"
        case countryId = "cid"
        
        func validate(with value: String) -> Bool {
            
            switch self {
            case .birthYear:
                guard value.count == 4 else { return false }
                let year = Int(value)!
                return year >= 1920 && year <= 2002
            case .issueYear:
                guard value.count == 4 else { return false }
                let year = Int(value)!
                return year >= 2010 && year <= 2020
            case .expirationYear:
                guard value.count == 4 else { return false }
                let year = Int(value)!
                return year >= 2020 && year <= 2030
            case .passportId:
                guard value.count == 9 else { return false }
                let intValue = Int(value)!
                let strValue = String(format: "%09i", intValue)
                return strValue == value
            case .hairColor:
                guard value.first == "#" else { return false }
                // regex represents a hash followed by 6 alphanumeric characters
                let regex = try! NSRegularExpression(pattern: "(#)([a-f]|[0-9])([a-f]|[0-9])([a-f]|[0-9])([a-f]|[0-9])([a-f]|[0-9])([a-f]|[0-9])")
                let range = NSRange(location: 0, length: value.utf16.count)
                return !regex.matches(in: value, options: [], range: range).isEmpty
            case .eyeColor:
                return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value)
            case .height:
                let strNumber = value[value.startIndex..<value.index(value.endIndex, offsetBy: -2)]
                guard let number = Int(strNumber) else { return false }
                let strType = value[value.index(value.endIndex, offsetBy: -2)..<value.endIndex]   // value.substring(from: value.index(value.endIndex, offsetBy: -2))
                
                switch strType {
                case "in":
                    return number >= 59 && number <= 76
                case "cm":
                    return number >= 150 && number <= 193
                default:
                    return false
                }
            case .countryId:
                return true
            }
        }
    }
    
    enum ValueValidation {
        case ignoreValidation
        case validation
    }
    
    enum PassportStatus {
        case normalPassport
        case northPolePassport
        case invalid
    }
    
    // MARK: - Static Functions
    
    static func generatePart1Value() -> Int {
        let data = DataHandler.getFileContents(for: .day04p1)
        return countValidPassports(from: data, validation: .ignoreValidation)
    }
    
    static func generatePart2Value() -> Int {
        let data = DataHandler.getFileContents(for: .day04p1)
        return countValidPassports(from: data, validation: .validation)
    }
    
    static func getPassportFields(from data: String) -> [PassportFieldWithValue] {
        return data.split(separator: " ")
            .compactMap({ PassportFieldWithValue(
                            field: PassportField(rawValue: String($0.split(separator: ":")[0]))!,
                            value: String($0.split(separator: ":")[1]))

            })
    }

    static func getPassportStatus(from passportData: [PassportFieldWithValue], validation: ValueValidation) -> PassportStatus {
        var remainingPassportFields = PassportField.allCases
        for passportItem in passportData {
            
            // Validate Value
            switch validation {
            case .ignoreValidation:
                break
            case .validation:
                guard passportItem.field.validate(with: passportItem.value) else { return .invalid }
            }
            
            // Remove field if validation succeeds
            if let index = remainingPassportFields.firstIndex(of: passportItem.field) {
                remainingPassportFields.remove(at: index)
            }
        }
        
        if remainingPassportFields.count == 0 {
            return .normalPassport
        } else if remainingPassportFields.count == 1, remainingPassportFields.first! == .countryId {
            return .northPolePassport
        }
        return .invalid
    }
    
    static func countValidPassports(from data: String, validation: ValueValidation) -> Int {
        return Day04.splitDataIntoPassportGroups(data: data)
            .compactMap({ Day04.getPassportFields(from:$0) })
            .compactMap({ Day04.getPassportStatus(from: $0, validation: validation) })
            .filter({ $0 == .normalPassport || $0 == .northPolePassport }).count
    }

    private static func splitDataIntoPassportGroups(data: String) -> [String] {
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
