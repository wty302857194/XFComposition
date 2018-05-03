//
//  GetTeacherNeedActiveModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTeacherNeedActiveModel : NSObject
@property (nonatomic,strong)NSString *ActiveAttribute1;
@property (nonatomic,strong)NSString *ActiveEndTime;
@property (nonatomic,strong)NSString *ActiveInfo;
@property (nonatomic,strong)NSString *ActiveName;
@property (nonatomic,strong)NSString *ActiveOrderID;
@property (nonatomic,strong)NSString *ActivePic;
@property (nonatomic,strong)NSString *ActiveStartTime;
@property (nonatomic,strong)NSString *ActiveTypeID;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *UserName;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
