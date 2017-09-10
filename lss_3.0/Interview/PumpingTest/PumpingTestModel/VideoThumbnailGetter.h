//
//  VideoThumbnailGetter.h
//  Jupiter
//
//  Created by yangbin on 2016/11/26.
//  Copyright © 2016年 yangbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoThumbnailGetter : NSObject
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time ;
@end
