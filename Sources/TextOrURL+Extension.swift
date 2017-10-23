import Foundation
import SOSwiftVocabulary

// MARK: - TextOrURL

public extension KeyedEncodingContainer {
    public mutating func encodeIfPresent(_ value: TextOrURL?, forKey key: K) throws {
        if let typedValue = value as? URL {
            try self.encode(typedValue, forKey: key)
        } else if let typedValue = value as? String {
            try self.encode(typedValue, forKey: key)
        }
    }
}

public extension KeyedDecodingContainer {
    public func decodeTextOrURLIfPresent(forKey key: K) throws -> TextOrURL? {
        guard self.contains(key) else {
            return nil
        }
        
        do {
            let value = try self.decode(URL.self, forKey: key)
            if value.isValid {
                return value
            }
        } catch {
        }
        
        do {
            let value = try self.decode(String.self, forKey: key)
            return value
        } catch {
        }
        
        print("Failed to decode `TextOrURL` for key: \(key.stringValue).")
        
        return nil
    }
}
