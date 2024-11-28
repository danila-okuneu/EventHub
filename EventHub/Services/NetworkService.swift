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


enum RequestType: String {
    case eventsList = "events/?location=krd&actual_since=1732313335&fields=id,dates,short_title,title,place,body_text,images,favorites_count,categorires&expand=place"
    case allCategories = "event-categories/?lang=&order_by=&fields="
}


import Foundation

final class NetworkService {
    
    private let baseURLString = "https://kudago.com/public-api/v1.4/"
    private let session = URLSession.shared
    
    
    
	func getEventsList(type: RequestType) async throws -> [EventType] {
		
		guard let url = URL(string: baseURLString + type.rawValue) else { throw NetworkError.invalidURL }
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
    
    func getCategories(type: RequestType) async throws -> [EventCategory] {
        guard let url = URL(string: baseURLString + type.rawValue) else { throw NetworkError.invalidURL }
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
//    func getEventsList(completion: @escaping (Result<[EventType], NetworkError>) -> Void) {
//        let getUrlResult = getURL(forRequestType: .eventsList)
//        switch getUrlResult {
//        case .success(let url):
//			print(url)
//            let request = URLRequest(url: url)
//			
//            let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
//                print(response ?? "No response")
//                guard let self, let response else {
//                    completion(.failure(.unknowedError))
//                    return
//                }
//                let responseResult = self.handle(response: response)
//                switch responseResult {
//                case .success:
//                    if let error = error {
//                        completion(.failure(.networkError))
//                        return
//                    }
//                    if let data {
//						print(String(data: data, encoding: .utf8))
//                        let decoder = JSONDecoder()
//                        decoder.keyDecodingStrategy = .convertFromSnakeCase
//						
//                        if let events = try? decoder.decode(DataResponse.self, from: data) {
//                            completion(.success(events.results))
//                            
//                        } else {
//                            completion(.failure(.decodingError))
//                        }
//                    }
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//               
//                
//                
//            }
//            dataTask.resume()
//        case .failure(let error):
//            completion(.failure(error))
//            return
//        }
        
	
	    
    private func getURL(forRequestType type: RequestType) -> Result<URL, NetworkError> {
        guard let url = URL(string: baseURLString + type.rawValue) else {
            return .failure(.invalidURL)
        }
        return .success(url)
    }
    
//    private func handle(response: URLResponse) -> Result<Void, NetworkError> {
//        guard let response = response as? HTTPURLResponse,
//              let code = HTTPResonseCode(rawValue: response.statusCode) else{
//            return .failure(.invalidResponse)
//        }
//        switch code {
//        case .success:
//            return .success(())
//        case .notFound, .serverError:
//            return .failure(.serverError)
//            
//    
//        }
//        
//    }
}

