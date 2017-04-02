//
//  AppDelegate.swift
//  FanReplay
//
//  Created by Hatef Kasraei on 4/1/17.
//  Copyright © 2017 The Possimpibles. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		
		grabFrameAndSaveOnDisk(videoPath: "/Users/hatef/Desktop/messi.mp4", timeInSeconds: 12.42, destinationPath: "/Users/hatef/Desktop/test.jpg");
		
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

