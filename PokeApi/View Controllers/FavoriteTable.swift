import UIKit

class FavoriteTableViewController: UITableViewController {
    
    var favoritePokemon: [Pokemon]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlView()
        favoritePokemon = StorageManager.shared.fetchPokemon().sorted(by: {$0.entryNumber < $1.entryNumber})
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritePokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        let image: UIImageView? = .init(image: nil)
        image?.fetchImage(from: favoritePokemon[indexPath.row].pokemonSpecies.imageUrl)
        configuration.image = image?.image
        configuration.imageProperties.reservedLayoutSize.width = 60
        configuration.text = favoritePokemon[indexPath.row].pokemonSpecies.name.capitalized
        cell.contentConfiguration = configuration
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}


extension FavoriteTableViewController {
    func controlView() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .clear
        refreshControl?.attributedTitle = NSAttributedString(string: "print cat")
        refreshControl?.addTarget(self, action: #selector(printer), for: .valueChanged)
        tableView.addSubview(refreshControl ?? UIRefreshControl())
    }
    
    @objc func printer() {
        print("cat")
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
}
