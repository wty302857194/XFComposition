//
//  GetActivePageModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetActivePageModel.h"

@implementation GetActivePageModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.BookName = dic[@"BookName"];
        self.SinCSb = dic[@"SinCSb"];
        self.MuiCSb = dic[@"MuiCSb"];
        self.PDSb = dic[@"PDSb"];
        self.TKSb = dic[@"TKSb"];
        self.WDSb = dic[@"WDSb"];
        
    }
    return self;
}
@end
