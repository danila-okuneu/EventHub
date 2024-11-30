//
//  UIButtonExtension.swift
//  EventHub
//
//  Created by Надежда Капацина on 20.11.2024.
//


import UIKit

extension UIButton {

    /// - Returns: Настроенная кнопка `UIButton` с заданными параметрами.
    static func createButton(
        icon: String = "",
        title: String,
        uiFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium),
        foregroundColor: UIColor = .white,
        backgroundColor: UIColor = .appPurple,
        cornerRadius: CGFloat = 20,
        imagePadding: CGFloat = 20,
        imagePlacement: NSDirectionalRectEdge = .trailing,
        buttonHeight: CGFloat = 58,
        borderColor: UIColor = .clear,
        borderWidth: CGFloat = 0
    ) -> UIButton {
        let button = UIButton(type: .system)

        // Создаем конфигурацию для кнопки
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = foregroundColor // Цвет текста
        config.baseBackgroundColor = backgroundColor // Фоновый цвет

        // Настройка текста
        config.title = title
        // Настройка изображения
        if !icon.isEmpty,  let image = UIImage(named: icon) {
            config.image = image
            config.imagePadding = imagePadding // Расстояние между текстом и иконкой
            config.imagePlacement = imagePlacement

        }

        // Применение конфигурации
        button.configuration = config
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true

        // Установка высоты кнопки
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true

        // Настройка обводки
        button.layer.borderColor = borderColor.cgColor
        button.layer.borderWidth = borderWidth

        return button
    }
    
//    static func createNavButton(
//        icon: String = "arrow-left",
//        title: String?,
//        uiFont: UIFont = UIFont.systemFont(ofSize: 24, weight: .medium),
//        buttonHeight: CGFloat = 30,
//        tintColol: UIColor = .clear,
//        textColor: UIColor = .black,
//        imagePadding: CGFloat = 5
//
//    ) -> UIButton {
//        let button = UIButton(type: .system)
//
//        var config = UIButton.Configuration.filled()
//
//
//        config.title = title
//        config.baseForegroundColor = textColor
//        config.imagePlacement = .leading
//        config.imagePadding = imagePadding
//        
//        if !icon.isEmpty,  let image = UIImage(named: icon) {
//            config.image = image
//        }
//
//        button.configuration = config
//        button.layer.masksToBounds = true
//        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
//        button.tintColor = tintColol
//        
//
//        return button
//    }
}

