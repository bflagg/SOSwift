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
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let value = try container.decodeIfPresent(SOOrganization.self, forKey: .hostingOrganization) {
            self.hostingOrganization = value
        }
        if let value = try container.decodeOrganizationsOrPersonsIfPresent(forKey: .member) {
            self.member = value
        }
        if let value = try container.decodeIfPresent(String.self, forKey: .membershipNumber) {
            self.membershipNumber = value
        }
        if let value = try container.decodeIfPresent(String.self, forKey: .programName) {
            self.programName = value
        }
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let value = self.hostingOrganization as? SOOrganization {
            try container.encode(value, forKey: .hostingOrganization)
        }
        try container.encodeIfPresent(self.member, forKey: .member)
        if let value = self.membershipNumber {
            try container.encode(value, forKey: .membershipNumber)
        }
        if let value = self.programName {
            try container.encode(value, forKey: .programName)
        }
        
        try super.encode(to: encoder)
    }
}
