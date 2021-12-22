
struct PokedexResult: Decodable {
    let count: Int
    let results: [Pokedex]
}

struct Pokedex: Decodable {    
    let name: String
    let url: String
}
