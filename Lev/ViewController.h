//
//  ViewController.h
//  Lev
//
//  Created by Danny Peng on 4/2/17.
//  Copyright © 2017 Danny Peng. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
#import "CustomView.h"
#import "Lev-Swift.h"
#import "API.h"

@interface ViewController : NSViewController
{
    AVCaptureSession *session;
    AVCaptureConnection *video_connection;
    AVCaptureStillImageOutput *still_image_output;
	Emotions* emotion;
	API* api;
	AVIHandler* avi;
	
	double happiness;
	double anger;
	double fear;
	NSTimer* timer;
	int initTime;
	
}
@property (nonatomic, retain)AVCaptureVideoPreviewLayer *preview_layer;
@property (nonatomic, retain)CustomView *customView1;

@property (nonatomic, retain)IBOutlet NSButton *startPreviewButton;
@property (nonatomic, retain)IBOutlet NSButton *stopPreviewButton;
@property (nonatomic, retain)IBOutlet NSButton *takePictureButton;

@property (nonatomic, retain)IBOutlet NSImageView *imageView1;

-(IBAction) startPreview_click : (id) sender;
-(IBAction) stopPreview_click : (id) sender;
-(IBAction) takePicture_click : (id) sender;

-(void) initCaptureSession;
-(void) setupPreviewLayer;
-(NSData*) catchImage;
-(void) picture;

@end

