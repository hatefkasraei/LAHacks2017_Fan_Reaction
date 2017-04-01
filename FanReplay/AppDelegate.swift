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
		
		var a = api();
		
		var imageurl = "http://the18.com/sites/default/files/styles/feature_image_with_focal/public/feature-images/20161022-The-18-Image-Messi-Yells-At-Valencia-Fans-1199x800.jpg?itok=ukmvKQd0";
		
		
		
		print("json begins...");
		
		var emotions = Emotions();
		emotions.readEmotions(json: a.getEmotionsJSON(imageurl));
		
		print("... done.\n");
		
		
		emotions.consolePrint();
		
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

