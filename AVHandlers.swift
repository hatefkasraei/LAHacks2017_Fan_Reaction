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





func grabFrameAndSaveOnDisk(videoPath : String, timeInSeconds : Double, destinationPath : String)
{
	let imagegenerator = AVAssetImageGenerator(asset: AVAsset(url: URL(fileURLWithPath: videoPath)));
	
	if let imageref = try? imagegenerator.copyCGImage(at: CMTime(seconds: timeInSeconds, preferredTimescale: 100), actualTime: nil)
	{
		let data = NSBitmapImageRep(cgImage: imageref).representation(using: NSJPEGFileType, properties: [String : Any]());
		try? data?.write(to: URL(fileURLWithPath: destinationPath));
	};
}

