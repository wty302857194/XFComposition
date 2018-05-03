//
//  MicPianduanmodel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MicPianduanmodel : NSObject
@property(nonatomic,strong)NSString *BlogAddTime;
@property(nonatomic,strong)NSString *BlogAttr1;
@property(nonatomic,strong)NSString *BlogAttr2;
@property(nonatomic,strong)NSString *BlogAttr3;//id
@property(nonatomic,strong)NSString *BlogBg;
@property(nonatomic,strong)NSString *BlogContent;
@property(nonatomic,strong)NSString *BlogGoodTimes;
@property(nonatomic,strong)NSString *BlogIsHost;
@property(nonatomic,strong)NSString *BlogIsTuijian;
@property(nonatomic,strong)NSString *BlogStatic;
@property(nonatomic,strong)NSString *BlogTitle;
@property(nonatomic,strong)NSString *BlogTopPic;
@property(nonatomic,strong)NSString *BlogTypeID;
@property(nonatomic,strong)NSString *BlogUserID;
@property(nonatomic,strong)NSString *BlogViewTimes;
@property(nonatomic,strong)NSString *GradeName;
@property(nonatomic,strong)NSString *ID;




@end

@interface XFPageInfo : NSObject

@property (strong, nonatomic) NSMutableArray *x_Userblogs;
@end

@interface XFMicDataInfo : NSObject

@property (assign, nonatomic) NSInteger allCount;
@property (strong, nonatomic) XFPageInfo *pageInfo;

@end

@interface XFMicData : XFBaseModel

@property (strong, nonatomic) XFMicDataInfo *ret_data;
@end


