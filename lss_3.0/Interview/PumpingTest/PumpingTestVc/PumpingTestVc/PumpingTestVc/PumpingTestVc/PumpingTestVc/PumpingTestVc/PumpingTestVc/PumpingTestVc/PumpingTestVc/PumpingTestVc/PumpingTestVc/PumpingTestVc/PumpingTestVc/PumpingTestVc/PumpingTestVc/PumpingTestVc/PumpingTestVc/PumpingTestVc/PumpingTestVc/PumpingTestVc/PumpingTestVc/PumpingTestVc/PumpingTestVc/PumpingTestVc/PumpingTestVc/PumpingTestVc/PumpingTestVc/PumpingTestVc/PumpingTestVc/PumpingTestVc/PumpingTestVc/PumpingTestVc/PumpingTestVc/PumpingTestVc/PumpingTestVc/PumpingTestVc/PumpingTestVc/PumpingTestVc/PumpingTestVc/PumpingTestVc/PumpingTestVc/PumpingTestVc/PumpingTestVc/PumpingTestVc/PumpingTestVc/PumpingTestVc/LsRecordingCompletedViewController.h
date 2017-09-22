//
//  LsRecordingCompletedViewController.h
//  lss
//
//  Created by apple on 2017/9/10.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsBaseViewController.h"

@interface LsRecordingCompletedViewController : LsBaseViewController

@property(nonatomic, assign) float         videoTimeLength;
@property(nonatomic, strong) NSURL       * videoURL;
@property(nonatomic, strong) NSString    * videoPath;

@end
