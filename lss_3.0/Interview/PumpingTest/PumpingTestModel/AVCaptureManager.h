//
//  AVCaptureManager.h
//  SlowMotionVideoRecorder
//
//  Created by shuichi on 12/17/13.
//  Copyright (c) 2013 Shuichi Tsutsumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AVCaptureManagerDelegate <NSObject>
- (void)didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
                                  videoPath:(NSString*)parh
                                      error:(NSError *)error;
@end


@interface AVCaptureManager : NSObject

@property (nonatomic, assign) id<AVCaptureManagerDelegate> delegate;
@property (nonatomic, assign) BOOL isRecording;

- (id)initWithPreviewView:(UIView *)previewView;
- (void)toggleContentsGravity;
- (void)resetFormat;
- (void)switchFormatWithDesiredFPS:(CGFloat)desiredFPS;
- (void)startRecording;
- (void)stopRecording;
- (void)swapFrontAndBackCameras;
@end
