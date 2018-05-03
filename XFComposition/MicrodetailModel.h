//
//  MicrodetailModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MicrodetailModel : NSObject
@property(nonatomic,strong)NSString *classEndTime;
@property(nonatomic,strong)NSString *classFavTime;
@property(nonatomic,strong)NSString *classInfo;
@property(nonatomic,strong)NSString *classJoinTime;//id
@property(nonatomic,strong)NSString *classKeyWord;
@property(nonatomic,strong)NSString *classMarket;
@property(nonatomic,strong)NSString *classMaster;
@property(nonatomic,strong)NSString *classMasterId;
@property(nonatomic,strong)NSString *className;
@property(nonatomic,strong)NSString *classObject;
@property(nonatomic,strong)NSString *classOrderId;
@property(nonatomic,strong)NSString *classPicPath;
@property(nonatomic,strong)NSString *classRootId;
@property(nonatomic,strong)NSString *classShareTime;
@property(nonatomic,strong)NSString *classStartTime;
@property(nonatomic,strong)NSString *classStatic;
@property(nonatomic,strong)NSString *classSubjectId;
@property(nonatomic,strong)NSString *classTarget;
@property(nonatomic,strong)NSString *classViewTime;
@property(nonatomic,strong)NSString *reCommend;

@property(nonatomic,strong)NSArray *videoList;
@property(nonatomic,strong)NSArray *writelist;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
