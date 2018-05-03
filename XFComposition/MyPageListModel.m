//
//  MyPageListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyPageListModel.h"

@implementation MyPageListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.BookActiveID = [dic[@"BookActiveID"] integerValue];
        self.ID = [dic[@"ID"] integerValue];
        self.PageAllScore = [dic[@"PageAllScore"] integerValue];
        self.PageTitle = dic[@"PageTitle"];
        
    }
    return self;
}

@end
