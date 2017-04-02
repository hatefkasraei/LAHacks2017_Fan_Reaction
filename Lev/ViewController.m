//
//  ViewController.m
//  Lev
//
//  Created by Danny Peng on 4/2/17.
//  Copyright © 2017 Danny Peng. All rights reserved.
//

#import "ViewController.h"




@implementation ViewController

- (void) viewWillAppear {
    [super viewDidLoad];
    [super viewWillAppear];
    self.customView1 = [[CustomView alloc] initWithFrame : self.view.bounds];
    [self.view setWantsLayer: YES];
    [self.view addSubview:self.customView1];
    [self initCaptureSession];
    [self setupPreviewLayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    


    // Do any additional setup after loading the view.
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
    if (![session isRunning])
        [session startRunning];
}

-(IBAction)stopPreview_click : (id) sender {
    if ([session isRunning])
        [session stopRunning];
}

-(IBAction)takePicture_click : (id) sender {
    video_connection = nil;
    
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
    }
    }];
    
    


}


@end
