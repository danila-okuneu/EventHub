//
//  EventProvider.swift
//  EventHub
//
//  Created by Igor Guryan on 29.11.2024.
//
import UIKit

final class EventProvider {
    
    static let shared = EventProvider()
    let networkService = NetworkService()
    var events: [EventType] = []
    var results: [Event] = []
    
    func fetchEventsFromAPI(category: String = "", sortingAscending: Bool = true) async  -> [Event] {
        var events: [Event] = []
        let actualSince = Int(Date().timeIntervalSince1970)
        let actualUntil = actualSince + 60 * 60 * 24 * 30 // Ближайшие 30 дней
        do {
            let eventsFromAPI = try await networkService.getEventsList(type: .eventsList, eventsCount: 100, categories: category)
            events = eventsFromAPI.sorted { $0.actualTime < $1.actualTime }.map { apiEvent in
                return Event(id: apiEvent.id, dates: apiEvent.dates[0], title: apiEvent.title, place: apiEvent.place, bodyText: apiEvent.bodyText, images: apiEvent.images, favoritesCount: apiEvent.favoritesCount, shortTitle: apiEvent.shortTitle)
            }
        } catch {
            print("Error fetching events: \(error)")
        }
        return events
    }
}

            
//            filter { event in
//                let validDates = event.dates.compactMap({ $0.end }).filter({ $0 >= actualSince && $0 <= actualUntil })
//                return !validDates.isEmpty
//            }.map { event in
//                var mutableEvent = event
//                mutableEvent.dates = event.dates.filter { $0.start >= actualSince && $0.start <= actualUntil }
//                return mutableEvent
//            }.sorted { event1, event2 in
//                if sortingAscending {
//                    // Сортировка по возрастанию для предстоящих событий
//                    let date1 = event1.dates.compactMap({ $0.start }).min() ?? 0
//                    let date2 = event2.dates.compactMap({ $0.start }).min() ?? 0
//                    return date1 < date2
//                } else {
//                    // Сортировка по убыванию для прошедших событий
//                    let date1 = event1.dates.compactMap({ $0.start }).max() ?? 0
//                    let date2 = event2.dates.compactMap({ $0.start }).max() ?? 0
//                    return date1 > date2
//                }
//                }
//            results = events.map { event in
//                return Event(id: event.id, dates: event.dates, title: event.title, place: event.place, bodyText: event.bodyText, images: event.images, favoritesCount: event.favoritesCount, shortTitle: event.shortTitle)
//            }
//        }    catch {
//                            print("Error fetching events: \(error)")
//                        }
//        return results
//    }
//}
//                guard let validDates = event.dates.compactMap({ $0.start }).filter({ $0 >= actualSince && $0 <= actualUntil }) else {
//                    return false
//                }
//                return !validDates.isEmpty
//            }
//            .map { event in
//                var mutableEvent = event
//                mutableEvent.dates = event.dates.filter { $0.start ?? 0 >= actualSince && $0.start ?? 0 <= actualUntil }
//                return mutableEvent
//            }
//            .sorted { event1, event2 in
//                if sortingAscending {
//                    // Сортировка по возрастанию для предстоящих событий
//                    let date1 = event1.dates?.compactMap({ $0.start }).min() ?? 0
//                    let date2 = event2.dates?.compactMap({ $0.start }).min() ?? 0
//                    return date1 < date2
//                } else {
//                    // Сортировка по убыванию для прошедших событий
//                    let date1 = event1.dates?.compactMap({ $0.start }).max() ?? 0
//                    let date2 = event2.dates?.compactMap({ $0.start }).max() ?? 0
//                    return date1 > date2
//                }
//                return Event(id: apiEvent.id, dates: date!, title: apiEvent.title, place: apiEvent.place, bodyText: apiEvent.bodyText, images: apiEvent.images, favoritesCount: apiEvent.favoritesCount, shortTitle: apiEvent.shortTitle)
