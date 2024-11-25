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
	
	
	static func changeName(for name: String, uid: String) async throws {
		try await db.collection("users").document(uid).updateData(["name": name])
	}
	
	static func changeAbout(for about: String, uid: String) async throws {
		try await db.collection("users").document(uid).updateData(["about": about])
	}
	
	
	static func saveUserData(user: User, uid: String) {
		
		let userData: [String: Any] = [
			"name": user.name,
			"about": user.about ?? NSNull(),
			"avatarImageURL": uploadUser(photo: nil, uid: uid) ?? NSNull()
		]
		
		db.collection("users").document(uid).setData(userData) { error in
		}
	}
	
	static func fetchUserData(uid: String) async throws {
		let snapshot = try await db.collection("users").document(uid).getDocument()
		guard let data = snapshot.data() else { throw NSError(domain: "FirestoreManager", code: 404, userInfo: [NSLocalizedDescriptionKey: "Пользователь не найден."]) }
		
		let name = data["name"] as? String ?? "Unknown"
		
		let about = data["about"] as? String ?? ""
		let image: UIImage? = UIImage(named: "photoProfile")
		
		let user = User(name: name, profileImage: image, about: about)
		print(user)
		
		DefaultsManager.currentUser = user
	}
	
	
	
	static func uploadUser(photo: UIImage?, uid: String) -> String? {
		
		let loginVC = LoginViewController()
		loginVC.modalPresentationStyle = .pageSheet
		
		
		
		return "url"
	}
	
	
	
}
