//
//  NetworkError.swift
//  EventHub
//
//  Created by Igor Guryan on 27.11.2024.
//

enum NetworkError: Error {
    case invalidURL
    case networkError
    case decodingError
    case unknowedError
    case invalidResponse
    case serverError
    case noFutureEvents
    
    var errorText: String {
        switch self {
        case .invalidURL:
            return "Ошибка в URL адресе"
        case .invalidResponse:
            return "Получен некорректный ответ от сервера"
      case .unknowedError:
            return "Неизвестная ошибка"
//            case .rateLimited:
//                return "Вы исчерпали лимит запросов. Попробуйте позже"
//            case .sourcesTooMany:
//                return "Вы запросили слишком много источников в одном запросе. Попробуйте разделить запрос на два меньших запроса"
//            case .sourceDoesNotExist:
//                return "Вы запросили источник, которого не существует"
        case .noFutureEvents:
            return "Нету будущих событий"
        case .decodingError:
            return "Не получилось декодировать данные"
        default:
            return "Сервер не вернул ответ"
        }
    }
}
