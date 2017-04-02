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
		//		grabFrameAndSaveOnDisk(videoPath: "/Users/hatef/Desktop/fan/adidas.mp4", timeInSeconds: 43.02, destinationPath: "/Users/hatef/Desktop/fan/outputed/adidas.jpg");
		
		let api = API();
		let emotion = Emotions();
		emotion.readEmotions(json: api.getJSONwithIMAGE(grabFrameInJPEG(videoPath: "/Users/hatef/Desktop/fan/adidas.mp4" , timeInSeconds: 43.02)));
		emotion.consolePrint()
		
		playBackWithinTimeRange(videoPath: "/Users/hatef/Desktop/fan/adidas.mp4", start: 1.0, end: 23.03, destinationPath: "/Users/hatef/Desktop/fan/outputed/saved.mp4");
		
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

