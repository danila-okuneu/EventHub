//
//  EventModel.swift
//  EventHub
//
//  Created by Vika on 22.11.24.
//

import Foundation

// MARK: - Event
struct EventModel: Decodable {
    let id: Int
    let publicationDate: Int?
    let dates: [EventDate]
    let title: String
    let description: String?
    let bodyText: String?
    let images: [EventImage]?
    let shortTitle: String?
    let participants: [Agent]?
    let place: Place?
}

// MARK: - EventDate
struct EventDate: Decodable {
    let startDate: String?
    let startTime: String?
    let start: Int
}

// MARK: - Place
struct Place: Decodable {
    let title: String
    let address: String?
}

// MARK: - EventImage
struct EventImage: Decodable {
    let image: String
}

// MARK: - Agent
struct Agent: Decodable {
    let title: String
    let ctype: String
}
