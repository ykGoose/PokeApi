import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    private init() {}
    
    func fetchPokedex(complition: @escaping (Pokemon) -> Void) {
        guard let url = URL(string: URLsEnumeration.nationalApi.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let pokemons = try JSONDecoder().decode(Pokemon.self, from: data)
                DispatchQueue.main.async {
                    complition(pokemons)
                }
                    
            } catch let error {
                print(error)
                return
            }
        }.resume()
    }
}
