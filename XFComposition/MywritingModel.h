//
//  MywritingModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/27.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MywritingModel : NSObject
@property (nonatomic,strong)NSString *BlogAddTime;
@property (nonatomic,strong)NSString *BlogAttr1;
@property (nonatomic,strong)NSString *BlogContent;
@property (nonatomic,strong)NSString *BlogGoodTimes;
@property (nonatomic,strong)NSArray *BlogImg;
@property (nonatomic,strong)NSString *BlogIsHost;
@property (nonatomic,strong)NSString *BlogIsTuijian;
@property (nonatomic,strong)NSString *BlogStatic;
@property (nonatomic,strong)NSString *BlogTitle;

@property (nonatomic,strong)NSArray *BlogTypeID;
@property (nonatomic,strong)NSString *BlogUserID;
@property (nonatomic,strong)NSString *BlogViewTimes;
@property (nonatomic,strong)NSString *GradeName;
@property (nonatomic,assign)NSInteger ID;

@property (nonatomic,strong)NSString *PyNum;
@property (nonatomic,strong)NSString *UserName;
@property (nonatomic,strong)NSString *UserPic;
@property (nonatomic,strong)NSString *labels;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
