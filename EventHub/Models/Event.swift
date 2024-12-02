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
    var dates: [DateElement]
    let title: String
	let shortTitle: String
	let place: Place?
    let bodyText: String
    let images: [Image]
    let favoritesCount: Int
	
	var actualDate: Int {
		let todaysDate = Int(Date().timeIntervalSince1970)
		
		guard let actual = dates.first(where: { $0.end > todaysDate }) else {
			return todaysDate
		}
		let actualDateObject = Date(timeIntervalSince1970: TimeInterval(actual.end))
		
		let calendar = Calendar.current
		let year = calendar.component(.year, from: actualDateObject)
		
		if year < 2026 {
			return actual.end
		} else {
			var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .timeZone], from: actualDateObject)
	
			components.year = 2025
			

			if let correctedDate = calendar.date(from: components) {
				return Int(correctedDate.timeIntervalSince1970)
			} else {
				return todaysDate
			}
		}
	}
	
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

