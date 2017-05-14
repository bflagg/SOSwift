import Foundation

/// A datasheet or vendor specification of a product (in the sense of a prototypical description).
public class SOProductModel: SOProduct, ProductModel {
    override public class var type: String {
        return "ProductModel"
    }
    
    /// A pointer to a base product from which this product is a variant. It is safe to infer that the variant inherits all product features from the base model, unless defined locally. This is not transitive.
    public var isVariantOf: ProductModel?
    /// A pointer from a previous, often discontinued variant of the product to its newer variant.
    public var predecessorOf: ProductModel?
    /// A pointer from a newer variant of a product to its previous, often discontinued predecessor.
    public var successorOf: ProductModel?
}
