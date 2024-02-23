//
//  KVO_Tests.swift
//  ConcurrencyDemoTests
//
//  Created by Vinod Supnekar on 23/02/24.
//

import XCTest
@testable import ConcurrencyDemo

final class KVO_Tests: XCTestCase {

   
    func testPerformanceExample() {
       
       let model = PersonViewModel()
        let pr1 = Person(name: "vnd", age: 35)

        model.person = pr1
        
        let pr2 = Person(name: "ashwn", age: 32)
        model.person = pr2
    }

}
