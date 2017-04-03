//
//  ViewController.m
//  Lev
//
//  Created by Danny Peng on 4/2/17.
//  Copyright © 2017 Danny Peng. All rights reserved.
//

#import "ViewController.h"




@implementation ViewController

- (void) viewWillAppear
{
    [super viewDidLoad];
    [super viewWillAppear];
    self.customView1 = [[CustomView alloc] initWithFrame : self.view.bounds];
    [self.view setWantsLayer: YES];
    [self.view addSubview:self.customView1];
    [self initCaptureSession];
    [self setupPreviewLayer];
	[session startRunning];
	
	emotion = [[Emotions alloc] init];
	api = [[API alloc] init];
	avi = [[AVIHandler alloc] init];
	
	initTime = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	[NSTimer scheduledTimerWithTimeInterval:3.5f target:self selector:@selector(takePicture_click:) userInfo:nil repeats:YES];
}

- (void) initCaptureSession {
    session = [[AVCaptureSession alloc]init];
    if ([session canSetSessionPreset : AVCaptureSessionPresetHigh])
        [session setSessionPreset : AVCaptureSessionPresetHigh];
    AVCaptureDeviceInput *device_input = [[AVCaptureDeviceInput alloc]  initWithDevice : [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo][0] error : nil];
    if ([session canAddInput : device_input])
        [session addInput : device_input];
}

- (void) setupPreviewLayer {
    self.preview_layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    [self.preview_layer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.preview_layer setFrame: self.view.bounds];
    [self.view.layer addSublayer: self.preview_layer];
    
    still_image_output =[[AVCaptureStillImageOutput alloc] init];
    
    NSDictionary *output_settings = [[NSDictionary alloc] initWithObjectsAndKeys : AVVideoCodecJPEG, AVVideoCodecKey, nil];
    
    [still_image_output setOutputSettings : output_settings];
    
    if ([session canAddOutput : still_image_output])
        [session addOutput : still_image_output];
}





-(IBAction)startPreview_click : (id) sender {
//    if (![session isRunning])
//        [session startRunning];
	timer = [[NSTimer alloc] init];
	[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(appendTime) userInfo:nil repeats:YES];
}

-(IBAction)stopPreview_click : (id) sender {
    if ([session isRunning])
        [session stopRunning];
}
- (IBAction)label:(NSTextField *)sender {
	
}

-(IBAction)takePicture_click : (id) sender {
//    video_connection = nil;
	
    for (AVCaptureConnection *connection in still_image_output.connections) {
        for(AVCaptureInputPort *port in [connection inputPorts])
            if([[port mediaType] isEqual : AVMediaTypeVideo]) {
                video_connection = connection;
                break;
            }
    if(video_connection)
        break;
    }
	
    [still_image_output captureStillImageAsynchronouslyFromConnection : video_connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error){
        if (imageDataSampleBuffer != nil){
			
            NSData *image_data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation : imageDataSampleBuffer];
			
            NSData *image = [[NSImage alloc] initWithData : image_data];
			
            self.imageView1.image = image;
			
			
			emotion = [[Emotions alloc] init];
			
			[emotion readEmotionsWithJson: [api getJSONwithIMAGE: image]];

			
			if (emotion.anger > 40 || emotion.fear > 40 || emotion. happiness > 40)
			{
				NSLog(@"Now is: \n");
				[emotion consolePrint];
					// cut video here!
				
				NSString* path = [avi generateWithTime:initTime];
				
				
				NSLog(path);
				
//				[avi playBackWithinTimeRangeWithVideoPath:@"/Users/hatef/Desktop/fan/messi.mp4" start:initTime - 5 end:initTime + 5 destinationPath:@"/Users/hatef/Desktop/fan/outputed/reaction.mp4"];
			
				[avi playBackWithinTimeRangeWithVideoPath:@"/Users/hatef/Desktop/fan/messi.mp4" start:initTime - 5 end:initTime + 5 destinationPath:path];
}
    }
    }];
	
	if (![session isRunning])
		[session startRunning];
	
//	NSLog(@"done...\n");
}

- (void) appendTime
{
	initTime++;
//	NSLog(@"!");
}

@end
