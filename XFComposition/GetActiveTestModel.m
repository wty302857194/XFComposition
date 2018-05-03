//
//  GetActiveTestModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/30.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetActiveTestModel.h"

@implementation GetActiveTestModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        
        //        self.SinCSb = dic[@"SinCSb"];
        //        self.MuiCSb = dic[@"MuiCSb"];
        //        self.PDSb = dic[@"PDSb"];
        //        self.TKSb = dic[@"TKSb"];
        //        self.WDSb = dic[@"WDSb"];
        self.ItemID = dic[@"ItemID"];
        self.ItemInfo = dic[@"ItemInfo"];
    }
    return self;
}
@end
