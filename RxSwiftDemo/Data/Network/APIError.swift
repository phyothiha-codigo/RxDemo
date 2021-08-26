//
//  APIError.swift
//  RxSwiftDemo
//
//  Created by Sheilar on 09/08/2021.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case invalidURL(String)
    case serverError(URL)
    case invalidPayload(URL)
    case forwarded(Error)
    case unknown
    
    var description: String {
        switch self {
        case .invalidURL(let path):
            return "❗️Invalid url path: \(path)"
        case .invalidPayload(let url):
            return "❗️Invalid response json payload for \(url)"
        case .serverError:
            return "❗️Something went wrong. Server Error \(self._code)"
        case .forwarded(let error):
            return "❗️Something went wrong.\(error.localizedDescription)"
        case .unknown:
            return "❗️Unknown error"
        }
    }
}

func transformApiError(error: Error) -> APIError {
    if let apiError = error as? APIError {
        return apiError
    } else {
        return APIError.forwarded(error)
    }
}

