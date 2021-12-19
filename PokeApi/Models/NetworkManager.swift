import Foundation
import Alamofire
import SVGKit

class NetworkManager {
    
    // MARK: Properties
    static var shared = NetworkManager()
    private init() {}
    
    // MARK: Alamofire
    func fetchPokedexes(url: String, complition: @escaping ([Pokedex]) -> Void) {
        guard let url = URL(string: url) else { return }
        AF.request(url).validate().responseDecodable { (dataResponse: DataResponse<PokedexResult, AFError>) in
            
            switch dataResponse.result {
            case .success(let value):
                complition(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPokemons(url: String, comlition: @escaping (Pokemon) -> Void) {
        guard let url = URL(string: url) else { return }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(url).validate().responseDecodable(decoder: decoder) { (dataResponse: DataResponse<Pokemon, AFError>) in
            
            switch dataResponse.result {
            case .success(let data):
                comlition(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchImage (from pokemon: Species?, complition: @escaping (UIImage) -> Void) {
        guard var pokeNumber = pokemon?.pokemonSpecies.url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "") else { return }
        pokeNumber.removeLast()
        print("\(pokemon?.pokemonSpecies.name ?? "noname") - \(pokemon?.entryNumber ?? 000)")
        let imageUrl = "\(URLsEnumeration.image.rawValue)\(pokeNumber).svg"
        
        AF.request(imageUrl).response { response in
            switch response.result {
            case .success(let data):
                guard let image = SVGKImage(data: data) else { return }
                complition(image.uiImage)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
//    fetch
    
    // MARK: Fetch Data
    
    //    func fetchPokedex(url: String, complition: @escaping ([Pokedex]) -> Void) {
    //        var pokeList: [Pokedex] = []
    //        guard let url = URL(string: url) else { return }
    //        URLSession.shared.dataTask(with: url) { data, _, error in
    //            if let error = error {
    //                print(error)
    //                return
    //            }
    //            guard let data = data else { return }
    //
    //            do {
    //                    let pokedexResult = try JSONDecoder.decode(PokedexResult.self, from: data)
    //                DispatchQueue.main.async {
    //                    pokeList = pokedexResult.results
    //                    complition(pokeList)
    //                }
    //            } catch let error {
    //                print(error)
    //                return
    //            }
    //
    //        }.resume()
    //    }
    //
    //
    //            func fetchPokemon(url: String, complition: @escaping (Pokemon) -> Void) {
    //                guard let url = URL(string: url) else { return }
    //
    //                URLSession.shared.dataTask(with: url) { data, _, error in
    //                    if let error = error {
    //                        print(error)
    //                        return
    //                    }
    //                    guard let data = data else { return }
    //
    //                    do {
    //                        let decoder = JSONDecoder()
    //                        decoder.keyDecodingStrategy = .convertFromSnakeCase
    //                        let pokemons = try decoder.decode(Pokemon.self, from: data)
    //                        DispatchQueue.main.async {
    //                            complition(pokemons)
    //                        }
    //
    //                    } catch let error {
    //                        print(error)
    //                        return
    //                    }
    //                }.resume()
    //            }
    
    
}