//
//  FirestoreManager.swift
//  EventHub
//
//  Created by Danila Okuneu on 24.11.24.
//

import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import UIKit

struct FirestoreManager {
	
	static private let db = Firestore.firestore()
	static private let storage = Storage.storage()
	

	
	static func saveUserData(user: User, uid: String) {
		let userData: [String: Any] = [
			"name": user.name,
			"about": user.about,
			"avatarImageURL": "URL"
		]
		
		db.collection("users").document(uid).setData(userData) { error in
			print(error?.localizedDescription)
		}
	}
	
	
	
	private func saveUser(photo: UIImage, uid: String) {
		
		
		
	}
	
	
	
}
