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

@interface api : NSObject


-(NSJSONSerialization*) getEmotionsJSON: (NSString*)imageURL;


@end

#endif /* API_h */
