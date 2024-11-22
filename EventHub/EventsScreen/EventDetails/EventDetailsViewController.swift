//
//  EventDetailsViewController.swift
//  EventHub
//
//  Created by Vika on 22.11.24.
//

import UIKit

// Моковые данные события (например, для тестирования)
let mockEventsEng = [
    EventModel(
        id: 1,
        publicationDate: 1669305600,
        dates: [
            EventDate(
                startDate: "2024-12-01",
                startTime: "18:00:00",
                start: 1733056800
            )
        ],
        title: "Symphony Orchestra Concert",
        description: "A magnificent evening of classical music featuring the best works of Mozart and Beethoven.",
        bodyText: "Join us for an unforgettable concert of the Symphony Orchestra, showcasing masterpieces by the greatest composers of all time.",
        images: [
            EventImage(image: "mockOrchestra")
        ],
        shortTitle: "Symphony Orchestra",
        participants: [
            Agent(title: "Moscow Symphony Orchestra", ctype: "organization")
        ],
        place: Place(
            title: "Bolshoi Theater",
            address: "Theater Square, 1, Moscow, Russia"
        )
    )
]

class EventDetailsViewController: UIViewController {
    
    // MARK: - Properties

    private let eventDetailsView = EventDetailsView()
    private var eventData: EventModel

    // MARK: - Initializer

    // Инициализатор для передачи данных о событии
    init(event: EventModel) {
        self.eventData = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        self.view = eventDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        eventDetailsView.frame = view.bounds
        eventDetailsView.configure(with: eventData)
        setupActions()
    }
    
    // MARK: - Setup button actions
    
    private func setupActions() {
        // Назначаем действия на кнопки
        eventDetailsView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        eventDetailsView.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        eventDetailsView.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func shareButtonTapped() {
        let textToShare = "Check out this event: \(eventData.title)"
        let activityVC = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @objc private func bookmarkButtonTapped() {
        print("Bookmark tapped!")
    }
}

@available(iOS 17.0, *)
#Preview {
    EventDetailsViewController(event: mockEventsEng[0]) // Передаем mockEvent в инициализатор
}
