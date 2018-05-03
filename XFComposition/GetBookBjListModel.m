//
//  GetBookBjListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetBookBjListModel.h"

@implementation GetBookBjListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.addtime = dic[@"addtime"];
        self.bookid = dic[@"bookid"];
        self.bookname = dic[@"bookname"];
        self.bookpic = dic[@"bookpic"];
        self.deptname = dic[@"deptname"];
        self.bookId = dic[@"id"];
        self.istuijian = dic[@"istuijian"];
        self.pages = dic[@"pages"];
        self.bjstatic = dic[@"static"];
        self.title = dic[@"title"];
        self.username = dic[@"username"];
        
    }
    return self;
}

@end
