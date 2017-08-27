//
//  LsCustomPlayerViewController.h
//  lss
//
//  Created by apple on 2017/8/27.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsBaseViewController.h"

@interface LsVideoModel : NSObject

@property (nonatomic ,strong) NSString  *desp;
@property (nonatomic ,strong) NSURL     *playurl;
@property (nonatomic ,strong) NSString  *quality;
@property (nonatomic ,strong) NSURL     *spareurl;

@property (nonatomic ,strong) NSArray   *videoModelArray;

@end

@interface LsCustomPlayerViewController : LsBaseViewController

@property (nonatomic ,strong) NSString  *videoId;

@end
