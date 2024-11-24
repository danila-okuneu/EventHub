//
//  User.swift
//  EventHub
//
//  Created by Vika on 20.11.24.
//

import UIKit

struct User {
    var name: String
    var profileImage: UIImage?
    var about: String?
}

enum ProfileMode {
    case view
    case edit
}

extension Notification.Name {
    static let readMoreTapped = Notification.Name("readMoreTapped")
}
