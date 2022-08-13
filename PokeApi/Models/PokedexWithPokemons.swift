import Foundation

struct PokedexWithPokemons: Codable, Equatable {
    let pokemonEntries: [Pokemon]
    let name: String
}

struct Pokemon: Codable, Equatable {
    let entryNumber: Int
    let pokemonSpecies: NameAndURL
}

struct NameAndURL: Codable, Equatable {
    let name: String
    let url: String     //image
    var imageUrl: URL? {
        var pokeNumber = url.replacingOccurrences(of: "https://pokeapi.co/api/v2/pokemon-species/", with: "")
        pokeNumber.removeLast()
        let imageUrl = URL(string: "\(URLsEnumeration.image.rawValue)\(pokeNumber).svg")
        return imageUrl
    }
}

enum URLsEnumeration: String {
    case image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/" // no.svg
    case nationalApi = "https://pokeapi.co/api/v2/pokedex/1/"
    case pokedexListApi1 = "https://pokeapi.co/api/v2/pokedex/"
    case pokedexListApi2 = "https://pokeapi.co/api/v2/pokedex/?offset=20&limit=8"
}

