//
//  LsLog.h
//  lss
//
//  Created by apple on 2017/7/27.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG_MODE
#define LsLog(fmt, ...) WLG(__PRETTY_FUNCTION__, __LINE__, fmt, ##__VA_ARGS__)
#else
#define LsLog(...)
#endif

void WLG(const char *func, int lineNumber, NSString *format, ...);
