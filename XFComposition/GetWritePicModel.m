//
//  GetWritePicModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetWritePicModel.h"

@implementation GetWritePicModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.BlogID = dic[@"BlogID"];
        self.CreateTime = dic[@"CreateTime"];
        self.ID = dic[@"ID"];
        self.PicUrl = dic[@"PicUrl"];
        self.Sort = dic[@"Sort"];
        self.UserID = dic[@"UserID"];
        self.FixPicUrl = dic[@"FixPicUrl"];
    }
    return self;
}

@end
