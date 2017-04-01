//
//  Emotions.swift
//  FanReplay
//
//  Created by Hatef Kasraei on 4/1/17.
//  Copyright © 2017 The Possimpibles. All rights reserved.
//

import Foundation

class Emotions
{
	var anger : Double = 0;
	var fear : Double = 0;
	var surprise : Double = 0;
	var contempt : Double = 0;
	var disgust : Double = 0;
	var happiness : Double = 0;
	var neutral : Double = 0;
	var sadness : Double = 0;
	
	var peoplePresent : Double = 0;
	
	func readEmotions(json : JSONSerialization)
	{
		for face in json.mutableArrayValue(forKey: "scores")
		{
			let emotions = face as? [String : Double];
			
			for (emotion, score) in emotions!
			{
				switch emotion {
					case "anger":
						self.anger += score;
					case "fear":
						self.fear += score;
					case "surprise":
						self.surprise += score;
					case "contempt":
						self.contempt += score;
					case "disgust":
						self.disgust += score;
					case "happiness":
						self.happiness += score;
					case "neutral":
						self.neutral += score;
					case "sadness":
						self.sadness += score;
				default:
					continue
				}
			}
			self.peoplePresent += 1;
		}
		_balanceData();
	}
	
	func consolePrint()
	{
		print("-- -- -- Average Emotions in Picture -- -- --");
		print("Total Faces in this picture: \(Int(self.peoplePresent))");
		print("anger : \(Int(self.anger * 100))%");
		print("fear : \(Int(self.fear * 100))%");
		print("surprise : \(Int(self.surprise * 100))%");
		print("contempt : \(Int(self.contempt * 100))%");
		print("disgust : \(Int(self.disgust * 100))%");
		print("happiness : \(Int(self.happiness * 100))%");
		print("neutral : \(Int(self.neutral * 100))%");
		print("sadness : \(Int(self.sadness * 100))%");
		print("-- -- -- -- -- -- --  -- -- -- -- -- -- -- --");
	}
	
	private func _balanceData()
	{
		self.anger = self.anger/peoplePresent;
		self.fear = self.anger/peoplePresent;
		self.surprise = self.surprise/peoplePresent;
		self.contempt = self.contempt/peoplePresent;
		self.disgust = self.disgust/peoplePresent;
		self.happiness = self.happiness/peoplePresent;
		self.neutral = self.neutral/peoplePresent;
		self.sadness = self.sadness/peoplePresent;
		
	}
}
