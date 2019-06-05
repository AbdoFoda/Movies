//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Abdulrahman Sobbhy on 6/3/19.
//  Copyright © 2019 Abdulrahman Sobbhy. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {
    var repo : Repository!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Repository.getInstance(completion: { (repo) in
            self.repo = repo
        })
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMoviesExistance() {
        XCTAssertNotNil(self.repo.getAllMovies(location: .test),"Movies Don't Exist")
    }
    
    func testMoviesCount() {
        if let movies = self.repo.getAllMovies(location: .develop) {
            XCTAssertEqual(movies.count,2272,"Movies Count is not correct")
        }
    }

    func testMovieLoadingPerformance() {
        self.measure {
            // measure the time of loading all movies from json file
            _ = self.repo.getAllMovies(location: .test)
        }
    }
    
    func testMoviesSearch() {
        
        // just check weather the year is matching with the search result
        // first we check we are loading the movies
        _ = self.repo.getAllMovies(location: .test)
        // then check if it's match or not
        let year = 2009
            if let selectedMovies = self.repo.search(by: year) {
                for movie in selectedMovies {
                  XCTAssertEqual(movie.year , year, "movie year not matching")
                }
            }
        
        
    }
    
    func testTop5() {
        
        // here we are going to test if really the search result returning the top-5 rated data
        // as we design the test case by hand so ,we know what is the title of each one.
         _ = self.repo.getAllMovies(location: .test)
        
        let sortedMovies = self.repo.search(by: 2009)
        XCTAssert(sortedMovies![0].title == "17 Again")
        XCTAssert(sortedMovies![1].title == "12 Rounds")
        XCTAssert(sortedMovies![2].title == "(500) Days of Summer")
        XCTAssert(sortedMovies![3].title == "2012")
        XCTAssert(sortedMovies![4].title == "9")
    }
    
    
    
    

}
