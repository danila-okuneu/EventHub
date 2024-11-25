//
//  OnboardingModel.swift
//  EventHub
//
//  Created by Danila Okuneu on 16.11.24.
//

import UIKit




struct OnboardingScreen {
	let image: UIImage
	let title: String
	let subTitle: String
	
	static let list: [OnboardingScreen] = [
		OnboardingScreen(
			image: .homeScreenshot,
			title: "Explore Upcoming and \n Nearby Events",
			subTitle: "First subtitle"
		),
		OnboardingScreen(
			image: .calendarScreenshot,
			title: " Web Have Modern Events \n Calendar Feature",
			subTitle: "Second subtitle"
		),
		OnboardingScreen(
			image: .mapScreenshot,
			title: "  To Look Up More Events or \n Activities Nearby By Map",
			subTitle: "Third subtitle"
		)
	]
}
