import UIKit

class PokemonCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    private var pokemonList: Pokemon?
    private var searchedPokemons: [Species] = []
    private var pokedexList: [Pokedex] = []
    private var searchBarIsEmpty: Bool {
        guard let text = navigationItem.searchController?.searchBar.text else { return false }
        return text.isEmpty
    }
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController()
        fetchingPokedex()
        fetchingPokemon(url: URLsEnumeration.nationalApi.rawValue)
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let navigationVC = segue.destination as! UINavigationController
         let infoVC = navigationVC.topViewController as! InfoViewController
         guard let indexPath = collectionView.indexPathsForSelectedItems else {return}
         infoVC.pokemon = searchBarIsEmpty ? pokemonList?.pokemonEntries[indexPath[0].item] : searchedPokemons[indexPath[0].item]
     }

    // MARK: - IB Actions
    @IBAction func regionChanging(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchBarIsEmpty ? pokemonList?.pokemonEntries.count ?? 1 : searchedPokemons.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonCollectionViewCell
        let pokemon = searchBarIsEmpty ? pokemonList?.pokemonEntries[indexPath.item] : searchedPokemons[indexPath.item]
        cell.configure(with: pokemon)
        return cell
    }
}

// MARK: - Extensions
extension PokemonCollectionViewController {
    func fetchingPokedex() {
        NetworkManager.shared.fetchPokedexes(url: URLsEnumeration.pokedexListApi1.rawValue) { pokedex in
            self.pokedexList += pokedex
        }
        NetworkManager.shared.fetchPokedexes(url: URLsEnumeration.pokedexListApi2.rawValue) { pokedex in
            self.pokedexList += pokedex
            print(self.pokedexList.count)
        }
    }
    func fetchingPokemon(url: String) {
        NetworkManager.shared.fetchPokemons(url: url) { pokemon in
            self.pokemonList = pokemon
            self.navigationItem.title = self.pokemonList?.name.capitalized.replacingOccurrences(of: "-", with: " ")
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Delegate Flow Layout
extension PokemonCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 3
        return CGSize(width: size, height: size + 30)
    }
}

// MARK: AlertController
extension PokemonCollectionViewController {
    private func showAlert() {
        let alert = UIAlertController(title: "Choose region", message: "", preferredStyle: .actionSheet)
        addActions(alerts: alert)
        present(alert, animated: true)
    }
    
    private func addActions(alerts: UIAlertController) {
        for pokedex in pokedexList {
            let alertAction = UIAlertAction(title: pokedex.name.replacingOccurrences(of: "-", with: " ").capitalized, style: .default) { _ in
                self.fetchingPokemon(url: pokedex.url)
                self.collectionView.reloadData()
            }
            alerts.addAction(alertAction)
        }
    }
}

// MARK: SearchController
extension PokemonCollectionViewController: UISearchBarDelegate {
    
    private func searchController () {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
}

extension PokemonCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
        print(searchedPokemons)
    }
    
    private func filterContentForSearchText(searchText: String) {
        searchedPokemons = pokemonList?.pokemonEntries.filter({ species in
            species.pokemonSpecies.name.lowercased().contains(searchText.lowercased())
        }) ?? []
        collectionView.reloadData()
    }
}

//extension PokemonCollectionViewController {
//    func titleColorConfiguration(color: UIColor) {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = color
//        navigationItem.standardAppearance = appearance
//        navigationItem.scrollEdgeAppearance = appearance
//    }
//}
