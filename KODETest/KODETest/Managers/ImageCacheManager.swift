import UIKit

final class ImageCacheManager {
    static let shared = ImageCacheManager()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    func getImage(for url: URL) -> UIImage? {
        return imageCache.object(forKey: url.absoluteString as NSString)
    }
    
    func saveImage(_ image: UIImage, withURL url: URL) {
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
    }
}
