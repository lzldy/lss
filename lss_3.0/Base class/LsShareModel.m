//
//  LsShareModel.m
//  lss
//
//  Created by apple on 2017/9/22.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsShareModel.h"
#import <UShareUI/UShareUI.h>
#import <QuartzCore/QuartzCore.h>

@implementation LsShareModel

-(void)shareActionWithImage:(UIImage*)image OnVc:(UIViewController*)vc{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareImageToPlatformType:platformType Image:image OnVc:vc];
    }];
    
}

- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType Image:(UIImage*)image OnVc:(UIViewController*)vc
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = image;
    [shareObject setShareImage:image];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
        if (error) {
            LsLog(@"************Share fail with error %@*********",error);
        }else{
            LsLog(@"************response data is %@",data);
            [LsMethod alertMessage:@"分享成功" WithTime:1];
        }
    }];
}


-(void)shareActionWithUrl:(NSString*)url Title:(NSString*)title OnVc:(UIViewController*)vc{
    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareImageToPlatformType:platformType Url:url Title:title OnVc:vc];
    }];

}

- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType Url:(NSString*)url Title:(NSString*)title OnVc:(UIViewController*)vc
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    NSString *str     =@"跟随良师 方为良师";
    if (![LsMethod haveValue:title]) {
        title         =str;
    }
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"良师说" descr:title thumImage:[UIImage imageNamed:@"new_icon"]];
    //设置网页地址
    shareObject.webpageUrl =url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
        if (error) {
            LsLog(@"************Share fail with error %@*********",error);
        }else{
            LsLog(@"response data is %@",data);
            [LsMethod alertMessage:@"分享成功" WithTime:1];
        }
    }];
}


@end
