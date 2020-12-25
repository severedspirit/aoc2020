//
//  CharacterRepresentationProtocol.swift
//  AdventOfCode2020
//
//  Created by Apple  on 21/12/2020.
//

import Foundation

protocol CharacterRepresentationProtocol {
    var rawValue: Character { get }
    static func generate(from character: Character) -> Self
}

extension CharacterRepresentationProtocol {
    static func generate(from data: [Self], at location: Location2D, width: Int) -> Self {
        let index = (width * location.y) + location.x
        return data[index]
    }
}
