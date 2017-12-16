//
//  AVCaptureManager.m
//  SlowMotionVideoRecorder
//
//  Created by shuichi on 12/17/13.
//  Copyright (c) 2013 Shuichi Tsutsumi. All rights reserved.
//

#import "AVCaptureManager.h"
#import <AVFoundation/AVFoundation.h>


@interface AVCaptureManager ()
<AVCaptureFileOutputRecordingDelegate>
{
    CMTime defaultVideoMaxFrameDuration;
}
@property (nonatomic, strong) AVCaptureSession            *captureSession;
@property (nonatomic, strong) AVCaptureMovieFileOutput    *fileOutput;
@property (nonatomic, strong) AVCaptureDeviceFormat       *defaultFormat;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer  *previewLayer;
@property (nonatomic, strong) NSString                    *videoPath;
@end


@implementation AVCaptureManager

- (id)initWithPreviewView:(UIView *)previewView {
    
    self = [super init];
    
    if (self) {
        
        NSError *error;
        
        self.captureSession = [[AVCaptureSession alloc] init];
        self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
        
        //AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDevice *videoDevice = [self cameraWithPosition:AVCaptureDevicePositionFront];
        AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
        
        if (error) {
            NSLog(@"Video input creation failed");
            return nil;
        }
        
        if (![self.captureSession canAddInput:videoIn]) {
            NSLog(@"Video input add-to-session failed");
            return nil;
        }
        [self.captureSession addInput:videoIn];
        
        
        // save the default format
        self.defaultFormat = videoDevice.activeFormat;
        defaultVideoMaxFrameDuration = videoDevice.activeVideoMaxFrameDuration;
        
        
        AVCaptureDevice *audioDevice= [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        AVCaptureDeviceInput *audioIn = [AVCaptureDeviceInput deviceInputWithDevice:audioDevice error:&error];
        [self.captureSession addInput:audioIn];
        
        self.fileOutput = [[AVCaptureMovieFileOutput alloc] init];
        [self.captureSession addOutput:self.fileOutput];
        
//        横屏录制方向
//        AVCaptureConnection * videoConnection = [self.fileOutput connectionWithMediaType:AVMediaTypeVideo];
//        [videoConnection setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
        
        self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
        self.previewLayer.frame = previewView.bounds;
        self.previewLayer.contentsGravity = kCAGravityResizeAspectFill;
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [previewView.layer insertSublayer:self.previewLayer atIndex:0];
        
        [self.captureSession startRunning];
    }
    return self;
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}

- (void)swapFrontAndBackCameras {
    // Assume the session is already running
    
    NSArray *inputs = self.captureSession.inputs;
    for ( AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        if ( [device hasMediaType:AVMediaTypeVideo] ) {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront)
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            else
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            // beginConfiguration ensures that pending changes are not applied immediately
            [self.captureSession beginConfiguration];
            
            [self.captureSession removeInput:input];
            [self.captureSession addInput:newInput];
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [self.captureSession commitConfiguration];
            
            
            break;
        }
    }
    AVCaptureConnection * videoConnection = [self.fileOutput connectionWithMediaType:AVMediaTypeVideo];
    [videoConnection setVideoOrientation:AVCaptureVideoOrientationLandscapeRight];
}


// =============================================================================
#pragma mark - Public

- (void)toggleContentsGravity {
    
    if ([self.previewLayer.videoGravity isEqualToString:AVLayerVideoGravityResizeAspectFill]) {
    
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    }
    else {
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
}

- (void)resetFormat {

    BOOL isRunning = self.captureSession.isRunning;
    
    if (isRunning) {
        [self.captureSession stopRunning];
    }

    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [videoDevice lockForConfiguration:nil];
    videoDevice.activeFormat = self.defaultFormat;
    videoDevice.activeVideoMaxFrameDuration = defaultVideoMaxFrameDuration;
    [videoDevice unlockForConfiguration];

    if (isRunning) {
        [self.captureSession startRunning];
    }
}

- (void)switchFormatWithDesiredFPS:(CGFloat)desiredFPS
{
    BOOL isRunning = self.captureSession.isRunning;
    
    if (isRunning)  [self.captureSession stopRunning];
    
    AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceFormat *selectedFormat = nil;
    int32_t maxWidth = 0;
    AVFrameRateRange *frameRateRange = nil;

    for (AVCaptureDeviceFormat *format in [videoDevice formats]) {
        
        for (AVFrameRateRange *range in format.videoSupportedFrameRateRanges) {
            
            CMFormatDescriptionRef desc = format.formatDescription;
            CMVideoDimensions dimensions = CMVideoFormatDescriptionGetDimensions(desc);
            int32_t width = dimensions.width;

            if (range.minFrameRate <= desiredFPS && desiredFPS <= range.maxFrameRate && width >= maxWidth) {
                
                selectedFormat = format;
                frameRateRange = range;
                maxWidth = width;
            }
        }
    }
    
    if (selectedFormat) {
        
        if ([videoDevice lockForConfiguration:nil]) {
            
            NSLog(@"selected format:%@", selectedFormat);
            videoDevice.activeFormat = selectedFormat;
            videoDevice.activeVideoMinFrameDuration = CMTimeMake(1, (int32_t)desiredFPS);
            videoDevice.activeVideoMaxFrameDuration = CMTimeMake(1, (int32_t)desiredFPS);
            [videoDevice unlockForConfiguration];
        }
    }
    
    if (isRunning) [self.captureSession startRunning];
}

- (void)startRecording {
    
    NSDate *senddate = [NSDate date];
    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    LsLog(@"date2时间戳 = %@",date2);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
   
    NSString *filePath =[NSString stringWithFormat:@"%@/%@.mov", documentsDirectory, date2];
    self.videoPath =date2 ;
    
    NSURL *fileURL = [NSURL URLWithString:[@"file://" stringByAppendingString:filePath]];
    [self.fileOutput startRecordingToOutputFileURL:fileURL recordingDelegate:self];
}

- (void)stopRecording {

    [self.fileOutput stopRecording];
}


// =============================================================================
#pragma mark - AVCaptureFileOutputRecordingDelegate

- (void)                 captureOutput:(AVCaptureFileOutput *)captureOutput
    didStartRecordingToOutputFileAtURL:(NSURL *)fileURL
                       fromConnections:(NSArray *)connections{
    _isRecording = YES;
}

- (void)                 captureOutput:(AVCaptureFileOutput *)captureOutput
   didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
                       fromConnections:(NSArray *)connections error:(NSError *)error
{
//    [self saveRecordedFile:outputFileURL];
    _isRecording = NO;
    
    if ([self.delegate respondsToSelector:@selector(didFinishRecordingToOutputFileAtURL:videoPath:error:)]) {
        [self.delegate didFinishRecordingToOutputFileAtURL:outputFileURL videoPath:_videoPath error:error];
    }
}

@end
