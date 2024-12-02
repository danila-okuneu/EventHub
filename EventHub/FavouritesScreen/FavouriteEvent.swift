//
//  FavouriteEvent.swift
//  EventHub
//
//  Created by Bakgeldi Alkhabay on 01.12.2024.
//

import Foundation

struct FavouriteEvent {
	let id: Int
    let title: String
    let imageURL: String
    let place: String
    let date: Int
    
    static func from(_ event: EventType) -> FavouriteEvent {
        // Извлекаем ID
        let id = event.id
        
        // Определяем название
        let title = event.shortTitle.isEmpty ? event.title : event.shortTitle
        
        // Извлекаем URL изображения
        let imageURL: String
        if let imageURLString = event.images.first?.image {
            imageURL = imageURLString
        } else {
            imageURL = "https://via.placeholder.com/300" // Плейсхолдер
        }
        
        // Извлекаем место
        let place: String
        if let address = event.place?.address, !address.isEmpty {
            place = address
        } else if let placeTitle = event.place?.title, !placeTitle.isEmpty {
            place = placeTitle
        } else {
            place = "Place not provided"
        }
        
        // Извлекаем дату
		let date = event.actualDate
		
        return FavouriteEvent(id: id, title: title, imageURL: imageURL, place: place, date: date)
    }
}

extension Int {
    func formattedDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: date)
    }
}
