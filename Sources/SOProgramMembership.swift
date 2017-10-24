import Foundation
import SOSwiftVocabulary

/// Used to describe membership in a loyalty programs (e.g. "StarAliance"), traveler clubs (e.g. "AAA"), purchase clubs ("Safeway Club"), etc.
public class SOProgramMembership: SOIntangible, ProgramMembership {
    
    public override class var type: String {
        return "ProgramMembership"
    }
    
    /// The organization (airline, travelers' club, etc.) the membership is made with.
    public var hostingOrganization: Organization?
    /// A member of an Organization or a ProgramMembership. Organizations can be members of organizations; ProgramMembership is typically for individuals. Supersedes members, musicGroupMember. Inverse property: memberOf.
    public var member: [OrganizationOrPerson]?
    /// A unique identifier for the membership.
    public var membershipNumber: String?
    /// The program providing the membership.
    public var programName: String?
    
    private enum CodingKeys: String, CodingKey {
        case hostingOrganization
        case member
        case membershipNumber
        case programName
    }
    
    public override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.hostingOrganization = try container.decodeIfPresent(SOOrganization.self, forKey: .hostingOrganization)
        self.member = try container.decodeOrganizationsOrPersonsIfPresent(forKey: .member)
        self.membershipNumber = try container.decodeIfPresent(String.self, forKey: .membershipNumber)
        self.programName = try container.decodeIfPresent(String.self, forKey: .programName)
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.hostingOrganization, forKey: .hostingOrganization)
        try container.encodeIfPresent(self.member, forKey: .member)
        try container.encodeIfPresent(self.membershipNumber, forKey: .membershipNumber)
        try container.encodeIfPresent(self.programName, forKey: .programName)
        
        try super.encode(to: encoder)
    }
}

public extension KeyedEncodingContainer {
    public mutating func encodeIfPresent(_ value: ProgramMembership?, forKey key: K) throws {
        if let typedValue = value as? SOProgramMembership {
            try self.encode(typedValue, forKey: key)
        }
    }
}
