import Foundation

/// An OfferCatalog is an ItemList that contains related Offers and/or further OfferCatalogs that are offeredBy the same provider.
public class SOOfferCatalog: SOItemList, OfferCatalog {
    override public class var type: String {
        return "OfferCatalog"
    }
}
