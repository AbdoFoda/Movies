//
//  Repository.swift
//  Movies
//
//  Created by Abdulrahman Sobbhy on 6/5/19.
//  Copyright © 2019 Abdulrahman Sobbhy. All rights reserved.
//

import Foundation

class Repository {
    private static var singleInstance : Repository?

    static func getInstance(completion : @escaping (Repository)->Void )  {
        if singleInstance == nil {
            DispatchQueue.global().sync {
                singleInstance = Repository()
                completion(singleInstance!)
            }
        }else{
            completion(singleInstance!)
        }
    }
    
    func getAllMovies() -> [Movie]? {
        let path = Bundle.main.path(forResource: "movies.json", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try NSData(contentsOf: url, options: NSData.ReadingOptions())
            let movieList = try JSONDecoder().decode(MovieList.self, from: jsonData as Data)
            return movieList.movies
        } catch {
            print("couldn't load the file")
            return nil
        }
    }
    
    
    
    
}
