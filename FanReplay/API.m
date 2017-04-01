//
//  API.m
//  FanReplay
//
//  Created by Hatef Kasraei on 4/1/17.
//  Copyright © 2017 The Possimpibles. All rights reserved.
//

#import "API.h"

@implementation api


- (NSJSONSerialization*) getEmotionsJSON: (NSString*) imageURL
{
//	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	NSString* path = @"https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize";
	NSArray* array = @[
					   // Request parameters
					   @"entities=true",
					   ];

	NSString* string = [array componentsJoinedByString:@"&"];
	path = [path stringByAppendingFormat:@"?%@", string];
	
	NSLog(@"%@", path);
	
	NSMutableURLRequest* _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:path]];
	[_request setHTTPMethod:@"POST"];
		// Request headers
	[_request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[_request setValue:@"53ac56fcff704af482b78ae3712e4789" forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
		// Request body
	
	NSString* body = @"{'url':'";
	body = [body stringByAppendingString:imageURL];
	body = [body stringByAppendingString:@"'}"];
	
	[_request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSURLResponse *response = nil;
	NSError *error = nil;
	NSData* _connectionData = [NSURLConnection sendSynchronousRequest:_request returningResponse:&response error:&error];
	
	if (nil != error)
	{
		NSLog(@"\nError: %@", error);
	}
	else
	{
		NSError* error = nil;
		NSJSONSerialization* json = nil;
		NSString* dataString = [[NSString alloc] initWithData:_connectionData encoding:NSUTF8StringEncoding];
		NSLog(@"%@", dataString);
		
		if (nil != _connectionData)
		{
			json = [NSJSONSerialization JSONObjectWithData:_connectionData options:NSJSONReadingMutableContainers error:&error];
		}
		
		if (error || !json)
		{
			NSLog(@"Could not parse loaded json with error:%@", error);
		}
		
//		NSLog(@"%@", json);
		_connectionData = nil;
		
		return json;
	}
	
	return nil;
}




@end
