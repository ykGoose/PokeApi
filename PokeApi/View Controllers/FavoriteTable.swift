import UIKit

class FavoriteTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controlView()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        return cell
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
        refreshControl?.endRefreshing()
    }
}
