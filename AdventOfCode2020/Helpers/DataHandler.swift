//
//  DataHandler.swift
//  AdventOfCode2020
//
//  Created by Apple  on 02/12/2020.
//

import Foundation

struct DataHandler {
    enum File: String {
        case day01p1 = "Day01p1"
        case day02p1 = "Day02p1"
        case day03p1 = "Day03p1"
        case day04p1 = "Day04p1"
        case day05p1 = "Day05p1"
        case day06p1 = "Day06p1"
        case day07p1 = "Day07p1"
        case day08p1 = "Day08p1"
        case day09p1 = "Day09p1"
        case day10p1 = "Day10p1"
        case day11p1 = "Day11p1"
        case day12p1 = "Day12p1"
        case day13p1 = "Day13p1"
    }
    
    static func getFileContents(for file: File) -> String {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let bundleURL = URL(fileURLWithPath: "AOCBundle.bundle", relativeTo: currentDirectoryURL)
        let bundle = Bundle(url: bundleURL)
        
        
        let url = bundle!.url(forResource: file.rawValue, withExtension: "txt")!
        return try! String(contentsOf: url)
    }
}
