import CommonCrypto
import Foundation

class MD5 {
    private init() { }

    static func hash(from value: String) -> String? {
        guard let data = value.data(using: String.Encoding.utf8) else {
            return nil
        }

        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))

        _ = data.withUnsafeBytes { CC_MD5($0.baseAddress, UInt32(data.count), &digest) }

        return digest.reduce("") { (result, byte) in
            result + String(format: "%02x", UInt8(byte))
        }
    }
}
