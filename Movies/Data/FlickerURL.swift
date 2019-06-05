//
//  FlickerURL.swift
//  Movies
//
//  Created by Abdulrahman Sobbhy on 6/5/19.
//  Copyright © 2019 Abdulrahman Sobbhy. All rights reserved.
//

import Foundation
import Alamofire

class FlickerURL {
    private static var api_key =  "4a866a193e1f87523642de1d2ebfb1f0"
    
    static func makeFlickerUrl(for movieName:String) -> URL {
        // here we encode the string from spaces
        let encodedMovieName = movieName.replacingOccurrences(of: " ", with: "%20")
        return URL(string:"https://www.flickr.com/services/rest/?method=flickr.photos.search&name=value&api_key=4a866a193e1f87523642de1d2ebfb1f0&format=json&nojsoncallback=%E2%80%8B1%E2%80%8B&text=\(encodedMovieName)&page=1&per_page=10")!
    }
    
    static func makeImageUrl(photo : Photo) -> URL{
        // getting the url of the image from the photo object as stated in the documentation
        return URL(string: "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg")!
    }
    
    static func getImagesUrl(for movieName :String , completion: @escaping ([URL])->Void ){
        // first we use the movie name to search the photos,after that
        // we generate the url of each photo
        var result = [URL]()
        let searchURL = makeFlickerUrl(for: movieName)
        Alamofire.request(searchURL,
                          method: .get)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching data: \(String(describing: response.result.error))")
                    return
                }
                let moviePhotos = try? JSONDecoder().decode(MoviePhotos.self, from: response.data!)
                moviePhotos?.photos.photo.forEach({ (photo) in
                    DispatchQueue.global().sync{
                        result.append(makeImageUrl(photo: photo))
                        // here we send the urls when we are totaly completed
                        if result.count == moviePhotos?.photos.photo.count {
                            completion(result)
                        }
                    }
                })
            }
    }
}
