//
//  LsPracticeModel.h
//  lss
//
//  Created by apple on 2017/8/15.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LsPracticeListModel : NSObject

@property (nonatomic,strong) NSString   *  coverImage;
@property (nonatomic,strong) NSString   *  author;
@property (nonatomic,strong) NSString   *  authorType;
@property (nonatomic,assign) NSInteger     commnetNum;
@property (nonatomic,strong) NSString   *  classType;

@end

@interface LsPracticeModel : NSObject

@property (nonatomic,assign) NSInteger personNum;
@property (nonatomic,strong) NSArray   *practiceLists;

@end
