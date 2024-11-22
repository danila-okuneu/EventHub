//
//  CustomSegmentControl.swift
//  EventHub
//
//  Created by Надежда Капацина on 22.11.2024.
//
import UIKit

class CustomSegmentedControl: UIControl {

    // MARK: - Properties

    private var labels: [UILabel] = []
    private var backgroundLayers: [CAShapeLayer] = []
    private var selectedBackgroundLayer = CAShapeLayer()
    private var selectedIndex: Int = 0
    private var segmentTitles: [String]!

    // MARK: - Initialization

    init(items: [String]) {
        super.init(frame: .zero)
        self.segmentTitles = items
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup

    private func setupView() {
        layer.cornerRadius = bounds.height / 2
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)

        setupLabels()
        setupBackgroundLayers()
        setupSelectedBackgroundLayer()
    }

    private func setupLabels() {
        for (index, title) in segmentTitles.enumerated() {
            let label = UILabel()
            label.text = title
            label.textAlignment = .center
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            addSubview(label)
            labels.append(label)

            
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(segmentTapped(gesture:)))
            label.addGestureRecognizer(tapGesture)
            label.tag = index
        }
    }

    private func setupBackgroundLayers() {
        for _ in 0..<segmentTitles.count {
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = UIColor.clear.cgColor
            layer.insertSublayer(shapeLayer, at: 0)
            backgroundLayers.append(shapeLayer)
        }
    }

    private func setupSelectedBackgroundLayer() {
        selectedBackgroundLayer.fillColor = UIColor.clear.cgColor
        selectedBackgroundLayer.shadowColor = UIColor.black.cgColor
        selectedBackgroundLayer.shadowOpacity = 0.1
        selectedBackgroundLayer.shadowRadius = 4
        selectedBackgroundLayer.shadowOffset = CGSize(width: 0, height: 2)
        layer.insertSublayer(selectedBackgroundLayer, at: 1)
    }

    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrames()
    }

    private func updateFrames() {
        guard !labels.isEmpty else { return }

        let segmentWidth = bounds.width / CGFloat(segmentTitles.count)

        for (index, label) in labels.enumerated() {
            label.frame = CGRect(x: CGFloat(index) * segmentWidth, y: 0, width: segmentWidth, height: bounds.height)

            let path = UIBezierPath(roundedRect: label.bounds, cornerRadius: bounds.height / 2)
            backgroundLayers[index].path = path.cgPath

            if index == selectedIndex {
                selectedBackgroundLayer.path = path.cgPath
            }
        }
    }

    // MARK: - Actions

    @objc private func segmentTapped(gesture: UITapGestureRecognizer) {
        guard let tappedLabel = gesture.view as? UILabel else { return }
        let index = tappedLabel.tag
        setSelectedIndex(index: index)
        sendActions(for: .valueChanged)
    }

    // MARK: - Public Methods

    func setSelectedIndex(index: Int) {
        guard index >= 0 && index < segmentTitles.count else { return }
        selectedIndex = index
        updateAppearance()
    }

    var selectedSegmentIndex: Int {
        get {
            return selectedIndex
        }
        set {
            setSelectedIndex(index: newValue)
        }
    }

    // MARK: - Appearance Update

        private func updateAppearance() {
            UIView.animate(withDuration: 0.3) { [self] in
                for (index, label) in labels.enumerated() {
                    label.textColor = index == selectedIndex ? .appPurple : .gray
                    backgroundLayers[index].fillColor = index == selectedIndex ? UIColor.white.cgColor : UIColor.clear.cgColor
                }
                if !labels.isEmpty && selectedIndex >= 0 && selectedIndex < labels.count {
                    let selectedLabel = labels[selectedIndex]
                    let path = UIBezierPath(roundedRect: selectedLabel.bounds, cornerRadius: selectedLabel.bounds.height / 2)
                    selectedBackgroundLayer.path = path.cgPath
                }
            }
        }
    
    
    }
