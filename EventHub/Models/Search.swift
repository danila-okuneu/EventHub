//
//  Search.swift
//  EventHub
//
//  Created by Igor Guryan on 02.12.2024.
//

import Foundation

// MARK: - Welcome
struct SearchEventResponse: Codable {
    let count: Int
    let results: [SearchEvent]
}

// MARK: - Result
struct SearchEvent: Codable {
    let id: Int
    let slug, title: String
    let favoritesCount: Int
    let description: String
    let place: Place?
    let daterange: DateElement
    let firstImage: Image
}
