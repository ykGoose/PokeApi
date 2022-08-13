import UIKit

class PokemonCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    private var searchedPokemons: [Pokemon] = []
    private var currentPokemonList: [Pokemon] = []
    private var pokedexList: [Pokedex] = []
    private var currentPokedex: Pokedex! = Pokedex(name: "National", url: "https://pokeapi.co/api/v2/pokedex/1/")
    private var favoriteListIsOpen = false
    private var searchBarIsEmpty: Bool {
        guard let text = navigationItem.searchController?.searchBar.text else { return false }
        return text.isEmpty
    }
    private let refreshControl = UIRefreshControl()
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        controlView()
        searchController()
        fetchingPokedex()
        //     currentPokedex = pokedexList.first
        fetchingPokemon(url: currentPokedex.url)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info" {
            segue.destination.presentationController?.delegate = self
            let navigationVC = segue.destination as! UINavigationController
            let infoVC = navigationVC.topViewController as! InfoViewController
            guard let indexPath = collectionView.indexPathsForSelectedItems else {return}
            infoVC.pokemon = searchBarIsEmpty ? currentPokemonList[indexPath[0].item] : searchedPokemons[indexPath[0].item]
        }
    }
    
    // MARK: - IB Actions
    @IBAction func regionChanging(_ sender: UIBarButtonItem) {
        // showAlert()
        showTable(pokedexList: pokedexList)
    }
    
    
    // MARK: - CollectionView Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchBarIsEmpty ? currentPokemonList.count : searchedPokemons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonCollectionViewCell
        let pokemon = searchBarIsEmpty ? currentPokemonList [indexPath.item] : searchedPokemons[indexPath.item]
        cell.configure(with: pokemon)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonCollectionViewCell
        cell.pokemonImageView = nil
    }
}

// MARK: - Extensions


// MARK: Fetch Request

extension PokemonCollectionViewController {
    
    func fetchingPokedex() {
        NetworkManager.shared.fetchPokedexes(url: URLsEnumeration.pokedexListApi1.rawValue) { pokedex in
            self.pokedexList += pokedex
        }
        NetworkManager.shared.fetchPokedexes(url: URLsEnumeration.pokedexListApi2.rawValue) { [self] pokedex in
            self.pokedexList += pokedex
            print(self.pokedexList.count)
        }
    }
    
    func fetchingPokemon(url: String) {
        NetworkManager.shared.fetchPokemons(url: url) { pokemon in
            self.currentPokemonList = pokemon.pokemonEntries
            self.navigationItem.title = self.currentPokedex.name.capitalized.replacingOccurrences(of: "-", with: " ")
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Delegate Flow Layout
extension PokemonCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 4
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
                self.currentPokedex = pokedex
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
        searchedPokemons = currentPokemonList.filter({ species in
            species.pokemonSpecies.name.lowercased().contains(searchText.lowercased())
        })
        collectionView.reloadData()
    }
}

// MARK: - ControlView
extension PokemonCollectionViewController {
    func controlView() {
        refreshControl.tintColor = .clear
        refreshControl.attributedTitle = NSAttributedString(string: "return to National")
        refreshControl.addTarget(self, action: #selector(national), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
    @objc func national() {
        currentPokedex = pokedexList.first
        fetchingPokemon(url: currentPokedex.url)
        self.refreshControl.endRefreshing()
        collectionView.reloadData()
    }
}

extension PokemonCollectionViewController {
    func defineCurrentPokemonList(){
        if favoriteListIsOpen {
            currentPokemonList = StorageManager.shared.fetchPokemon()
        } else {
            fetchingPokemon(url: currentPokedex.url)
        }
    }
}


extension PokemonCollectionViewController: UIAdaptivePresentationControllerDelegate {
    
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
                self.collectionView.reloadData()
            print("cat")
        }
}
