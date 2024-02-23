//
//  ConcurrencyDemo.swift
//  ConcurrencyDemo
//
//  Created by Vinod Supnekar on 22/02/24.
//

import Foundation


class CustomOperation: Operation {
    
//    override func start() {
//        Thread.init(block: main).start()
//    }
    
    override func main() {
        for i in 0 ... 10 {
            print(i)
        }
    }
}


class CustomOperationOffMainThread: Operation {
    
    override func start() {
        Thread.init(block: main).start()
    }
    
    override func main() {
        for i in 0 ... 10 {
            print(i)
        }
    }
}






