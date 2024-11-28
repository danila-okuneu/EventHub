//
//  Category.swift
//  EventHub
//
//  Created by Igor Guryan on 27.11.2024.
//
import UIKit

struct Category {
    let name: String
    let color: UIColor
    let sfSymbol: String
    let slug: String
}

struct EventCategory: Codable {
    let id: Int
    let slug: String
    let name: String
}
