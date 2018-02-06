import Foundation
import SOSwiftVocabulary

/// The geographic coordinates of a place or event.
public class SOGeoCoordinates: SOStructuredValue, GeoCoordinates {
    
    public override class var type: String {
        return "GeoCoordinates"
    }
    
    public override class var dynamicSubtypes: [Dynamic.Type] {
        return []
    }
    
    /// Physical address of the item.
    public var address: PostalAddressOrText?
    /// The country. For example, USA. You can also provide the two-letter ISO 3166-1 alpha-2 country code.
    public var addressCountry: CountryOrText?
    /// The elevation of a location (WGS 84).
    public var elevation: NumberOrText?
    /// The latitude of a location. For example 37.42242 (WGS 84).
    public var latitude: NumberOrText?
    /// The longitude of a location. For example -122.08585 (WGS 84).
    public var longitude: NumberOrText?
    /// The postal code. For example, 94043
    public var postalCode: String?
    
    private enum CodingKeys: String, CodingKey {
        case address
        case addressCountry
        case elevation
        case latitude
        case longitude
        case postalCode
    }
    
    public override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.address = try container.decodePostalAddressOrTextIfPresent(forKey: .address)
        self.addressCountry = try container.decodeCountryOrTextIfPresent(forKey: .addressCountry)
        self.elevation = try container.decodeNumberOrTextIfPresent(forKey: .elevation)
        self.latitude = try container.decodeNumberOrTextIfPresent(forKey: .latitude)
        self.longitude = try container.decodeNumberOrTextIfPresent(forKey: .longitude)
        self.postalCode = try container.decodeIfPresent(String.self, forKey: .postalCode)
        
        try super.init(from: decoder)
    }
    
    public override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(self.address, forKey: .address)
        try container.encodeIfPresent(self.addressCountry, forKey: .addressCountry)
        try container.encodeIfPresent(self.elevation, forKey: .elevation)
        try container.encodeIfPresent(self.latitude, forKey: .latitude)
        try container.encodeIfPresent(self.longitude, forKey: .longitude)
        try container.encodeIfPresent(self.postalCode, forKey: .postalCode)
        
        try super.encode(to: encoder)
    }
    
    // MARK: - Attributed
    public override func displayDescription(forAttributeNamed attributeName: String) -> String? {
        switch attributeName {
        case CodingKeys.address.rawValue:
            return "Physical address of the item."
        case CodingKeys.addressCountry.rawValue:
            return "The country. For example, USA."
        case CodingKeys.elevation.rawValue:
            return "The elevation of a location (WGS 84)."
        case CodingKeys.latitude.rawValue:
            return "The latitude of a location."
        case CodingKeys.longitude.rawValue:
            return "The longitude of a location."
        case CodingKeys.postalCode.rawValue:
            return "The postal code."
        default:
            return super.displayDescription(forAttributeNamed: attributeName)
        }
    }
    
    public override func setValue(_ value: Any?, forAttributeNamed attributeName: String) {
        switch attributeName {
        case CodingKeys.address.rawValue:
            self.address = value as? PostalAddressOrText
        case CodingKeys.addressCountry.rawValue:
            self.addressCountry = value as? CountryOrText
        case CodingKeys.elevation.rawValue:
            self.elevation = value as? NumberOrText
        case CodingKeys.latitude.rawValue:
            self.latitude = value as? NumberOrText
        case CodingKeys.longitude.rawValue:
            self.longitude = value as? NumberOrText
        case CodingKeys.postalCode.rawValue:
            self.postalCode = value as? String
        default:
            super.setValue(value, forAttributeNamed: attributeName)
        }
    }
}

public extension KeyedEncodingContainer {
    public mutating func encodeIfPresent(_ value: GeoCoordinates?, forKey key: K) throws {
        if let typedValue = value as? SOGeoCoordinates {
            try self.encode(typedValue, forKey: key)
        }
    }
}
