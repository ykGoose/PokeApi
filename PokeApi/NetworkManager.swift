import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    private init() {}
    
    func fetchPokedex(url: String, complition: @escaping ([Pokedex]) -> Void) {
        var pokeList: [Pokedex] = []
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else { return }
            
            do {
                let pokedexResult = try JSONDecoder().decode(PokedexResult.self, from: data)
                DispatchQueue.main.async {
                    pokeList = pokedexResult.results
                    complition(pokeList)
                }
            } catch let error {
                print(error)
                return
            }
            
        }.resume()
    }
    
    func fetchPokemon(url: String, complition: @escaping (Pokemon) -> Void) {
        guard let url = URL(string: url) else { return }
        
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

