//
//  City.swift
//  EventHub
//
//  Created by Igor Guryan on 02.12.2024.
//

enum City: String, CaseIterable {
    case spb
    case msk
    case nsk
    case ekb
    case nnv
    case kzn
    case vbg
    case smr
    case krd
    case sochi
    case ufa
    case krasnoyarsk
    case kev
    case new
    
    var cityName: String {
        switch self {
        case .spb: return "Санкт-Петербург"
        case .msk: return "Москва"
        case .nsk: return "Новосибирск"
        case .ekb: return "Екатеринбург"
        case .nnv: return "Нижний Новгород"
        case .kzn: return "Казань"
        case .vbg: return "Выборг"
        case .smr: return "Самара"
        case .krd: return "Краснодар"
        case .sochi: return "Сочи"
        case .ufa: return "Уфа"
        case .krasnoyarsk: return "Красноярск"
        case .kev: return "Киев"
        case .new: return "Нью-Йорк"
        }
    }
}
