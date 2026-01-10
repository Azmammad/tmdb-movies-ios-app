//
//  TMDBImage.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 09/01/2026.
//

import Foundation

enum TMDBImage {
    static let baseURL = "https://image.tmdb.org/t/p/w500"
    
    static func poster(_ path: String?) -> URL? {
        guard let path else { return nil }
        return URL(string: baseURL + path)
    }
}

