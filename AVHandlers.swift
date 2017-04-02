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

func grabFrameInJPEG(videoPath : String, timeInSeconds : Double) -> NSImage?
{
	let imagegenerator = AVAssetImageGenerator(asset: AVAsset(url: URL(fileURLWithPath: videoPath)));
	
	if let imageref = try? imagegenerator.copyCGImage(at: CMTime(seconds: timeInSeconds, preferredTimescale: 100), actualTime: nil)
	{
			return NSImage(cgImage: imageref, size: NSSize(width: 50, height: 50))
	};
	
	return nil;
}

//func playBackWithinTimeRange(videoPath : String, start : Double, end : Double, destinationPath : String)
//{
//	var movie = AVAsset(url: URL(fileURLWithPath: videoPath));
//	
////	var videoTrack = movie.tracks(withMediaType: "vide").first!;
////	
////	var mutableComposition = AVMutableComposition()
////	
//////	mutableComposition.addMutableTrack(withMediaType: "vide", preferredTrackID: 0);
////	
////	var startcm = CMTime(seconds: start, preferredTimescale: 100)
////	var endcm = CMTime(seconds: end, preferredTimescale: 100)
////	
////	var atcm = CMTime(seconds: 0.0, preferredTimescale: 100);
////	
////	try? mutableComposition.insertTimeRange(CMTimeRangeMake(startcm, endcm), of: movie, at: atcm);
////	
////	print(mutableComposition.tracks(withMediaType: "vide").first!);
//	
//	let export = AVAssetExportSession(asset: movie, presetName: "vide");
//	
//	
//	print(export)
////	export!.outputURL = URL(fileURLWithPath: destinationPath);
////	
////	export!.exportAsynchronously(completionHandler: {})
////
////	print(export?.progress);
//	
//	
//}

func playBackWithinTimeRange(videoPath : String, start : Double, end : Double, destinationPath : String)
{
	var movie = AVAsset(url: URL(fileURLWithPath: videoPath));
	var videoTrack = movie.tracks(withMediaType: "vide").first!;
	
	
	let preferredPreset = AVAssetExportPresetPassthrough
	
	let composition = AVMutableComposition()
	
	let videoCompTrack = composition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: CMPersistentTrackID())
	
	var accumulatedTime = kCMTimeZero
	var endtime = CMTime(seconds: end, preferredTimescale: 100);
	var starttime = CMTime(seconds: start, preferredTimescale: 100);
	
	let durationOfCurrentSlice = CMTimeSubtract(endtime, starttime)
	let timeRangeForCurrentSlice = CMTimeRangeMake(starttime, durationOfCurrentSlice)
	
	accumulatedTime = CMTimeAdd(accumulatedTime, durationOfCurrentSlice)
	
	if let r = try? videoCompTrack.insertTimeRange(timeRangeForCurrentSlice, of: videoTrack, at: starttime)
	{
		let exportSession = AVAssetExportSession(asset: composition, presetName: preferredPreset)!
		exportSession.outputURL = URL(fileURLWithPath: destinationPath);
		exportSession.outputFileType = AVFileTypeAppleM4V
		
		exportSession.exportAsynchronously(completionHandler: {() -> Void in
			DispatchQueue.main.async(execute: {() -> Void in
				
			})
		});
		
		
		print("done")
		print(exportSession);
	}
	
}


//func playBackWithinTimeRange(videoPath : String, start : Double, end : Double, destinationPath : String)
//{
//	var movie = AVAsset(url: URL(fileURLWithPath: videoPath));
//	var videoTrack = movie.tracks(withMediaType: "vide").first!;
//	var audioTrack = movie.tracks(withMediaType: "soun").first!;
//	
//	//	var seg = track.segment(forTrackTime: CMTime(seconds: 44.0 , preferredTimescale: 100));
//	
//
//	let preferredPreset = AVAssetExportPresetPassthrough
//	
//	let composition = AVMutableComposition()
//	
//	let videoCompTrack = composition.addMutableTrack(withMediaType: AVMediaTypeVideo, preferredTrackID: CMPersistentTrackID())
//	let audioCompTrack = composition.addMutableTrack(withMediaType: AVMediaTypeAudio, preferredTrackID: CMPersistentTrackID())
//	
//	let assetVideoTrack: AVAssetTrack = videoTrack
//	let assetAudioTrack: AVAssetTrack = audioTrack
//	
//	var accumulatedTime = kCMTimeZero
//	var endtime = CMTime(seconds: end, preferredTimescale: 100);
//	var starttime = CMTime(seconds: start, preferredTimescale: 100);
//
//	let durationOfCurrentSlice = CMTimeSubtract(endtime, starttime)
//	let timeRangeForCurrentSlice = CMTimeRangeMake(starttime, durationOfCurrentSlice)
//
//	accumulatedTime = CMTimeAdd(accumulatedTime, durationOfCurrentSlice)
//	
//	var compError: NSError?
//	try? videoCompTrack.insertTimeRange(timeRangeForCurrentSlice, of: assetVideoTrack, at: accumulatedTime)
//	try? audioCompTrack.insertTimeRange(timeRangeForCurrentSlice, of: assetAudioTrack, at: accumulatedTime)
//	
//	
//	let exportSession = AVAssetExportSession(asset: composition, presetName: preferredPreset)!
//	exportSession.outputURL = URL(fileURLWithPath: destinationPath);
//	exportSession.outputFileType = AVFileTypeAppleM4V
//	exportSession.shouldOptimizeForNetworkUse = true
//	
//	exportSession.exportAsynchronously {
//		
//	}
//	
//	if compError != nil {
//		NSLog("error during composition: \(compError)")
//	}
//	
//	print(exportSession)
//	
//}

