
struct Pokemon: Decodable {
    
    let pokemon_entries: [Species]
    let name: String
    
}

struct Species: Decodable {
    
    let entry_number: Int
    let pokemon_species: Name
    
}

struct Name: Decodable {
    let name: String
    let url: String
    
}



enum URLsEnumeration: String {
    case image = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/" // no.svg
    case nationalApi = "https://pokeapi.co/api/v2/pokedex/1/"
    case pokedexListApi1 = "https://pokeapi.co/api/v2/pokedex/"
    case pokedexListApi2 = "https://pokeapi.co/api/v2/pokedex/?offset=20&limit=8"
}

