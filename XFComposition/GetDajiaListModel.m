//
//  GetDajiaListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetDajiaListModel.h"

@implementation GetDajiaListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.AddTime = dic[@"AddTime"];
        self.Author = dic[@"Author"];
        self.Click = dic[@"Click"];
        self.CommentNum = dic[@"CommentNum"];
        self.ID = dic[@"ID"];
        self.NewsTitle = dic[@"NewsTitle"];
        
        self.NewsType = dic[@"NewsType"];
        self.PicURL = dic[@"PicURL"];
        self.NewsContent = dic[@"newContent"];
    }
    return self;
}
@end
