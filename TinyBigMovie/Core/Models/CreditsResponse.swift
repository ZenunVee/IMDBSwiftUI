//
//  CreditsResponse.swift
//  TinyBigMovie
//
//  Created by Zenun Vucetovic on 3/14/24.
//

import Foundation

// MARK: CreditsResponse
struct CreditsResponse: Codable {
    let cast: [CastMember]
}

// MARK: CastMember Model
struct CastMember: Identifiable, Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?

    var profileURL: URL? {
        URL.tmdbImageURL(forPath: profilePath)
    }

    private enum CodingKeys: String, CodingKey {
        case id, name, character
        case profilePath = "profile_path"
    }
}
