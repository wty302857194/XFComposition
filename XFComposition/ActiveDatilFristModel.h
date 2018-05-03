//
//  ActiveDatilFristModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActiveDatilFristModel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *IsChooseTeacher;
@property(nonatomic,strong)NSString *activeEndTime;
@property(nonatomic,strong)NSString *activeInfo;
@property(nonatomic,strong)NSString *activeLimite;

@property(nonatomic,strong)NSString *activeMin;
@property(nonatomic,strong)NSString *activeName;
@property(nonatomic,strong)NSArray *activeNav;

@property(nonatomic,strong)NSString *activeNum;
@property(nonatomic,strong)NSString *activePic;
@property(nonatomic,strong)NSString *activeStartTime;
@property(nonatomic,strong)NSArray *activeType;



+(id)loadWithJSOn:(NSDictionary *)json;
@end
