//
//  Emotions.swift
//  Lev
//
//  Created by Hatef Kasraei on 4/2/17.
//  Copyright © 2017 Danny Peng. All rights reserved.
//

import Foundation

@objc class Emotions : NSObject
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
		print("----")
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
		print("anger : \(Int(self.anger))%");
		print("fear : \(Int(self.fear))%");
		print("surprise : \(Int(self.surprise))%");
		print("contempt : \(Int(self.contempt))%");
		print("disgust : \(Int(self.disgust))%");
		print("happiness : \(Int(self.happiness))%");
		print("neutral : \(Int(self.neutral))%");
		print("sadness : \(Int(self.sadness))%");
		print("-- -- -- -- -- -- --  -- -- -- -- -- -- -- --");
	}
	
	func diffCheckWith(newEmotion : Emotions) -> [String : Double]
	{
		var to_return = [String : Double]()
		to_return["anger"] = newEmotion.anger - self.anger
		to_return["fear"] = newEmotion.fear - self.fear
		to_return["surprise"] = newEmotion.surprise - self.surprise
		to_return["disgust"] = newEmotion.disgust - self.disgust
		to_return["happiness"] = newEmotion.happiness - self.happiness
		to_return["neutral"] = newEmotion.neutral - self.neutral
		to_return["sadness"] = newEmotion.sadness - self.sadness
		return to_return
	}
	
	func didEmotionsChangeDramatically(newEmotion : Emotions) -> Bool
	{
		let diff = self.diffCheckWith(newEmotion: newEmotion)
		
		print(diff["happiness"]!);
		
		if diff["anger"]! > 50.0
		{
			return true;
		}
		if diff["fear"]! > 50.0
		{
			return true;
		}
		if diff["happiness"]! > 50.0
		{
			return true;
		}
		
		return false;
	}
	
	private func _balanceData()
	{
		self.anger = (self.anger*100/peoplePresent).rounded();
		self.fear = (self.fear*100/peoplePresent).rounded();
		self.surprise = (self.surprise*100/peoplePresent).rounded();
		self.contempt = (self.contempt*100/peoplePresent).rounded();
		self.disgust = (self.disgust*100/peoplePresent).rounded();
		self.happiness = (self.happiness*100/peoplePresent).rounded();
		self.neutral = (self.neutral*100/peoplePresent).rounded();
		self.sadness = (self.sadness*100/peoplePresent).rounded();
	}
}
