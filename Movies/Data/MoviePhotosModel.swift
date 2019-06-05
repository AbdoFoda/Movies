//
//  MoviePhotosModel.swift
//  Movies
//
//  Created by Abdulrahman Sobbhy on 6/5/19.
//  Copyright © 2019 Abdulrahman Sobbhy. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let moviePhotos = try? newJSONDecoder().decode(MoviePhotos.self, from: jsonData)

import Foundation

// MARK: - MoviePhotos
struct MoviePhotos: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}
