//
//  Event.swift
//  EventHub
//
//  Created by Igor Guryan on 29.11.2024.
//
import Foundation

struct Event {
    let id: Int
    let dates: DateElement
    let title: String
    let place: Place?
    let bodyText: String
    let images: [Image]
    let favoritesCount: Int
    let shortTitle: String
    let isFavorited: Bool = false
}

struct DataResponse: Codable {
//    let count: Int
    let results: [EventType]
}

struct EventType: Codable {
    let id: Int
    var dates: [DateElement]
    let title: String
    let place: Place?
    let bodyText: String
    let images: [Image]
    let favoritesCount: Int
    let shortTitle: String
    
    
    var actualTime: Int { dates.first { $0.end > Int(Date().timeIntervalSince1970) }?.end ?? dates[0].end }
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
    let address: String
    let title: String
}


