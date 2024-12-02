//
//  Event.swift
//  EventHub
//
//  Created by Igor Guryan on 23.11.2024.
//

import Foundation

struct DataResponse: Codable {
//    let count: Int
    let results: [Event]
}

struct Event: Codable {
    let id: Int
    let dates: [DateElement]
    let title: String
	let shortTitle: String
	let place: Place?
    let bodyText: String
    let images: [Image]
    let favoritesCount: Int
	
	var actualDate: Int { return dates.first(where: { $0.end > Int(Date().timeIntervalSince1970) } )?.end ?? dates[0].end }
	
	init(id: Int, dates: [DateElement], title: String, place: Place?, bodyText: String, images: [Image], favoritesCount: Int, shortTitle: String) {
		self.id = id
		self.dates = dates
		self.title = title
		self.place = place
		self.bodyText = bodyText
		self.images = images
		self.favoritesCount = favoritesCount
		self.shortTitle = shortTitle
	}
}

// MARK: - DateElement
struct DateElement: Codable {
	let start: Int
	let end: Int
	
//	var startFormatted: String { print(start.toAppDateFormat())
//		return start.toAppDateFormat() }
//	var endFormatted: String { end.toAppDateFormat() }
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

