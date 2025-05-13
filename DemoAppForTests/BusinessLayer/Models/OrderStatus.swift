//
//  OrderStatus.swift
//  DemoAppForTests
//
//  Created by Dmitriy Toropkin on 05.05.2025.
//

import Foundation

enum OrderStatus: String, Codable {
    case pending
    case preparing
    case ready
    case completed
    case cancelled
}
