//
//  UpCompositionModel.h
//  XFComposition
//
//  Created by wbb on 2018/4/20.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpCompositionModel : NSObject

@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *MicroclassInfoAbstract;

@property (nonatomic,copy) NSString *MicroclassInfoAddTime;
@property (nonatomic,copy) NSString *MicroclassInfoAttr;
@property (nonatomic,copy) NSString *MicroclassInfoAttr1;
@property (nonatomic,copy) NSString *MicroclassInfoEndTime;
@property (nonatomic,copy) NSString *MicroclassInfoIsRecommend;
@property (nonatomic,copy) NSString *MicroclassInfoMaster;
@property (nonatomic,copy) NSString *MicroclassInfoObject;
@property (nonatomic,copy) NSString *MicroclassInfoStartTime;
@property (nonatomic,copy) NSString *MicroclassInfoStatic;
@property (nonatomic,copy) NSString *MicroclassInfoTarget;
@property (nonatomic,copy) NSString *MicroclassInfoTitle;
@property (nonatomic,copy) NSString *VideoNum;
@property (nonatomic,copy) NSString *classJoinTime;

@property (nonatomic,assign) BOOL isWeiKe;
@end
