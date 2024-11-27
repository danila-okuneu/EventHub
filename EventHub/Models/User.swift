//
//  User.swift
//  EventHub
//
//  Created by Vika on 20.11.24.
//

import UIKit

final class User {
	let uid: String
    var name: String
    var profileImage: UIImage?
    var about: String?
	
	init(uid: String, name: String, profileImage: UIImage? = nil, about: String? = nil) {
		self.uid = uid
		self.name = name
		self.profileImage = profileImage
		self.about = about
	}
}

enum ProfileMode {
    case view
    case edit
}

extension Notification.Name {
    static let readMoreTapped = Notification.Name("readMoreTapped")
}
