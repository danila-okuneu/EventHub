//
//  Event.swift
//  EventHub
//
//  Created by Igor Guryan on 23.11.2024.
//

struct DataResponse: Codable {
//    let count: Int
    let results: [EventType]
}

struct EventType: Codable {
    let id: Int
    let dates: [DateElement]
    let title: String
	let place: Place?
    let bodyText: String
    let images: [Image]
    let favoritesCount: Int
    let shortTitle: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, dates, title, place
//        case bodyText = "body_text"
//        case images
//        case favoritesCount = "favorites_count"
//        case shortTitle = "short_title"
//    }
}

// MARK: - DateElement
struct DateElement: Codable {
	let start: Int
	let end: Int
}

// MARK: - Image
struct Image: Codable {
    let image: String
    let source: Source
}

// MARK: - Source
struct Source: Codable {
    let name: String
    let link: String
}

struct Place: Codable {
	let id: Int
}
