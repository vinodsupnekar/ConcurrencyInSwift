//
//  PropertyObserverDemo.swift
//  ConcurrencyDemo
//
//  Created by Vinod Supnekar on 23/02/24.
//

import Foundation

struct Person {
    var name: String
    var age: Int
}


class PersonViewModel {
    
    var person: Person? {
        
        willSet(newValue) {
            print("Called before setting the new value")
            
            if let newName = newValue?.name {
                print("New name is \(newName)")
            }
        }
        
        didSet {
            print("Called after setting the new value")
            
            if let name = person?.name {
                print("oldValue =, \(oldValue?.name) new name == \(name)")
            }
        }
            
    }
}

