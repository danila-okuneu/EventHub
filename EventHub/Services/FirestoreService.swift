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

struct FirestoreService {
	
	static private let db = Firestore.firestore()
	
	static func userExists(uid: String) async throws {
		
		let document = try await db.collection("users").document(uid).getDocument()
		
		if !document.exists {
			throw FirestoreError.userNotFound
		}
	}
	
	static func getUserData(with uid: String) async throws -> [String: Any]? {
		
		let document = try await db.collection("users").document(uid).getDocument()
		
		if !document.exists {
			throw FirestoreError.userNotFound
		}
		
		return document.data()
	}

	
	static func changeName(forUserWith uid: String, to name: String) async throws {
		guard !name.isEmpty else {
			try await changeName(forUserWith: uid, to: "Unknown")
			return
		}
		
		try await userExists(uid: uid)
		
		do {
			try await db.collection("users").document(uid).updateData(["name": name])
			DefaultsManager.currentUser?.name = name
		} catch {
			throw FirestoreError.cannotChangeName
		}
	}
	
	static func changeAbout(forUserWith uid: String, to about: String) async throws {
		guard !about.isEmpty else { throw FirestoreError.emptyAbout }
		try await userExists(uid: uid)
		
		do {
			try await db.collection("users").document(uid).updateData(["about": about])
			DefaultsManager.currentUser?.about = about
		} catch {
			throw FirestoreError.cannotChangeAbout
		}
	}
	
	
	static func saveUserData(user: User, uid: String) {
		
		
		let userData: [String: Any] = [
			"name": user.name,
			"about": user.about ?? NSNull(),
			"avatarImageURL": uploadUser(photo: nil, uid: uid) ?? NSNull()
		]
		
		db.collection("users").document(uid).setData(userData) { error in
			print(error?.localizedDescription)
		}
	}
	
	static func fetchUserData(uid: String) async throws {
		
		guard let data = try await getUserData(with: uid) else { return }
		
		let name = data["name"] as? String ?? "Unknown"
		let about = data["about"] as? String ?? ""
		let image: UIImage? = UIImage(named: "photoProfile")
		
		let user = User(uid: uid, name: name, profileImage: image, about: about)
		DefaultsManager.currentUser = user
	}
	
	
	
	static func uploadUser(photo: UIImage?, uid: String) -> String? {
		
		
		return "url"
	}
}

enum FirestoreError: Error {
	
	case emptyName
	case cannotChangeName
	case emptyAbout
	case cannotChangeAbout
	case userNotFound
	case documentEmpty
	
}
