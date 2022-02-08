import Foundation

public struct SpaceModel {
  public let id: String
  public let state: SpaceState
  public let title: String?
  public let hostIDs: [String]
  public let lang: String?
  public let participantCount: Int?
  public let isTicketed: Bool?
  public let startedAt: Date?
  public let updatedAt: Date?
  public let createdAt: Date?
}

extension SpaceModel: Decodable {
  public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: SpaceField.self)
    self.id = try values.decode(String.self, forKey: .id)
    
    let state = try values.decode(String.self, forKey: .state)
    self.state = .init(rawValue: state)!
    
    let hostIDs = try? values.decode([String].self, forKey: .hostIDs)
    self.hostIDs = hostIDs ?? []
    
    self.isTicketed = try? values.decode(Bool.self, forKey: .isTicketed)

    self.participantCount = try? values.decode(Int.self, forKey: .participantCount)
        
    self.lang = try? values.decode(String.self, forKey: .lang)
    self.title = try? values.decode(String.self, forKey: .title)
    
    let formatter = TwitterDateFormatter()
    
    let createdAt = try? values.decode(String.self, forKey: .createdAt)
    self.createdAt = formatter.date(from: createdAt ?? "")
    
    let startedAt = try? values.decode(String.self, forKey: .startedAt)
    self.startedAt = formatter.date(from: startedAt ?? "")
    
    let updatedAt = try? values.decode(String.self, forKey: .updatedAt)
    self.updatedAt = formatter.date(from: updatedAt ?? "")
  }
}
