
//
//  GetMyActiveWorkListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetMyActiveWorkListModel.h"

@implementation GetMyActiveWorkListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.ActiveItemName = dic[@"ActiveItemName"];
        self.AddTime = dic[@"AddTime"];
        self.BlogTitle = dic[@"BlogTitle"];
        self.IsCheck = dic[@"IsCheck"];
        self.IsDx = dic[@"IsDx"];
        self.SocreInfo = dic[@"SocreInfo"];
        self.WorkID = dic[@"WorkID"];
        self.WriteCheckStatic = dic[@"WriteCheckStatic"];
        self.WriteUserName = dic[@"WriteUserName"];
        
    }
    return self;
}

@end
