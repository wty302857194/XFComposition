//
//  CommwritelistModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommwritelistModel : NSObject
@property (nonatomic,strong)NSString *BlogAddTime;
@property (nonatomic,strong)NSString *BlogAttr1;
@property (nonatomic,strong)NSString *BlogContent;
@property (nonatomic,strong)NSString *BlogGoodTimes;
@property (nonatomic,strong)NSArray *BlogImg;
@property (nonatomic,strong)NSString *BlogIsHost;
@property (nonatomic,strong)NSString *BlogIsTuijian;
@property (nonatomic,strong)NSString *BlogStatic;
@property (nonatomic,strong)NSString *BlogTitle;
@property (nonatomic,assign)NSInteger BlogTypeID;
@property (nonatomic,assign)NSInteger BlogUserID;
@property (nonatomic,assign)NSInteger BlogViewTimes;

@property (nonatomic,strong)NSString *GradeName;

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *PyNum;
@property (nonatomic,strong)NSString *UserName;
@property (nonatomic,strong)NSString *UserPic;
@property (nonatomic,strong)NSString *labels;

+(id)loadWithJSOn:(NSDictionary *)json;
@end

@interface CommPageinfo : NSObject
@property (nonatomic,strong)NSMutableArray *comm_Blog;

@end

@interface CommDataInfo : NSObject
@property (nonatomic,assign)NSInteger allCount;
@property (nonatomic,strong)NSMutableArray *pageInfo;

@end

@interface CommData : XFBaseModel
@property (nonatomic,strong)CommDataInfo *ret_data;
@end

