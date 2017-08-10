//
//  LsConfigureModel.m
//  lss
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsConfigureModel.h"

@implementation LsBaseConfigureModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"     : @"id"};
}

-(NSMutableArray *)subjectArray{
    if (!_subjectArray) {
        _subjectArray =[NSMutableArray array];
    }
    return _subjectArray;
}

@end

@implementation LsConfigureModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"levels"  : @"data.levels",
             @"catgs"   : @"data.catgs",
             @"branchs" : @"data.branchs"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"levels"  : [LsBaseConfigureModel class],
             @"catgs"   : [LsBaseConfigureModel class],
             @"branchs" : [LsBaseConfigureModel class]};
}

-(void)fromDict:(NSDictionary *)dict{
    self.allSubject            =[NSMutableArray array];
    NSMutableArray *eleSubject =[NSMutableArray array];
    NSMutableArray *midSubject =[NSMutableArray array];
    NSMutableArray *kdSubject  =[NSMutableArray array];
    NSMutableArray *hmdSubject =[NSMutableArray array];

    for (LsBaseConfigureModel *model in self.catgs) {
        NSString *ID   = model.id_;
        NSString *key  = [NSString stringWithFormat:@"scatgs-%@",ID];
        NSArray  *arr  = [[dict objectForKey:@"data"] objectForKey:key];
        for(NSDictionary *dict  in arr) {
            LsBaseConfigureModel *modelll =[[LsBaseConfigureModel alloc]init];
            modelll.id_                   =[dict objectForKey:@"id"];
            modelll.name                  =[dict objectForKey:@"name"];
            modelll.code                  =[dict objectForKey:@"code"];
            modelll.level                 =[dict objectForKey:@"level"];
            
            for (LsBaseConfigureModel *model in self.levels) {
                if ([model.code isEqualToString:modelll.level]) {
                    [model.subjectArray addObject:modelll];
                }
            }
        }
    }
    
    [self.allSubject addObject:kdSubject];
    [self.allSubject addObject:eleSubject];
    [self.allSubject addObject:midSubject];
    [self.allSubject addObject:hmdSubject];
}


@end
