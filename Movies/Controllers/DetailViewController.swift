//
//  DetailViewController.swift
//  Movies
//
//  Created by Abdulrahman Sobbhy on 6/3/19.
//  Copyright © 2019 Abdulrahman Sobbhy. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var movieNameLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // we use text view to allow scrolling for big content
    @IBOutlet weak var genreTextView: UITextView!
    
    @IBOutlet weak var actorsTextView: UITextView!
    
    var imagesUrl = [URL]()
    func configureView() {
        // Update the user interface for the detail item.
        if let movie = currentMovie {
            DispatchQueue.main.async {
                // all view updates must be done within the main thread!
                self.movieNameLabel.text = movie.title
                self.yearLabel.text = String(movie.year)
                self.genreTextView.text = movie.genres.map({ (genre) -> String in
                    return genre.rawValue
                }).joined(separator: ",")
                self.actorsTextView.text = movie.cast.joined(separator: ",")
            }
            // call our helper function to get the images urls
            FlickerURL.getImagesUrl(for: currentMovie!.title) { (urls) in
                self.imagesUrl = urls
                self.collectionView.reloadData()
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var currentMovie: Movie? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}


extension DetailViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviePhoto1", for: indexPath)
        // we suggest to use the default view embedded in the cell
        // as there's no need to create a newly designed cell because we just need a single image to be presented!
        cell.backgroundView = UIImageView()
        // here we set the image url to be downloaded on the background
        (cell.backgroundView as! UIImageView).kf.setImage(with: imagesUrl[indexPath.row])
        return cell
    }
    
    
}
