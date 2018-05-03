//
//  GetMessageListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetMessageListModel.h"

@implementation GetMessageListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.DateTime = dic[@"DateTime"];
        self.ID = dic[@"ID"];
        self.MesType = dic[@"MesType"];
        self.ReadFlag = dic[@"ReadFlag"];
        self.Title = dic[@"Title"];
        
    }
    return self;
}

@end
