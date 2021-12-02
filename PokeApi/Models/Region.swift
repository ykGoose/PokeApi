
struct PokedexResult: Decodable {
    
    let count: Int
    let results: [Pokedex]
    let next: String
}

struct Pokedex: Decodable {
    
    let name: String
    let url: String
}
