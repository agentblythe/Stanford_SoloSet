//
//  Clock.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 11/08/2021.
//

import Foundation
import Combine

class Clock {
    private let timeInterval: TimeInterval
    private var cancellableTimer: AnyCancellable!
    
    private(set) var timeElapsed: Int = 0
    
    required init(timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    func start() {
        print("start")
        timeElapsed = 0
        
        cancellableTimer = Timer.publish(every: timeInterval, on: RunLoop.main, in: .default).autoconnect().sink(receiveValue: { _ in
            self.timeElapsed += 1
            print(self.timeElapsed)
        })
    }
    
    func stop() {
        print("stop")
        cancellableTimer?.cancel()
    }
}
