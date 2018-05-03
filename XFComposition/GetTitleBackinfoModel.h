//
//  GetTitleBackinfoModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetTitleBackinfoModel.h"
@interface GetTitleBackinfoModel : NSObject

@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *CommentInfo;
@property(nonatomic,strong)NSString *UserID;
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *UserPic;

@property(nonatomic,strong)NSString *backid;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
