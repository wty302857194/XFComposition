//
//  MicroVideoModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicroVideoModel.h"

@implementation MicroVideoModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        
        self.filepath = dic[@"filepath"];
        self.guid = dic[@"guid"];
        self.videoId = dic[@"id"];
        self.orderid = dic[@"orderid"];
        self.picpath = dic[@"picpath"];
        self.playlength = dic[@"playlength"];
        self.title = dic[@"title"];
        self.viewtime = dic[@"viewtime"];
        self.MicroclassItemMp4Path = dic[@"MicroclassItemMp4Path"];
    }
    return self;
}


@end
