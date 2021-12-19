import UIKit

class InfoViewController: UIViewController {
    
    
    @IBOutlet var pokemonImageView: UIImageView!
    var pokemon: Species!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = pokemon.pokemonSpecies.name.capitalized
        
     //   fetchImage
        NetworkManager.shared.fetchImage(from: pokemon) { image in
            self.pokemonImageView.image = image
        }
    }
        
    //    navigationItem.title = "car"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



