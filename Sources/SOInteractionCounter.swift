import Foundation
import SOSwiftVocabulary

public class SOInteractionCounter: SOStructuredValue, InteractionCounter {
    
    public override class var type: String {
        return "InteractionCounter"
    }
    
    /// The WebSite or SoftwareApplication where the interactions took place.
    public var interactionService: SoftwareApplicationOrWebsite?
    /// The Action representing the type of interaction. For up votes, +1s, etc. use LikeAction. For down votes use DislikeAction. Otherwise, use the most specific Action.
    public var interactionType: Action?
    /// The number of interactions for the CreativeWork using the WebSite or SoftwareApplication.
    public var userInteractionCount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case interactionService
        case interactionType
        case userInteractionCount
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try container.decodeSoftwareApplicationOrWebsiteIfPresent(forKey: .interactionService) {
            self.interactionService = value
        }
        if let value = try container.decodeIfPresent(SOAction.self, forKey: .interactionType) {
            self.interactionType = value
        }
        if let value = try container.decodeIfPresent(Int.self, forKey: .userInteractionCount) {
            self.userInteractionCount = value
        }
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.interactionService, forKey: .interactionService)
        if let value = self.interactionType as? SOAction {
            try container.encode(value, forKey: .interactionType)
        }
        if let value = self.userInteractionCount {
            try container.encode(value, forKey: .userInteractionCount)
        }
        
        try super.encode(to: encoder)
    }
}
