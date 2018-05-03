//
//  CommwritelistModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "CommwritelistModel.h"

@implementation CommwritelistModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.BlogAddTime = dic[@"BlogAddTime"];
        self.BlogAttr1 = dic[@"BlogAttr1"];
        self.BlogContent = dic[@"BlogContent"];
        self.BlogGoodTimes = dic[@"BlogGoodTimes"];
        self.BlogImg = dic[@"BlogImg"];
        self.BlogIsHost = dic[@"BlogIsHost"];
        self.BlogIsTuijian = dic[@"BlogIsTuijian"];
        self.BlogStatic = dic[@"BlogStatic"];
        self.BlogTitle = dic[@"BlogTitle"];
        self.BlogTypeID = [dic[@"BlogTypeID"] integerValue];
        self.BlogUserID = [dic[@"BlogUserID"] integerValue];
        self.BlogViewTimes = [dic[@"BlogViewTimes"] integerValue];
        self.GradeName = dic[@"GradeName"];
        self.ID = dic[@"ID"];
        
        self.PyNum = dic[@"PyNum"];
        self.UserName = dic[@"UserName"];
        self.UserPic = dic[@"UserPic"];
        
        self.labels = dic[@"labels"];
        
    }
    return self;
}

@end
@implementation CommPageinfo

+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"pageInfo":@"CommwritelistModel"
             };

}

@end

@implementation CommDataInfo



@end

@implementation CommData



@end
