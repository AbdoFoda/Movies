//
//  MasterViewController.swift
//  Movies
//
//  Created by Abdulrahman Sobbhy on 6/3/19.
//  Copyright © 2019 Abdulrahman Sobbhy. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    // MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func showSearchResult(_ sender: UITextField) {
        Repository.getInstance(completion: { (repo) in
            var noResult = true
            let allMovies = repo.getAllMovies(location: .develop)
            // here we are using clasure, So it may be delayed...just refresh the table view
            if let year = Int(sender.text!) {
                if let searchResult = repo.search(by: year) , searchResult.count > 0 {
                    noResult = false
                    self.showMovies = searchResult
                }
            }
            if noResult && sender.text!.count > 0 {
                let alertController = UIAlertController(title: "No Movies are matched", message: "please search with a valid movie year", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default)
                alertController.addAction(okAction)
                self.present(alertController,animated: true)
            }
            if noResult{
                self.showMovies = allMovies
            }
            self.tableView.reloadData()
        })
    }
    
    // MARK:- Variables
    
    private var showMovies : [Movie]!
    
    
    // MARK:- Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Repository.getInstance(completion: { (repo) in
            self.showMovies = repo.getAllMovies(location: .develop)
            // here we are using clasure, So it may be delayed...just refresh the table view
            self.tableView.reloadData()
        })
    
    }

   

    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let details = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            details.currentMovie = showMovies[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    

   
}



extension MasterViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")!
        cell.textLabel?.text = self.showMovies[indexPath.row].title
        cell.detailTextLabel?.text = "Rating : \(showMovies[indexPath.row].rating) out of 5 , Year :\(self.showMovies[indexPath.row].year)"
        return cell
        
    }
    
    
}


extension MasterViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
