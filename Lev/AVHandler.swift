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





@objc class AVIHandler : NSObject
{


func grabFrameAndSaveOnDisk(videoPath : String, timeInSeconds : Double, destinationPath : String)
{
	let imagegenerator = AVAssetImageGenerator(asset: AVAsset(url: URL(fileURLWithPath: videoPath)));
	
	if let imageref = try? imagegenerator.copyCGImage(at: CMTime(seconds: timeInSeconds, preferredTimescale: 100), actualTime: nil)
	{
		let data = NSBitmapImageRep(cgImage: imageref).representation(using: NSJPEGFileType, properties: [String : Any]());
		try? data?.write(to: URL(fileURLWithPath: destinationPath));
	};
}

func grabFrameInJPEG(videoPath : String, timeInSeconds : Double) -> NSImage?
{
	let imagegenerator = AVAssetImageGenerator(asset: AVAsset(url: URL(fileURLWithPath: videoPath)));
	
	if let imageref = try? imagegenerator.copyCGImage(at: CMTime(seconds: timeInSeconds, preferredTimescale: 100), actualTime: nil)
	{
		return NSImage(cgImage: imageref, size: NSSize(width: 50, height: 50))
	};
	
	return nil;
}


func playBackWithinTimeRange(videoPath : String, start : Double, end : Double, destinationPath : String)
{
	var movie = AVAsset(url: URL(fileURLWithPath: videoPath));
	var assetVideoTrack = movie.tracks(withMediaType: "vide").first!;
	var assetAudioTrack = movie.tracks(withMediaType: "soun").first!;
	
	let preferredPreset = AVAssetExportPresetPassthrough
	
	let composition = AVMutableComposition()
	
	let videoCompTrack = composition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: CMPersistentTrackID())
	let audioCompTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
	
	var accumulatedTime = kCMTimeZero
	var endtime = CMTime(seconds: end, preferredTimescale: 100);
	var starttime = CMTime(seconds: start, preferredTimescale: 100);
	
	let durationOfCurrentSlice = CMTimeSubtract(endtime, starttime)
	
	let timeRangeForCurrentSlice = CMTimeRangeMake(starttime, durationOfCurrentSlice)
	
	
	try? videoCompTrack.insertTimeRange(timeRangeForCurrentSlice, of: assetVideoTrack, at: CMTime(seconds: 0.0, preferredTimescale: 100))
	try? audioCompTrack.insertTimeRange(timeRangeForCurrentSlice, of: assetAudioTrack, at: CMTime(seconds: 0.0, preferredTimescale: 100))
	
	
	let exportSession = AVAssetExportSession(asset: composition, presetName: preferredPreset)!
	exportSession.outputURL = URL(fileURLWithPath: destinationPath);
	exportSession.outputFileType = AVFileTypeAppleM4V
	exportSession.shouldOptimizeForNetworkUse = true
	
	exportSession.exportAsynchronously(completionHandler: {() -> Void in
		DispatchQueue.main.async(execute: {() -> Void in
			print(exportSession.progress);
		})
	});
}

}
