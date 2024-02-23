//
//  FlightUseCase.swift
//  ConcurrencyDemo
//
//  Created by Vinod Supnekar on 23/02/24.
//

import Foundation

class Flight {
    
    let company = "Vistara"
    
    var availabelSeats = ["1A", "2B", "3C"]
    
    func getAvailbaleSeats() -> [String] {
        return availabelSeats
    }
    
    func bookSeat() -> String {
        
        let bookedSeat = availabelSeats.first ?? ""
        availabelSeats.removeFirst()
        return bookedSeat
    }
}

//

// Data inconsistency fix by using barriers:-

class FlightWithThreadSafety {
    
    let company = "Vistara"
    
    let barrierQueue = DispatchQueue(label: "barrierQeue", attributes: .concurrent)

    
    var availabelSeats = ["1A", "2B", "3C"]
    
    func getAvailbaleSeats() -> [String] {
        
        barrierQueue.sync {
            return availabelSeats
        }
    }
    
    func bookSeat( closure: @escaping ((String) -> Void)) {
        
        barrierQueue.async(flags: .barrier) { [weak self] in
            
            let bookedSeat = self?.availabelSeats.first ?? ""
            self?.availabelSeats.removeFirst()
            closure(bookedSeat)
        }
    }
}


// Using Actors:-

actor FlightAsActor{
    
    nonisolated let company = "Vistara"

    
    var availabelSeats = ["1A", "2B", "3C"]
    
    func getAvailbaleSeats() -> [String] {
        return availabelSeats
    }
    
    func bookSeat() -> String {
            
        let bookedSeat = availabelSeats.first ?? ""
        availabelSeats.removeFirst()
        return bookedSeat
    }
}

