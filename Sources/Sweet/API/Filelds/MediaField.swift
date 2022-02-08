//
//  MediaField.swift
//  
//
//  Created by zunda on 2022/01/31.
//

// https://developer.twitter.com/en/docs/twitter-api/data-dictionary/object-model/media

public enum MediaField: String, Field {
  static public var key: String { "media.fields" }
  
  case mediaKey = "media_key"
  case type
  case height
  case privateMetrics = "non_public_metrics"
  case publicMetrics = "public_metrics"
  case duration_ms
  case previewImageURL = "preview_image_url"
  case url
  case width
  case organicMetrics = "organic_metrics"
  case promotedMetrics = "promoted_metrics"
  case altText = "alt_text"
}
