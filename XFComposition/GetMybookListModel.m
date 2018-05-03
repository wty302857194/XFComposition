//
//  GetMybookListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetMybookListModel.h"

@implementation GetMybookListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.BookAddTime = dic[@"BookAddTime"];
        self.BookAuthor = dic[@"BookAuthor"];
        self.BookName = dic[@"BookName"];
        self.BookPic = dic[@"BookPic"];
        self.BookPrice = dic[@"BookPrice"];
        self.BookStatic = dic[@"BookStatic"];
        self.ID = dic[@"ID"];
        
    }
    return self;
}


@end
