//
//  String.swift
//  AdventOfCode2020
//
//  Created by Apple  on 03/12/2020.
//

import Foundation

extension String {
    func character(at index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
