//
//  LsConfigureModel.m
//  lss
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 lss. All rights reserved.
//

#import "LsConfigureModel.h"

@implementation LsCatgConfigureModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"     : @"id"};
}

@end

@implementation LsLevelConfigureModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"     : @"id"};
}

@end

@implementation LsSubjectConfigureModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"     : @"id"};
}

@end

@implementation LsBranchConfigureModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"id_"     : @"id"};
}

@end





@implementation LsConfigureModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"levels"  : @"data.levels",
             @"catgs"   : @"data.catgs",
             @"branchs" : @"data.branchs"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"levels"  : [LsLevelConfigureModel class],
             @"catgs"   : [LsCatgConfigureModel class],
             @"branchs" : [LsBranchConfigureModel class]};
}

-(void)fromDict:(NSDictionary *)dict{
    NSMutableArray *dataArray =[NSMutableArray array];
    for (int i = 0; i<self.catgs.count; i++) {
        LsCatgConfigureModel *model =[[LsCatgConfigureModel alloc] init];
        model          = self.catgs[i];
        NSString *ID   = model.id_;
        NSString *key  = [NSString stringWithFormat:@"scatgs-%@",ID];
        NSArray  *arr  = [[dict objectForKey:@"data"] objectForKey:key];
        NSMutableArray * levelsArray   = [NSMutableArray array];
        
        for (int j=0; j<self.levels.count; j++) {
            LsLevelConfigureModel *modell123 =self.levels[j];
            
            LsLevelConfigureModel *modell =[[LsLevelConfigureModel alloc] init];
            modell.level                  =key;
            modell.name                   =modell123.name;
            modell.code                   =modell123.code;
            modell.subjects               =[NSMutableArray array];
            [levelsArray addObject:modell];
            
            for(NSDictionary *dict  in arr) {
                LsSubjectConfigureModel *modelll = [LsSubjectConfigureModel yy_modelWithJSON:dict];
                if ([modelll.level isEqualToString:modell.code]) {
                    [modell.subjects addObject:modelll];
                }
            }
        }
        model.levels =levelsArray;
        [dataArray addObject:model];
    }
    self.catgs =dataArray;

    
//    for (LsCatgConfigureModel *model in self.catgs) {
//        NSString *ID   = model.id_;
//        NSString *key  = [NSString stringWithFormat:@"scatgs-%@",ID];
//        NSArray  *arr  = [[dict objectForKey:@"data"] objectForKey:key];
//        model.levels   = [NSMutableArray array];
//       
//        for (LsLevelConfigureModel *modell in self.levels) {
//            LsLevelConfigureModel *modell123 =[[LsLevelConfigureModel alloc] init];
//
//            modell123.level  =key;
//            modell123.code   =modell.code;
//            [model.levels addObject:modell];
//            modell.subjects =[NSMutableArray array];
//            for(NSDictionary *dict  in arr) {
//                LsSubjectConfigureModel *modelll = [LsSubjectConfigureModel yy_modelWithJSON:dict];
//                if ([modelll.level isEqualToString:modell.code]) {
//                    [modell.subjects addObject:modelll];
//                }
//            }
//        }
//        [model.levels addObject:model];
//    }
//    self.catgs =dataArray;
}

//-(NSMutableArray *)arrayFromDict:(id)data{
//    
//}

-(NSMutableArray *)catgs{
    if (!_catgs) {
        _catgs =[NSMutableArray array];
    }
    return _catgs;
}

@end
