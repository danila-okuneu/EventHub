//
//  Int2Date.swift
//  EventHub
//
//  Created by Danila Okuneu on 28.11.24.
//

import Foundation

extension Int {
	
	func formatTo(_ format: DateFormat) -> String {
		let date = Date(timeIntervalSince1970: TimeInterval(self))
		let formatter = DateFormatter()
		formatter.dateFormat = format.rawValue
		formatter.locale = Locale(identifier: "en_US")
		return formatter.string(from: date)
	}
	
	enum DateFormat: String {
		case exploreDay = "d"
		case explorePreview = "d \n MMM"
		case exploreMonth = "MMM"
		case eventPreview = "E, MMM d • h:mm a"
		case detailsHeaderDate = "d MMMM, yyyy"
		case detailsDayTime = "EEEE h:mm a"
		case detailsTime = "h:mm a"
	}
}
