//
//  FavouriteEventStore.swift
//  EventHub
//
//  Created by Bakgeldi Alkhabay on 25.11.2024.
//

import Foundation
import CoreData

final class FavouriteEventStore {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = DBStore.shared.persistentContainer.viewContext) {
        self.context = context
    }
    
    // MARK: - Save Event
	func saveEvent(_ event: Event) {
        let favouriteEvent = FavouriteEventCoreData(context: context)
		
		favouriteEvent.id = Int64(event.id)
		favouriteEvent.actualDate = Int64(event.actualDate)
		favouriteEvent.title = event.title
		favouriteEvent.shortTitle = event.shortTitle
		
		var corePlace = ""
		if let place = event.place, place.address != "" {
			corePlace = place.address
		} else if let place = event.place {
			corePlace = place.title
		}
		
		favouriteEvent.imageURL = event.images[0].image
		favouriteEvent.place = corePlace
		favouriteEvent.bodyText = event.bodyText
		favouriteEvent.favouritesCount = Int64(event.favoritesCount)
		
        do {
            try context.save()
            print("Event saved successfully!")
        } catch {
            print("Failed to save event: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch Events
	func fetchAllEvents() -> [Event] {
        let fetchRequest: NSFetchRequest<FavouriteEventCoreData> = FavouriteEventCoreData.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { coreDataEvent in
				Event(
					id: Int(coreDataEvent.id),
					dates: [DateElement(start: -1, end: Int(coreDataEvent.actualDate))],
					title: coreDataEvent.title ?? "",
					place: Place(id: -1, address: coreDataEvent.place ?? "", title: ""),
					bodyText: coreDataEvent.bodyText ?? "",
					images: [Image(image: coreDataEvent.imageURL ?? "", source: Source(name: "", link: ""))],
					favoritesCount: Int(coreDataEvent.favouritesCount),
					shortTitle: coreDataEvent.shortTitle ?? ""
				)
            }
        } catch {
            print("Failed to fetch events: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Delete Event
	func deleteEvent(withId id: Int) {
        let fetchRequest: NSFetchRequest<FavouriteEventCoreData> = FavouriteEventCoreData.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id == %ld", Int64(id))
        
        do {
            let results = try context.fetch(fetchRequest)
            for event in results {
                context.delete(event)
            }
            try context.save()
            print("Event deleted successfully!")
        } catch {
            print("Failed to delete event: \(error.localizedDescription)")
        }
    }
}
