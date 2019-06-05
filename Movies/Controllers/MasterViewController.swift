//
//  MasterViewController.swift
//  Movies
//
//  Created by Abdulrahman Sobbhy on 6/3/19.
//  Copyright © 2019 Abdulrahman Sobbhy. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var showMovies : [Movie]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Repository.getInstance(completion: { (repo) in
            self.showMovies = repo.getAllMovies()
        })
    
    }

   

    
    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
        }
    }
    
    

   
}



extension MasterViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell")!
        cell.textLabel?.text = "Movie Name"
        cell.detailTextLabel?.text = "Movie Year"
        return cell
        
    }
    
    
}
