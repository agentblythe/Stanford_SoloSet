//
//  Clock.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 11/08/2021.
//

import Foundation
import Combine

//
// This class implements a cancellable timer which can be started and stopped
// and tracks the time that has elapsed since the timer has been started
// This class takes a time interval as an argument on initialisation so that the
// timer can be customised to "fire" on any given interval
//
class Clock {
    private let timeInterval: TimeInterval
    private var cancellableTimer: AnyCancellable!
    
    private(set) var timeElapsed: Double = 0
    
    required init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    //
    // Start the timer and reset the elapsed time to zero
    //
    func start() {
        timeElapsed = 0
        
        cancellableTimer = Timer.publish(every: timeInterval, on: RunLoop.main, in: .default).autoconnect().sink(receiveValue: { _ in
            self.timeElapsed += self.timeInterval
        })
    }
    
    //
    // Stop the timer
    //
    func stop() {
        cancellableTimer?.cancel()
    }
}
