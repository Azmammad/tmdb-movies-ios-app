//
//  NetworkError.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 05.01.26.
//

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case encodingError
    case serverError(statusCode: Int)
    case unknown(Error)
}
