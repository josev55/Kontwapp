//
//  CounterEntity.swift
//  DomainLayer
//
//  Created by Jose Vildosola on 19-01-20.
//  Copyright © 2020 Jose Vildosola. All rights reserved.
//

import Foundation

public struct CounterEntity: Decodable {
    let id: String
    let title: String
    let count: Int
}

