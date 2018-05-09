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
@property (nonatomic,strong)NSString *BlogAttr1;//分享次数
@property (nonatomic,strong)NSString *BlogContent;
@property (nonatomic,strong)NSString *BlogGoodTimes;
@property (nonatomic,strong)NSArray *BlogImg;
@property (nonatomic,strong)NSString *BlogIsHost;//是否是热点
@property (nonatomic,strong)NSString *BlogIsTuijian;//是否是推荐
@property (nonatomic,strong)NSString *BlogStatic;//是否可编辑
@property (nonatomic,strong)NSString *BlogTitle;//文章标题

@property (nonatomic,strong)NSArray *BlogTypeID;//文章类型id
@property (nonatomic,strong)NSString *BlogUserID;//用户id
@property (nonatomic,strong)NSString *BlogViewTimes;///阅读次数
@property (nonatomic,strong)NSString *GradeName;//班级
@property (nonatomic,assign)NSInteger ID;//文章id

@property (nonatomic,strong)NSString *PyNum;
@property (nonatomic,strong)NSString *UserName;//用户名
@property (nonatomic,strong)NSString *UserPic;//用户图片
@property (nonatomic,strong)NSString *labels;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
