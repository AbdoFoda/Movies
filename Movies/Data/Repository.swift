//
//  Repository.swift
//  Movies
//
//  Created by Abdulrahman Sobbhy on 6/5/19.
//  Copyright © 2019 Abdulrahman Sobbhy. All rights reserved.
//

import Foundation

class Repository {
    private var singleInstance : Repository?

    func getInstance(completion : @escaping (Repository)->Void )  {
        if singleInstance == nil {
            DispatchQueue.global().sync {
                self.singleInstance = Repository()
                completion(self.singleInstance!)
            }
        }else{
            completion(singleInstance!)
        }
    }
    
    
    
}
