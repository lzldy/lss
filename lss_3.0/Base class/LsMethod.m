//
//  LsMethod.m
//  lss
//
//  Created by apple on 2017/7/27.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsMethod.h"
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

@implementation LsMethod

+(void)alertMessage:(NSString *)message{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    [alertView show];
}

+(void)alertMessage:(NSString *)message WithTime:(NSTimeInterval)time{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    [alertView show];
//    [alertView performSelector:@selector(dismissAnimated:) withObject:nil afterDelay:time];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[LSApplicationDelegate window] animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText =message;
    hud.margin = 20.f;//提示框的高度
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:time];
}

+(void)alertMessage:(NSString *)message AndTitle:(NSString*)title{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
    [alertView show];
}

+(NSString *)toDateWithTimeStamp:(NSString *)timeStamp DateFormat:(NSString*)format{
    if (timeStamp&&![timeStamp isKindOfClass:[NSNull class]]) {
        NSTimeInterval _interval=[timeStamp doubleValue];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
        NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
        [dateformat setDateFormat:format];
        return [dateformat stringFromDate: date];
    }else{
        return @"";
    }
}

+(NSString *)formatStrFromDict:(NSDictionary*)dict WithKey:(NSString*)key{
    
    if ([dict objectForKey:key]&&![[dict objectForKey:key] isKindOfClass:[NSNull class]]) {
        NSString *str=[NSString stringWithFormat:@"%@",[dict objectForKey:key]];
        return str;
    }else{
        return @"";
    }
}

+(NSArray *)formatArrayFromDict:(NSDictionary*)dict WithKey:(NSString*)key{
    
    if ([dict objectForKey:key]&&![[dict objectForKey:key] isKindOfClass:[NSNull class]]) {
        NSArray *array=[dict objectForKey:key];
        return array;
    }else{
        return nil;
    }
}


+(BOOL)isNotEqualToNsNull:(id)object{
    if ([object isKindOfClass:[NSNull class]]) {
        return NO;
    }else{
        return YES;
    }
}

+(BOOL)haveValue:(id)obj{
    if (!obj) {
        return NO;
    }else{
        if ([obj isKindOfClass:[NSString class]]) {
            if ([[LsMethod remove:obj] isEqualToString:@""]) {
                return NO;
            }
        }
    }
    return YES;
}

+(NSString *)remove:(NSString*)str{
    str = [str stringByReplacingOccurrencesOfString:@" "  withString: @""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString: @""];

    return str;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        LsLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


+ (NSString *)toTimeStr
{
    NSString *dateStr = [NSString stringWithFormat:@"%.f",1000*[[NSDate date] timeIntervalSince1970]];
    
    return dateStr;
}

+ (BOOL)validateIDCardNumber:(NSString *)valueee {
    
    NSString * value = [valueee stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression  alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression  alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value  substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

+ (BOOL) isMobile:(NSString *)mobileNumbel{
    NSString * MOBIL = @"^1(3[0-9]|4[0-9]|5[0-9]|7[0-9]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
      if ([regextestmobile evaluateWithObject:mobileNumbel]) {
        return YES;
    }
    return NO;
}

+ (BOOL) isCode:(NSString *)codeNum{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:codeNum]&&codeNum.length==6) {
        return YES;
    }
    return NO;
}

+ (NSString *)dateStrFromDate:(NSDate*)date AndFormat:(NSString*)format{
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:format];
    
    NSString *  dateString=[dateformatter stringFromDate:date];
    
    return dateString;
}

// 定义成方法方便多个label调用 增加代码的复用性
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传入的字体字典
                                       context:nil];
    
    return rect.size;
}

+ (CGSize)sizeWithSize:(CGSize)sizeee String:(NSString *)string font:(UIFont *)font
{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(sizeee.width, 8000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传入的字体字典
                                       context:nil];
    
    return rect.size;
}

+(CABasicAnimation*)opacityAnimationFormValue:(float)fromValue ToValue:(float)toValue{
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    opacityAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    
    opacityAnimation.toValue   = [NSNumber numberWithFloat:toValue];
    
    opacityAnimation.duration  = 0.5f;
    
    opacityAnimation.autoreverses= NO;
    
    return opacityAnimation;
}

+ (UIImage *)imageWithRoundCorner:(UIImage *)sourceImage cornerRadius:(CGFloat)cornerRadius{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(sourceImage.size, NO, scale);
    CGRect bounds = CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cornerRadius*scale];
    [path addClip];
    [sourceImage drawInRect:bounds];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(void)begainFullScreen
{
    LsAppDelegate *appDelegate = (LsAppDelegate *)LSApplicationDelegate;
    appDelegate.allowRotation = YES;
}

// 退出全屏
+(void)endFullScreen
{
    LsAppDelegate *appDelegate = (LsAppDelegate *)LSApplicationDelegate;
    appDelegate.allowRotation = NO;
    
    //    强制归正：
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val =UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

@end
