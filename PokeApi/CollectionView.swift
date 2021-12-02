

import UIKit

class PokemonCollectionViewController: UICollectionViewController {
    
    private var pokemonList: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.fetchPokedex { pokemon in
            self.pokemonList = pokemon
            self.navigationItem.title = self.pokemonList?.name?.capitalized
            self.collectionView.reloadData()
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - IB Actions
    
    @IBAction func regionChanging(_ sender: UIBarButtonItem) {
        showAlert()
        
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pokemonList?.pokemon_entries?.count ?? 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as! PokemonCollectionViewCell
        let pokemon = pokemonList?.pokemon_entries?[indexPath.row]
        cell.configure(with: pokemon)
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate



    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
// MARK: - Extension Delegate
extension PokemonCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = UIScreen.main.bounds.width / 3
        return CGSize(width: size, height: size)
    }
}

// MARK: - Extension
extension PokemonCollectionViewController {
    private func showAlert() {
    let alert = UIAlertController(title: "Choose region", message: "", preferredStyle: .actionSheet)
        addActions(alerts: alert)
        
        present(alert, animated: true)
    }
    
    private func addActions(alerts: UIAlertController) {
        let actiona = ["cat", "dog", "mouse"]
        for action in actiona {
            let alertAction = UIAlertAction(title: action, style: .default)
            alerts.addAction(alertAction)
        }
    }
}
