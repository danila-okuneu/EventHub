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
		case .spb: return "Saint Petersburg"
		case .msk: return "Moscow"
		case .nsk: return "Novosibirsk"
		case .ekb: return "Yekaterinburg"
		case .nnv: return "Nizhny Novgorod"
		case .kzn: return "Kazan"
		case .vbg: return "Vyborg"
		case .smr: return "Samara"
		case .krd: return "Krasnodar"
		case .sochi: return "Sochi"
		case .ufa: return "Ufa"
		case .krasnoyarsk: return "Krasnoyarsk"
		case .kev: return "Kyiv"
		case .new: return "New York"
        }
    }
}
