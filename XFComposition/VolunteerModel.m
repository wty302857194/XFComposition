//
//  VolunteerModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "VolunteerModel.h"

@implementation VolunteerModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.activeAppmin = dic[@"activeAppmin"];
        self.activeLimit = dic[@"activeLimit"];
        self.activeendtime = dic[@"activeendtime"];
        self.activeid = dic[@"activeid"];
        self.activeinfo = dic[@"activeinfo"];
        self.activename = dic[@"activename"];
        self.activepic = dic[@"activepic"];
        self.activestarttime = dic[@"activestarttime"];
        self.activetype = dic[@"activetype"];
        self.itemlist = dic[@"itemlist"];
        
        
    }
    return self;
}

@end



@implementation VolunteerNewsListModel

@end
