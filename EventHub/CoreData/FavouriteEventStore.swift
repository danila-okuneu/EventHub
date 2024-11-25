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
    func saveEvent(_ event: FavouriteEvent) {
        let favouriteEvent = FavouriteEventCoreData(context: context)
        favouriteEvent.id = event.id
        favouriteEvent.title = event.title
        favouriteEvent.date = event.date
        favouriteEvent.imageURL = event.imageURL
        favouriteEvent.place = event.place
        
        do {
            try context.save()
            print("Event saved successfully!")
        } catch {
            print("Failed to save event: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Fetch Events
    func fetchAllEvents() -> [FavouriteEvent] {
        let fetchRequest: NSFetchRequest<FavouriteEventCoreData> = FavouriteEventCoreData.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map { coreDataEvent in
                FavouriteEvent(
                    id: coreDataEvent.id ?? "",
                    title: coreDataEvent.title ?? "",
                    imageURL: coreDataEvent.imageURL ?? "",
                    place: coreDataEvent.place ?? "",
                    date: coreDataEvent.date ?? ""
                )
            }
        } catch {
            print("Failed to fetch events: \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Delete Event
    func deleteEvent(withId id: String) {
        let fetchRequest: NSFetchRequest<FavouriteEventCoreData> = FavouriteEventCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
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
