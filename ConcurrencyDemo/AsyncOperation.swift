//
//  AsyncOperation.swift
//  ConcurrencyDemo
//
//  Created by Vinod Supnekar on 23/02/24.
//

import Foundation

class AsyncOperation: Operation {
    
    enum State: String {
        case isReady
        case isFinished
        case isExecuting
    }
    
    var state: State = .isReady
    {
        
        willSet(newValue) {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        
        didSet{
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override var isAsynchronous: Bool { true }
    
    override var isExecuting: Bool { state == .isExecuting}
    
    override var isFinished: Bool {
        
        if isCancelled && state != .isExecuting {
            return true
        }
        return state == .isFinished
    }
    
    override func start() {
        guard !isCancelled else {
            state = .isFinished
            return
        }
        state = .isExecuting
        main()
    }
    
    override func cancel() {
        state = .isFinished
    }
}


class AsyncOperation1: AsyncOperation {
    
    override func main() {
        DispatchQueue.global().async {
            for i in 0 ... 100 {
                print(i)
            }
            self.state = .isFinished
        }
    }
}


class AsyncOperation2: AsyncOperation {
    
    override func main() {
        DispatchQueue.global().async {
            for i in 101 ... 200 {
                print(i)
            }
            self.state = .isFinished
        }
    }
}

