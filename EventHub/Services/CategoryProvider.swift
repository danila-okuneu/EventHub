//
//  CategoriesProvider.swift
//  EventHub
//
//  Created by Igor Guryan on 27.11.2024.
//
import UIKit

final class CategoryProvider {
    static let shared = CategoryProvider()
    
    private let networkService = NetworkService()
    
    private let categoryColors: [UIColor] = [
        .appRed,
        .appYellow,
        .appGreen,
        .appCyanDark,
        .appOrange,
        .appPurple,
        
    ]
    
    private let sfSymbols: [String] = [
        "briefcase.fill", "film.fill", "music.note.list", "book.fill",
        "gamecontroller.fill", "paintpalette.fill", "scissors", "sparkles",
        "gift.fill", "teddybear.fill", "square.grid.2x2.fill", "party.popper",
        "camera.fill", "magnifyingglass", "figure.walk", "cart.fill",
        "hands.sparkles.fill", "tag.fill", "theatermasks.fill", "bus.fill",
        "building.columns.fill"
    ]
    
    private let nameShortcuts: [String: String] = [
        "События для бизнеса":  "Бизнес",
        "Ярмарки (Развлечения, Ярмарки)": "Ярмарки",
        "Шопинг (Магазины)": "Шопинг",
    ]
    
    func fetchCategoriesFromAPI() async  -> [Category] {
        var categories: [Category] = []
  
        do {
            let categoriesFromAPI = try await networkService.getCategories(type: .allCategories)
            //            print(categoriesFromAPI)
            categories = categoriesFromAPI.enumerated().map { index, apiCategory in
                let color = self.categoryColors[index % self.categoryColors.count]
                let sfSymbol = self.sfSymbols[index % self.sfSymbols.count]
                let shortenedName = self.nameShortcuts[apiCategory.name] ?? apiCategory.name
                return Category(name: shortenedName, color: color, sfSymbol: sfSymbol, slug: apiCategory.slug)
            }
        } catch {
            print("Error fetching categories: \(error)")
        }
//            print(categories)
        return categories
    }
}
