import Alamofire
import SVGKit
import Foundation

class NetworkManager {
    
    // MARK: Properties
    static var shared = NetworkManager()
    private init() {}
    
    // MARK: Alamofire
    func fetchPokedexes(url: String, completion: @escaping ([Pokedex]) -> Void) {
        guard let url = URL(string: url) else { return }
        
        AF.request(url).validate().responseDecodable { (dataResponse: DataResponse<PokedexResult, AFError>) in
            switch dataResponse.result {
            case .success(let value):
                completion(value.results)
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
    func fetchPokemons(url: String, comletion: @escaping (PokedexWithPokemons) -> Void) {
        guard let url = URL(string: url) else { return }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        AF.request(url).validate().responseDecodable(decoder: decoder) { (dataResponse: DataResponse<PokedexWithPokemons, AFError>) in
            switch dataResponse.result {
            case .success(let data):
                comletion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}

