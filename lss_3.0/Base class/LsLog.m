//
//  LsLog.m
//  lss
//
//  Created by apple on 2017/7/27.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsLog.h"

void WLG(const char *func, int lineNumber, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSString *strFormat = [NSString stringWithFormat:@"%@%s, %@%i, %@%@",@"Function: ",func,@"Line: ",lineNumber, @"Format: ",string];
    NSLog(@"%@", strFormat);
}

