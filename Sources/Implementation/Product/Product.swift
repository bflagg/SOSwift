import Foundation

/// Any offered product or service. For example: a pair of shoes; a concert ticket; the rental of a car; a haircut; or an episode of a TV show streamed online.
public class Product: Thing, SchemaProduct {
    override public var type: String {
        return "Product"
    }
    
    /// A property-value pair representing an additional characteristics of the entitity, e.g. a product feature or another characteristic for which there is no matching property in schema.org.
    /// - Note: Publishers should be aware that applications designed to use specific schema.org properties (e.g. http://schema.org/width, http://schema.org/color, http://schema.org/gtin13, ...) will typically expect such data to be provided using those properties, rather than using the generic property/value mechanism.
    public var additionalProperty: SchemaPropertyValue?
    /// The overall rating, based on a collection of reviews or ratings, of the item.
    public var aggregateRating: SchemaAggregateRating?
    /// An intended audience, i.e. a group for whom something was created.
    public var audience: SchemaAudience?
    /// An award won by or for this item.
    public var award: String?
    /// The brand(s) associated with a product or service, or the brand(s) maintained by an organization or business person.
    public var brand: SchemaBrandOrOrganization?
    /// A category for the item. Greater signs or slashes can be used to informally indicate a category hierarchy.
    public var category: SchemaTextOrThing?
    /// The color of the product.
    public var color: String?
    /// The depth of the item.
    public var depth: SchemaDistanceOrQuantitativeValue?
    /// The GTIN-12 code of the product, or the product to which the offer refers. The GTIN-12 is the 12-digit GS1 Identification Key composed of a U.P.C. Company Prefix, Item Reference, and Check Digit used to identify trade items.
    public var gtin12: String?
    /// The GTIN-13 code of the product, or the product to which the offer refers. This is equivalent to 13-digit ISBN codes and EAN UCC-13. Former 12-digit UPC codes can be converted into a GTIN-13 code by simply adding a preceeding zero.
    public var gtin13: String?
    /// The GTIN-14 code of the product, or the product to which the offer refers.
    public var gtin14: String?
    /// The GTIN-8 code of the product, or the product to which the offer refers. This code is also known as EAN/UCC-8 or 8-digit EAN.
    public var gtin8: String?
    /// The height of the item.
    public var height: SchemaDistanceOrQuantitativeValue?
    /// A pointer to another product (or multiple products) for which this product is an accessory or spare part.
    public var isAccessoryOrSparePartFor: SchemaProduct?
    /// A pointer to another product (or multiple products) for which this product is a consumable.
    public var isConsumableFor: SchemaProduct?
    /// A pointer to another, somehow related product (or multiple products).
    public var isRelatedTo: SchemaProductOrService?
    /// A pointer to another, functionally similar product (or multiple products).
    public var isSimilarTo: SchemaProductOrService?
    /// A predefined value from OfferItemCondition or a textual description of the condition of the product or service, or the products or services included in the offer.
    public var itemCondition: OfferItemCondition?
    /// An associated logo.
    public var logo: SchemaImageObjectOrURL?
    /// The manufacturer of the product.
    public var manufacturer: SchemaOrganization?
    /// A material that something is made from, e.g. leather, wool, cotton, paper.
    public var material: SchemaProductOrTextOrURL?
    /// The model of the product. Use with the URL of a ProductModel or a textual representation of the model identifier. The URL of the ProductModel can be from an external source. It is recommended to additionally provide strong product identifiers via the gtin8/gtin13/gtin14 and mpn properties.
    public var model: SchemaProductModelOrText?
    /// The Manufacturer Part Number (MPN) of the product, or the product to which the offer refers.
    public var mpn: String?
    /// An offer to provide this item—for example, an offer to sell a product, rent the DVD of a movie, perform a service, or give away tickets to an event.
    public var offers: [SchemaOffer]?
    /// The product identifier, such as ISBN. For example: meta itemprop="productID" content="isbn:123-456-789".
    public var productID: String?
    /// The date of production of the item, e.g. vehicle.
    public var productionDte: SchemaDate?
    /// The date the item e.g. vehicle was purchased by the current owner.
    public var purchaseDate: SchemaDate?
    /// The release date of a product or product model. This can be used to distinguish the exact variant of a product.
    public var releaseDate: SchemaDate?
    /// A review of the item.
    public var review: SchemaReview?
    /// The Stock Keeping Unit (SKU), i.e. a merchant-specific identifier for a product or service, or the product to which the offer refers.
    public var sku: String?
    /// The weight of the product or person.
    public var weight: SchemaQuantitativeValue?
    /// The width of the item.
    public var width: SchemaDistanceOrQuantitativeValue?
}
