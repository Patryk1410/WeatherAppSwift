//
//  FirstSpec.swift
//  WeatherApp
//
//  Created by patryk on 08.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import WeatherApp

class FirestSpec : QuickSpec {
    
    override func spec() {
        
        describe("First test") {
            
            context("checking if true is true") {
                
                it("should be true") {
                    expect(true).to(beTrue())
                }
            }
        }
    }
}
