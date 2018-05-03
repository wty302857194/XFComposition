//
//  GetActiveSubectByGuiZeModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetActiveSubectByGuiZeModel.h"

@implementation GetActiveSubectByGuiZeModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.allCount = [dic[@"allCount"] integerValue];
        self.allSocre = [dic[@"allSocre"] integerValue];
        self.danxuanNum = [dic[@"danxuanNum"] integerValue];
        self.duoxuanNum = [dic[@"duoxuanNum"] integerValue];
        self.ids = dic[@"ids"];
        self.panduanNum = [dic[@"panduanNum"] integerValue];
        self.tiankongNum = [dic[@"tiankongNum"] integerValue];
        self.wendaNum = [dic[@"wendaNum"] integerValue];

    }
    return self;
}

@end
