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
    }
    
    static func getFileContents(for file: File) -> String {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let bundleURL = URL(fileURLWithPath: "AOCBundle.bundle", relativeTo: currentDirectoryURL)
        let bundle = Bundle(url: bundleURL)
        
        
        let url = bundle!.url(forResource: file.rawValue, withExtension: "txt")!
        return try! String(contentsOf: url)
    }
}
