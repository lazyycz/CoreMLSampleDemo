//
//  VideoCapture.m
//  CoreMLSample
//
//  Created by Stone.Yu on 2017/12/31.
//  Copyright © 2017年 Stone.Yu. All rights reserved.
//

#import "VideoCapture.h"
#import "MachineCognition.h"

@interface VideoCapture () <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureConnection *videoConnection;

@end

@implementation VideoCapture

- (instancetype)init
{
    if (self = [super init]) {
        [self initAVCaptur];
    }
    
    return self;
}

- (void)initAVCaptur
{
    AVCaptureDeviceInput *deviceInput = [self deviceInput];
    if ([self.session canAddInput:deviceInput])
        [self.session addInput:deviceInput];
    
    if ([self.session canAddOutput:self.videoDataOutput])
        [self.session addOutput:self.videoDataOutput];
}

#pragma mark - public

- (void)startVideoCapture
{
    [self.session startRunning];
    self.videoConnection.enabled = YES;
    [self.videoDataOutput setSampleBufferDelegate:self queue:dispatch_queue_create("videoQueue", NULL)];
}

- (void)stopVideoCapture
{
    [self.videoDataOutput setSampleBufferDelegate:nil queue:nil];
    self.videoConnection.enabled = NO;
    [self.session stopRunning];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    dispatch_queue_t queue = dispatch_queue_create("CMSampleBufferRef", NULL);
    dispatch_sync(queue, ^{
        NSString *result = [MachineCognition inceptionv3NetPredictImageScene:sampleBuffer];
        dispatch_async(dispatch_get_main_queue(), ^{
            !self.completeBlock ? : self.completeBlock(result);
        });
    });
}

#pragma mark - gtter and setter

- (AVCaptureSession *)session
{
    if (!_session) {
        _session = [AVCaptureSession new];
    }
    
    return _session;
}

- (AVCaptureDeviceInput *)deviceInput
{
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (videoDevice.isFocusPointOfInterestSupported && [videoDevice isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
        [videoDevice lockForConfiguration:nil];
        [videoDevice setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        [videoDevice unlockForConfiguration];
    }
    
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:videoDevice error:&error];
    if (error) {
        NSLog(@"creat deviceInput error !");
        return nil;
    } else {
        return deviceInput;
    }
}

- (AVCaptureVideoDataOutput *)videoDataOutput
{
    if (!_videoDataOutput) {
        _videoDataOutput = [AVCaptureVideoDataOutput new];
        NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA],(id)kCVPixelBufferPixelFormatTypeKey, nil];
        [_videoDataOutput setVideoSettings:outputSettings];
    }
    
    return _videoDataOutput;
}

- (AVCaptureConnection *)videoConnection
{
    if (!_videoConnection) {
        _videoConnection = [self.videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
        _videoConnection.enabled = NO;
        [_videoConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    }
    
    return _videoConnection;
}

- (AVCaptureVideoPreviewLayer *)previewLayer
{
    if (!_previewLayer) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    }
    
    return _previewLayer;
}

@end
