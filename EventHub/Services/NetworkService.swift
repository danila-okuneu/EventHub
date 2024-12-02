//
//  NetworkService.swift
//  EventHub
//
//  Created by Igor Guryan on 23.11.2024.
//
//enum HTTPResonseCode: Int {
//    case success = 200
//    case notFound = 404
//    case serverError = 500
//}


enum RequestType {
    case eventsList
	case nextWeek
	case pastWeek
}


import Foundation

final class NetworkService {
    
	private let session = URLSession.shared
    private let urlPrefix = "https://kudago.com/public-api/v1.4/"
    
    
    func getEventsList(type: RequestType, eventsCount: Int = 20, categories: String = "") async throws -> [Event] {
        let citySlug = DefaultsManager.citySlug
		let url = try getURL(forRequestType: type, eventsNumber: eventsCount, categories: categories)
			
		let (data, response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
        print(response.statusCode)
        switch response.statusCode {
        case 200:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let dataResponse = try? decoder.decode(DataResponse.self, from: data) else { throw NetworkError.decodingError }
            return dataResponse.results
        default: throw NetworkError.unknowedError
        }
	}
    
    func getCategories() async throws -> [EventCategory] {
        guard let url = URL(string: urlPrefix + "event-categories/?lang=&order_by=&fields=") else { throw NetworkError.invalidURL }
        let (data, response) = try await session.data(from: url)
        guard let response = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
        switch response.statusCode {
        case 200:
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let dataResponse = try? decoder.decode([EventCategory].self, from: data) else { throw NetworkError.decodingError }
            return dataResponse
        default: throw NetworkError.unknowedError
        }
    }
	
	    
	private func getURL(forRequestType type: RequestType, eventsNumber: Int = 20, categories: String = "") throws -> URL {
		
		
		var urlPostfix = ""
		let urlSuffix = "events/?&fields=id,dates,short_title,title,place,body_text,images,favorites_count,categorires&expand=place"
		let currentDate = Int(Date().timeIntervalSince1970)
		let weekInSeconds = 7 * 24 * 60 * 60
		let citySlug = DefaultsManager.citySlug
		
		switch type {
		case .eventsList:
			urlPostfix = "&number=\(eventsNumber)&categories=\(categories)&location=\(citySlug)&actual_since=\(currentDate)"
		case .nextWeek:
			urlPostfix = "&number=\(eventsNumber)&categories=\(categories)&location=\(citySlug)&actual_since=\(currentDate)&actual_until=\(currentDate + weekInSeconds)"
		case .pastWeek:
			urlPostfix = "&number=\(eventsNumber)&categories=\(categories)&location=\(citySlug)&actual_since=\(currentDate - weekInSeconds)&actual_until=\(currentDate)"
		}
		
		guard let url = URL(string: urlPrefix + urlSuffix + urlPostfix) else { throw NetworkError.invalidURL }
		return url
    }

}

