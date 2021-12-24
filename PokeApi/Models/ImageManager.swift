import UIKit
import SVGKit

extension UIImageView {

    func fetchImage(from url: URL?) {
        guard let url = url else { return }
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            return
        }
        
        ImageManager.shared.fetchImage(from: url) { data, response in
            guard let imageData = SVGKImage(data: data) else {
                var pokeNumber = url.absoluteString.replacingOccurrences(of: URLsEnumeration.image.rawValue, with: "")
                pokeNumber = "NO IMAGE - " + pokeNumber.replacingOccurrences(of: ".svg", with: "")
                print(pokeNumber)
                return
            }
            DispatchQueue.main.async {
                self.image = imageData.uiImage
            }
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            guard let imageData = SVGKImage(data: cachedResponse.data) else { return nil}
            return imageData.uiImage
        }
        return nil
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }

        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    
}


class ImageManager {
    static var shared = ImageManager()
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            completion(data,response)
        }.resume()
    }
}
}
