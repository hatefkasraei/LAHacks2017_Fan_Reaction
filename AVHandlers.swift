//
//  Functions.swift
//  FanReplay
//
//  Created by Hatef Kasraei on 4/1/17.
//  Copyright © 2017 The Possimpibles. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation
import CoreGraphics





func grabframe(videoPath : String, timeInSeconds : Double, destinationPath : String)
{
	var movie = AVAsset(url: URL(fileURLWithPath: videoPath))
	var track = movie.tracks(withMediaType: "vide").first!
	let imagegenerator = AVAssetImageGenerator(asset: movie);
	var time = CMTime(seconds: timeInSeconds, preferredTimescale: 100);
	
	var capturedImage : NSImage;
	
	if let imageref = try? imagegenerator.copyCGImage(at: time, actualTime: nil)
	{
		capturedImage = NSImage(cgImage: imageref, size: NSSize(width: 100, height: 100));
		var newRep = NSBitmapImageRep(cgImage: imageref);
		var data = newRep.representation(using: NSPNGFileType, properties: [String : Any]());
		try? data?.write(to: URL(fileURLWithPath: destinationPath));
	};
}
