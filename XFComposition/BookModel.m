//
//  BookModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookModel.h"

@implementation BookModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.BookAddTime = dic[@"BookAddTime"];
        self.BookAttirbute1 = dic[@"BookAttirbute1"];
        self.BookAuthor = dic[@"BookAuthor"];
        self.BookBuyAddress = dic[@"BookBuyAddress"];
        self.BookIntroduction = dic[@"BookIntroduction"];
        self.BookName = dic[@"BookName"];
        self.BookPic = dic[@"BookPic"];
        self.BookPublic = dic[@"BookPublic"];
        self.BookStatic = dic[@"BookStatic"];
        self.ID = dic[@"ID"];
        self.UserName = dic[@"UserName"];
        self.textTime = dic[@"textTime"];
        self.Booktypename = dic[@"typename"];
        
        
    }
    return self;
}

@end
