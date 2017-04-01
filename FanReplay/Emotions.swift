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
	func readEmotions(json : JSONSerialization)
	{
		for face in json.mutableArrayValue(forKey: "scores")
		{
			let emotions = face as? [String : Double];
			
			for (emotion, score) in emotions!
			{
				print("\(emotion) : \(score)\n");
			}
		}
	}
}
