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
        XCTAssertNotNil(self.repo.getAllMovies(),"Movies Don't Exist")
    }
    
    func testMoviesCount() {
        if let movies = self.repo.getAllMovies() {
            XCTAssertEqual(movies.count,2272,"Movies Count is not correct")
        }
    }

    func testMovieLoadingPerformance() {
        self.measure {
            // measure the time of loading all movies from json file
            _ = self.repo.getAllMovies()
        }
    }
    
    
    

}
