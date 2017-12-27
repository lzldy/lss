//
//  LsSingleton.h
//  lss
//
//  Created by apple on 2017/7/27.
//  Copyright © 2017年 lss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setting : NSObject

@property (strong,nonatomic) NSArray   *setArray;

@property (strong,nonatomic) NSString  *memo;
@property (strong,nonatomic) NSString  *nickName;
@property (strong,nonatomic) NSURL     *face;

@end

@interface User : NSObject

@property (strong,nonatomic) NSString  *sex;
@property (strong,nonatomic) NSString  *memo;
@property (strong,nonatomic) NSString  *nickName;
@property (strong,nonatomic) NSString  *mobile;
@property (strong,nonatomic) NSURL     *face;

@property (strong,nonatomic) NSString  *branchId;
@property (strong,nonatomic) NSString  *branchName;
@property (strong,nonatomic) NSString  *branchPrvnId;
@property (strong,nonatomic) NSString  *branchPrvnName;

@end


@interface LsSingleton : NSObject

+(LsSingleton *)sharedInstance;

@property (nonatomic,strong)  User    *user;
@property (nonatomic,strong)  Setting *setting;

@end
