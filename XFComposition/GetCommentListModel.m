//
//  GetCommentListModel.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "GetCommentListModel.h"

@implementation GetCommentListModel
+(id)loadWithJSOn:(NSDictionary *)json{
    return [[self alloc]initWithJSON:json];
    
}
-(id)initWithJSON:(NSDictionary *)dic{
    if (self = [super init]) {
        self.CID = dic[@"CID"];
        
        self.C_Content= dic[@"C_Content"] ;
        self.C_Intime = dic[@"C_Intime"];
        self.C_PkId = dic[@"C_PkId"];
        self.C_Status = dic[@"C_Status"];
        self.C_UserId = dic[@"C_UserId"];
        self.C_UserIp = dic[@"C_UserIp"];
        self.UserName = dic[@"UserName"];
        self.UserPic =dic[@"UserPic"];
    
    }
    return self;
}

@end
