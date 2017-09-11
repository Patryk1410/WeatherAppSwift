//
//  main.swift
//  WeatherApp
//
//  Created by patryk on 08.09.2017.
//  Copyright © 2017 patryk. All rights reserved.
//

import UIKit

//First file opened
let testFilePath: String = "XCTestConfigurationFilePath"

let isRunningTests: Bool = (ProcessInfo.processInfo.environment[testFilePath] != nil)
let appDelegateClassName: String = isRunningTests ? NSStringFromClass(FakeAppDelegate.self) : NSStringFromClass(AppDelegate.self)
let args: UnsafeMutablePointer = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))

//Application starts here
UIApplicationMain(CommandLine.argc, args, nil, appDelegateClassName)
