
struct Pokemon: Decodable {    
    let pokemonEntries: [Species]
    let name: String
}

struct Species: Decodable {
    let entryNumber: Int
    let pokemonSpecies: Name
}

struct Name: Decodable {
    let name: String
    let url: String     //image
}

enum URLsEnumeration: String {
    case image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/" // no.svg
    case nationalApi = "https://pokeapi.co/api/v2/pokedex/1/"
    case pokedexListApi1 = "https://pokeapi.co/api/v2/pokedex/"
    case pokedexListApi2 = "https://pokeapi.co/api/v2/pokedex/?offset=20&limit=8"
}

