import UIKit

protocol RegionTableViewControllerDelegate {
    func regionTableViewControllerDidSelect(item: Int)
}

class RegionTableViewController: UITableViewController {
    
    var pokedexList: [Pokedex] = []
    
    override func viewDidLoad() {
//        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "pokedexCell")
    }
    
    deinit {
        print("dog")
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokedexList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = pokedexList[indexPath.row].name.replacingOccurrences(of: "-", with: " ").capitalized
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath[1])
        
        dismiss(animated: true)
    }
    
    
}

extension PokemonCollectionViewController {
    func showTable(pokedexList: [Pokedex]) {
        let tableVC = RegionTableViewController()
        tableVC.pokedexList = pokedexList
        if let sheet = tableVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
        }
        present(tableVC, animated: true)
    }

}


