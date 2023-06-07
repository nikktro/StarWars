//
//  Film.swift
//  StarWars
//
//  Created by Nikolay Trofimov on 07.06.2023.
//

import Foundation

// MARK: - Welcome
struct Saga: Codable {
  let count: Int
  let next, previous: JSONNull?
  let results: [Episode]
}

// MARK: - Result
struct Episode: Codable {
  let title: String
  let episodeID: Int
  let openingCrawl, director, producer, releaseDate: String
  let characters, planets, starships, vehicles: [String]
  let species: [String]
  let created, edited: String
  let url: String

  enum CodingKeys: String, CodingKey {
    case title
    case episodeID = "episode_id"
    case openingCrawl = "opening_crawl"
    case director, producer
    case releaseDate = "release_date"
    case characters, planets, starships, vehicles, species, created, edited, url
  }
}


// MARK: - Encode/decode helpers
class JSONNull: Codable, Hashable {

  public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
    return true
  }

  public func hash(into hasher: inout Hasher) {
    hasher.combine(0)
  }

  public init() {}

  public required init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    if !container.decodeNil() {
      throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encodeNil()
  }
}
