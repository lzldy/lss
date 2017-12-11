//
//  LsMethod.h
//  lss
//
//  Created by apple on 2017/7/27.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsMethod : NSObject

/**
 *alert提示框
 *message:提示信息
 *time:几秒后消失
 *
 */
+(void)alertMessage:(NSString *)message WithTime:(NSTimeInterval)time;

/**
 *alert提示框
 *message:提示信息
 *有确定按钮
 *
 */
+(void)alertMessage:(NSString *)message;

/**
 *alert提示框
 *message:提示信息
 *title:标题
 *有确定按钮
 *
 */
+(void)alertMessage:(NSString *)message AndTitle:(NSString*)title;

/**
 *时间戳转date字符串
 *timeStamp:时间戳
 *
 */
+(NSString *)toDateWithTimeStamp:(NSString *)timeStamp DateFormat:(NSString*)format;

/**
 *取出标准字符串
 *dict:从字典中取
 *key:取key的value
 *
 */
+(NSString *)formatStrFromDict:(NSDictionary*)dict WithKey:(NSString*)key;

//判断是否是NSNull类
+(BOOL)isNotEqualToNsNull:(id)object;

//dict转Json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//Json转dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//返回当前时间戳字符串
+ (NSString *)toTimeStr;

//校验身份证号码
+ (BOOL)validateIDCardNumber:(NSString *)valueee;

//校验手机号
+ (BOOL) isMobile:(NSString *)mobileNumbel;

//把date转成 format 字符串
+ (NSString *)dateStrFromDate:(NSDate*)date AndFormat:(NSString*)format;

+(NSArray *)formatArrayFromDict:(NSDictionary*)dict WithKey:(NSString*)key;

+ (BOOL) isCode:(NSString *)codeNum;

+(NSString *)remove:(NSString*)str;

+(BOOL)haveValue:(id)obj;

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font;

+ (CGSize)sizeWithSize:(CGSize)sizeee String:(NSString *)string font:(UIFont *)font;

+(CABasicAnimation*)opacityAnimationFormValue:(float)fromValue ToValue:(float)toValue;

+ (UIImage *)imageWithRoundCorner:(UIImage *)sourceImage cornerRadius:(CGFloat)cornerRadius;

+ (void)begainFullScreen;

+ (void)endFullScreen;

+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time ;

+(NSMutableAttributedString*)changeColorWithStr:(NSString*)Str RangeStr:(NSString*)rangeStr;

@end
