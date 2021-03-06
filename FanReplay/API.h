//
//  API.h
//  FanReplay
//
//  Created by Hatef Kasraei on 4/1/17.
//  Copyright © 2017 The Possimpibles. All rights reserved.
//

#ifndef API_h
#define API_h

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface API : NSObject

-(NSJSONSerialization*) getJSONwithURL: (NSString*)imageURL;

-(NSJSONSerialization*) getJSONwithFile : (NSString*)imagePath;

-(NSJSONSerialization*) getJSONwithIMAGE : (NSImage*) image;

@end

#endif /* API_h */
