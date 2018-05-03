//
//  GetBookInfoModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetBookInfoModel.h"

@implementation GetBookInfoModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.BookBuyAddress = dic[@"BookBuyAddress"];
        self.BookMyMaxPage = dic[@"BookMyMaxPage"];
        self.BookMyTag = dic[@"BookMyTag"];
        self.bookpic = dic[@"bookpic"];
        self.BookPrice = dic[@"BookPrice"];
        self.bookauthor = dic[@"bookauthor"];
        self.bookinfo = dic[@"bookinfo"];
        self.bookname = dic[@"bookname"];
        self.bookpages = dic[@"bookpages"];
        
        self.bookpic = dic[@"bookpic"];
        self.bookpublish = dic[@"bookpublish"];
        self.currentread = dic[@"currentread"];
        self.finishread = dic[@"finishread"];
        self.isdaodu = dic[@"isdaodu"];
        self.wandread = dic[@"wandread"];

        
    }
    return self;
}

@end
