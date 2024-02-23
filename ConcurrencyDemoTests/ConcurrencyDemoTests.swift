//
//  ConcurrencyDemoTests.swift
//  ConcurrencyDemoTests
//
//  Created by Vinod Supnekar on 22/02/24.
//

import XCTest
@testable import ConcurrencyDemo

final class ConcurrencyDemoTests: XCTestCase {

    func test_Operation_Uses_main_thread_by_default()  {
       
        print("custom operation started")
            let testOperation = CustomOperation()
            testOperation.start()
        print("custom operation excecuted")
    }
    
    /*
     custom operation started
     0
     1
     2
     3
     4
     5
     6
     7
     8
     9
     10
     custom operation excecuted
     */
    
    func test_Operation_Uses_taken_off_main_thread_using_start_method_override()  {
       
        print("custom operation started")
            let testOperation = CustomOperationOffMainThread()
            testOperation.start()
        print("custom operation excecuted")
    }
    
    /*
     o/p :-
     
     custom operation started
     custom operation excecuted
     0
     1
     2
     3
     4
     5
     6
     7
     8
     9
     10
     **/
    
    func test_Operation_Uses_taken_off_main_thread_using_dispatch_queue()  {
       
        print("custom operation started")
            let testOperation = CustomOperation()
        DispatchQueue.global().async {
            testOperation.start()
        }
        print("custom operation excecuted")
    }
    
    /*
     custom operation started
     custom operation excecuted
     0
     1
     2
     3
     4
     5
     6
     7
     8
     9
     10
     */
    
    func test_takeOperationOffMainThread_Using_OperationQueue() {
        
        runBlockOperation()
        print("custom operation started")
       
    }
    
    
    func test_More_Operations_Using_OperationQueue() {
        
        run_More_BlockOperation()
        print("custom operation started")
       
    }
    
    
    func runBlockOperation() {
        let operationQueue = OperationQueue()
        
        let blockOperation = BlockOperation()
        
        blockOperation.addExecutionBlock {
            print("blockOperation 1 task 1 executed")
        }
        
        blockOperation.addExecutionBlock {
            print("blockOperation 1 task 2 executed")
        }
        
        operationQueue.addOperation(blockOperation)
    }
    
    func run_More_BlockOperation() {
        let operationQueue = OperationQueue()
        
        let blockOperation = BlockOperation()
        
        blockOperation.addExecutionBlock {
            print("blockOperation 1 task 1 executed")
        }
        
        blockOperation.addExecutionBlock {
            print("blockOperation 1 task 2 executed")
        }
        
        
        let blockOperation2 = BlockOperation()
        
        blockOperation2.addExecutionBlock {
            print("blockOperation 2 task 1 executed")
        }
        
        blockOperation2.addExecutionBlock {
            print("blockOperation 2 task 2 executed")
        }
        
        operationQueue.addOperation(blockOperation)
        operationQueue.addOperation(blockOperation2)
    }

    
    
    func test_Operation_with_dependecy() {
        
        runBlockOperationWithDependecny()
        print("block operation started")
    }
    
    
    func runBlockOperationWithDependecny() {
        let operationQueue = OperationQueue()
        
        let blockOperation1 = BlockOperation()
        
        blockOperation1.addExecutionBlock {
            print("blockOperation 1 executed")
        }
        
        let blockOperation2 = BlockOperation()
        
        blockOperation2.addExecutionBlock {
            print("blockOperation 2 executed ")
        }
        
        blockOperation2.addDependency(blockOperation1)
        
        operationQueue.addOperation(blockOperation1)
        operationQueue.addOperation(blockOperation2)
   }
    
    /*
     block operation started
     blockOperation 1 executed
     blockOperation 2 executed
     
     */
    
    
    func test_async_task_with_Operation_using_dependecy() {
        
        async_task_with_Operation_using_dependecy()
        print("block operation started")
    }
    
    
    func async_task_with_Operation_using_dependecy() {
        let operationQueue = OperationQueue()
        
        let blockOperation1 = BlockOperation()
        
        blockOperation1.addExecutionBlock {
            
            DispatchQueue.global().async {
                for i in 0 ... 50 {
                    print(i)
                }
            }
           
        }
        
        let blockOperation2 = BlockOperation()
        
        blockOperation2.addExecutionBlock {
            DispatchQueue.global().async {
                for i in 51 ... 100 {
                    print(i)
                }
            }
        }
        
        blockOperation2.addDependency(blockOperation1)
        
        operationQueue.addOperation(blockOperation1)
        operationQueue.addOperation(blockOperation2)
   }
    
    /*o/p :-
     block operation started
     0
     1
     2
     3
     4
     5
     6
     7
     51
     52
     53
     54
     55
     56
     ..
     ..
     ..
     ..
     */
    
    /* To fix this we override Operation class and update uts state only when async task is finished inside main()
    method
     */
    
    func test_async_task_with_Operation_using_New_AsynOperationClass() {
        
        async_task_with_Operation_using_dependecy()
        print("AsyncOperation1 and AsyncOperation2 block operation started")
    }
    
    
    func async_task_with_Operation_using_dependecy_AsynOperationClass() {
        let operationQueue = OperationQueue()
        
        let blockOperation1 = AsyncOperation1()
        
       
        
        let blockOperation2 = AsyncOperation2()
        
       
        blockOperation2.addDependency(blockOperation1)
        
        operationQueue.addOperation(blockOperation1)
        operationQueue.addOperation(blockOperation2)
   }
    
    /*
     o/p:-
     
     AsyncOperation1 and AsyncOperation2 block operation started
     0
     1
     2
     3
     4
     5
     6
     7
     8
     9
     10
     11
     12
     13
     14
     15
     16
     17
     18
     19
     20
     21
     22
     23
     24
     25
     26
     27
     28
     29
     30
     31
     32
     33
     34
     35
     36
     37
     38
     39
     40
     41
     42
     43
     44
     45
     46
     47
     48
     49
     50
     51
     52
     53
     54
     55
     56
     57
     58
     59
     60
     61
     62
     63
     64
     65
     66
     67
     68
     69
     70
     71
     72
     73
     74
     75
     76
     77
     78
     79
     80
     81
     82
     83
     84
     85
     86
     87
     88
     89
     90
     91
     92
     93
     94
     95
     96
     97
     98
     99
     100
     */
    
}

