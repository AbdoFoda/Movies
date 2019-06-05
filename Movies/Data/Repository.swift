//
//  Repository.swift
//  Movies
//
//  Created by Abdulrahman Sobbhy on 6/5/19.
//  Copyright © 2019 Abdulrahman Sobbhy. All rights reserved.
//

import Foundation
enum MovieDataLocation :String {
    case develop = "movies.json"
    case test = "testMovies.json"
}
class Repository {
    // MARK:- Variables
    private static var singleInstance : Repository?
    private var allMovies : MovieList?
    
    // MARK:- Functions
    static func getInstance(completion : @escaping (Repository)->Void )  {
        // we use Singletone to avoid multiple data loading
        if singleInstance == nil {
            // we need our code to be syncronized to avoid multi initialization of the singletone variable
            DispatchQueue.global().sync {
                singleInstance = Repository()
                // we are obligated to use a clasure here because we are running on a different threads!
                completion(singleInstance!)
            }
        }else{
            completion(singleInstance!)
        }
    }
    
    func getAllMovies(location : MovieDataLocation) -> [Movie]? {
        let path = Bundle.main.path(forResource: location.rawValue, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try NSData(contentsOf: url, options: NSData.ReadingOptions())
            allMovies = try JSONDecoder().decode(MovieList.self, from: jsonData as Data)
            // here we sort the list of movies,before returning it
            self.sortMovies()
            return allMovies!.movies
        } catch {
            print("couldn't load the file")
            return nil
        }
    }
    
    private func sortMovies() {
        // we can't sort nil ...
        guard allMovies != nil else{
            return
        }
        /* the purpose of sorting this list is for search optimization(aka: pre-processing)
           we will sort the movies according to the year
           every year should have an interval [l,r]
           as we need the top(5) rated per year, we wil sort the movies according to their rating when tie happens
        */
      
        allMovies!.movies.sort { (movie1, movie2) -> Bool in
            if movie1.year == movie2.year {
                return movie1.rating > movie2.rating
            }else{
                return movie1.year < movie2.year
            }
        }
    }
    
    func search(by year : Int) -> [Movie]? {
        // we also can't search nil
        guard allMovies != nil else{
            return nil
        }
        /*
            we are going to search the sorted list of movies by year, So
            we can just get the first matching one, then we can get at most 5-top rated
         */
        let moviesCount = allMovies!.movies.count
        var l = 0 , r = moviesCount - 1 , ans = -1
        while l<=r {
            let mid = (l + r) / 2
            if allMovies!.movies[mid].year >= year {
                r = mid - 1
                if allMovies!.movies[mid].year == year {
                    ans = mid
                }
            }else {
                l = mid + 1
            }
        }
        if ans != -1 {
            var ret = [Movie]()
            for i in ans..<ans+5 {
                if i < moviesCount && allMovies!.movies[i].year == year {
                    ret.append(allMovies!.movies[i])
                }
            }
            return ret
        }else{
            return nil
        }
    }
    
    
}
