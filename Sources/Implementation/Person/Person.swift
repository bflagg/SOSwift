import Foundation

/// A person (alive, dead, undead, or fictional).
public class Person: Thing, SchemaPerson {
    override public var type: String {
        return "Person"
    }
    
    /// An additional name for a Person, can be used for a middle name.
    public var additionalName: String?
    /// Physical address of the item.
    public var address: SchemaPostalAddressOrText?
    /// An organization that this person is affiliated with. For example, a school/university, a club, or a team.
    public var affiliation: SchemaOrganization?
    /// An organization that the person is an alumni of. Inverse property: alumni.
    public var alumniOf: SchemaEducationalOrganizationOrOrganization?
    /// An award won by or for this item.
    public var award: String?
    /// Date of birth.
    public var birthDate: SchemaDate?
    /// The place where the person was born.
    public var birthPlace: SchemaPlace?
    /// The brand(s) associated with a product or service, or the brand(s) maintained by an organization or business person.
    public var brand: SchemaBrandOrOrganization?
    /// A child of the person.
    public var children: [SchemaPerson]?
    /// A colleague of the person.
    public var colleague: SchemaPersonOrURL?
    /// A contact point for a person or organization.
    public var contactPoint: SchemaContactPoint?
    /// Date of death.
    public var deathDate: SchemaDate?
    /// The place where the person died.
    public var deathPlace: SchemaPlace?
    /// The Dun & Bradstreet DUNS number for identifying an organization or business person.
    public var duns: String?
    /// Email address.
    public var email: String?
    /// Family name. In the U.S., the last name of an Person. This can be used along with givenName instead of the name property.
    public var familyName: String?
    /// The fax number.
    public var faxNumber: String?
    /// The most generic uni-directional social relation.
    public var follows: [SchemaPerson]?
    /// A person or organization that supports (sponsors) something through some kind of financial contribution.
    public var funder: SchemaOrganizationOrPerson?
    /// Gender of the person. While http://schema.org/Male and http://schema.org/Female may be used, text strings are also acceptable for people who do not identify as a binary gender.
    public var gender: GenderOrText?
    /// Given name. In the U.S., the first name of a Person. This can be used along with familyName instead of the name property.
    public var givenName: String?
    /// The Global Location Number (GLN, sometimes also referred to as International Location Number or ILN) of the respective organization, person, or place. The GLN is a 13-digit number used to identify parties and physical locations.
    public var globalLocationNumber: String?
    /// Indicates an OfferCatalog listing for this Organization, Person, or Service.
    public var hasOfferCatalog: SchemaOfferCatalog?
    /// Points-of-Sales operated by the organization or person.
    public var hasPOS: SchemaPlace?
    /// The height of the item.
    public var height: SchemaDistanceOrQuantitativeValue?
    /// A contact location for a person's residence.
    public var homeLocation: SchemaContactPointOrPlace?
    /// An honorific prefix preceding a Person's name such as Dr/Mrs/Mr.
    public var honorificPrefix: String?
    /// An honorific suffix preceding a Person's name such as M.D. /PhD/MSCSW.
    public var honorificSuffix: String?
    /// The International Standard of Industrial Classification of All Economic Activities (ISIC), Revision 4 code for a particular organization, business person, or place.
    public var isicV4: String?
    /// The job title of the person (for example, Financial Manager).
    public var jobTitle: String?
    /// The most generic bi-directional social/work relation.
    public var knows: [SchemaPerson]?
    /// A pointer to products or services offered by the organization or person. Inverse property: offeredBy.
    public var makesOffer: [SchemaOffer]?
    /// An Organization (or ProgramMembership) to which this Person or Organization belongs. Inverse property: member.
    public var memberOf: [SchemaOrganizationOrProgramMembership]?
    /// The North American Industry Classification System (NAICS) code for a particular organization or business person.
    public var naics: String?
    /// Nationality of the person.
    public var nationality: SchemaCountry?
    /// The total financial value of the person as calculated by subtracting assets from liabilities.
    public var netWorth: SchemaMonetaryAmountOrPriceSpecification?
    /// Products owned by the organization or person.
    public var owns: [SchemaProductOrService]?
    /// A parent of this person.
    public var parent: SchemaPerson?
    /// Event that this person is a performer or participant in.
    public var performerIn: SchemaEvent?
    /// The most generic familial relation.
    public var relatedTo: [SchemaPerson]?
    /// A pointer to products or services sought by the organization or person (demand).
    public var seeks: [SchemaDemand]?
    /// A sibling of the person.
    public var sibling: SchemaPerson?
    /// A person or organization that supports a thing through a pledge, promise, or financial contribution. e.g. a sponsor of a Medical Study or a corporate sponsor of an event.
    public var sponsor: SchemaOrganizationOrPerson?
    /// The person's spouse.
    public var spouse: SchemaPerson?
    /// The Tax / Fiscal ID of the organization or person, e.g. the TIN in the US or the CIF/NIF in Spain.
    public var taxID: String?
    /// The telephone number.
    public var telephone: String?
    /// The Value-added Tax ID of the organization or person.
    public var vatID: String?
    /// The weight of the product or person.
    public var weight: SchemaQuantitativeValue?
    /// A contact location for a person's place of work.
    public var workLocation: SchemaContactPointOrPlace?
    /// Organizations that the person works for.
    public var worksFor: [SchemaOrganization]?
}
