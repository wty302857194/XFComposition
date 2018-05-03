//
//  GetBookBjInfoModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetBookBjInfoModel.h"

@implementation GetBookBjInfoModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.addtime = dic[@"addtime"];
        self.BookMyMaxPage = dic[@"BookMyMaxPage"];
        self.bookid = dic[@"bookid"];
        self.bookname = dic[@"bookname"];
        self.content = dic[@"content"];
        self.currentpage = dic[@"currentpage"];
        self.BookBjid = dic[@"id"];
        self.BookBjstatic = dic[@"static"];
        self.title = dic[@"title"];
        
        self.tuijian = dic[@"tuijian"];
        self.userid = dic[@"userid"];
        self.username = dic[@"username"];
        self.userpic = dic[@"userpic"];
        self.viewtimes = dic[@"viewtimes"];
        
        
        
    }
    return self;
}

@end
