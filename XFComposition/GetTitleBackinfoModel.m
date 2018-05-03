//
//  GetTitleBackinfoModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetTitleBackinfoModel.h"

@implementation GetTitleBackinfoModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.AddTime = dic[@"AddTime"];
        self.CommentInfo = dic[@"CommentInfo"];
        self.UserID = dic[@"UserID"];
        self.UserName = dic[@"UserName"];
        self.UserPic = dic[@"UserPic"];
        self.backid = dic[@"id"];
    }
    return self;
}
@end
