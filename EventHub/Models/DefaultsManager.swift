//
//  DefaultsManager.swift
//  EventHub
//
//  Created by Danila Okuneu on 24.11.24.
//

import Foundation

struct DefaultsManager {
	
	static var currentUser: User?
	
	static var isOnboarded: Bool {
		get {
			UserDefaults.standard.bool(forKey: "isOnboarded")
		} set {
			UserDefaults.standard.bool(forKey: "isOnboarded")
		}
	}
	static var isRegistered: Bool {
		get {
			UserDefaults.standard.bool(forKey: "isRegistered")
		} set {
			UserDefaults.standard.set(newValue, forKey: "isRegistered")
		}
		
	}
	static var isRemembered: Bool {
		get {
			return (UserDefaults.standard.value(forKey: "isRemembered") ?? true) as! Bool
		} set {
			UserDefaults.standard.setValue(newValue, forKey: "isRemembered")
		}
	}
}

