//
//  DataRaceTests.swift
//  ConcurrencyDemoTests
//
//  Created by Vinod Supnekar on 23/02/24.
//

import XCTest
@testable import ConcurrencyDemo

class DataRaceTests: XCTestCase {
    
    func test_dataRace() {
        
        let flight = Flight()
        
        // lets say 2 async task tries to access the flight object asynchronoulsy, so data race will occur
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")
        
        queue1.async {
            let bookedSeat = flight.bookSeat()
            print(" booked seat is \(bookedSeat)")
        }
        
        queue2.async {
            let availableSeat = flight.getAvailbaleSeats()
            print(" availableSeat seats are \(availableSeat)")
        }
    }
    
    /* o/p:-
     
     booked seat is 1A
     availableSeat seats are ["1A", "2B", "3C"]
     
     which shows data inconsistency.
     */
    
    
    func test_dataRace_fixed_using_barriers() {
        
        let flight = FlightWithThreadSafety()
        
        // lets say 2 async task tries to access the flight object asynchronoulsy, so data race will occur
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")
        
        queue1.async {
            flight.bookSeat { bookedSeat in
                print(" booked seat is \(bookedSeat)")
            }
          
        }
        
        queue2.async {
            let availableSeat = flight.getAvailbaleSeats()
            print(" availableSeat seats are \(availableSeat)")
        }
    }
    
    /* o/p :-
     
     booked seat is 1A
     availableSeat seats are ["2B", "3C"]
     
     **/
    
    /* Actors :-  we manually fixed Data inconsistency in Flight Model , so manual intervention may cause issues, if miss in implementation, so Actor are introduced.
     
     
     Term "Actor" :-
     Who is actor :- play role of some one else.
     SO in Concurrency tasks, actor will play role of our Models and safeguard any Data race issues.
     
     Actor :- is a class.
        But actors cannot has Inheritance.
     
     
     
     */
    
    func test_actor_fixing_flight_data_inconsistency() {
        
        let flight = FlightAsActor()
        
        let queue1 = DispatchQueue(label: "queue1")
        let queue2 = DispatchQueue(label: "queue2")
        
        queue1.async {
            
            Task {
                let bookedSeat = await flight.bookSeat()
                print(" booked seat is \(bookedSeat)")
            }
        }
        
        queue2.async {
            Task {
                let availableSeat = await flight.getAvailbaleSeats()
                print(" availableSeat seats are \(availableSeat)")
            }
        }
    }
    
}
