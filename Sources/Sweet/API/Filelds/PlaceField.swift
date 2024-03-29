//
//  PlaceField.swift
//
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/place

extension Sweet {
  public enum PlaceField: String, Field, Sendable {
    static public let key: String = "place.fields"

    case id
    case fullName = "full_name"
    case containedWithin = "contained_within"
    case country
    case countryCode = "country_code"
    case geo
    case name
    case placeType = "place_type"
  }
}
