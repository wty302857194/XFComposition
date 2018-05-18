//
//  GetWritePicRemarkModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetWritePicRemarkModel.h"

@implementation GetWritePicRemarkModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.CreateTime = dic[@"CreateTime"];
        self.ID = dic[@"ID"];
        self.PicID = dic[@"PicID"];
        self.Remark = dic[@"Remark"];
        self.Sort = dic[@"Sort"];
        self.UserID = dic[@"UserID"];
        self.XLocation = dic[@"XLocation"];
        self.YLocation = dic[@"YLocation"];

    }
    return self;
}


@end
@implementation GetWriteAudioModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.CreateTime = dic[@"CreateTime"];
        self.ID = dic[@"ID"];
        self.PicID = dic[@"PicID"];
        self.BlogID = dic[@"BlogID"];
        self.Sort = dic[@"Sort"];
        self.UserID = dic[@"UserID"];
        self.AudioUrl = dic[@"AudioUrl"];
        self.XLocation = dic[@"XLocation"];
        self.YLocation = dic[@"YLocation"];
        
    }
    return self;
}


@end
