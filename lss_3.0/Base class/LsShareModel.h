//
//  LsShareModel.h
//  lss
//
//  Created by apple on 2017/9/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsShareModel : NSObject

-(void)shareActionWithImage:(UIImage*)image OnVc:(UIViewController*)vc;

-(void)shareActionWithUrl:(NSString*)url Title:(NSString*)title OnVc:(UIViewController*)vc;

@end
