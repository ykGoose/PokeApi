import Foundation

class StorageManager {
    
    static let shared = StorageManager()
    private let userDefaults = UserDefaults.standard
    private let favoritePokemonKey = "favoritePokemon"
    
    private init() {}
    
    func save(pokemon: Pokemon) {
        var pokemons = fetchPokemon()
        pokemons.append(pokemon)
        guard let data = try? JSONEncoder().encode(pokemons) else { return }
        userDefaults.set(data, forKey: favoritePokemonKey)
    }
    
    func fetchPokemon() -> [Pokemon] {
        guard let data = userDefaults.object(forKey: favoritePokemonKey) as? Data else { return [] }
        guard let pokemons = try? JSONDecoder().decode([Pokemon].self, from: data) else { return [] }
        return pokemons
    }
    
    func delete(pokemon: Pokemon) {
        var pokemons = fetchPokemon()
        guard let index = pokemons.firstIndex(of: pokemon) else { return }
        pokemons.remove(at: index)
        guard let data = try? JSONEncoder().encode(pokemons) else { return }
        userDefaults.set(data, forKey: favoritePokemonKey)
    }
}
