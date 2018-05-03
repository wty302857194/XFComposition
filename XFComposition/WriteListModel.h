//
//  WriteListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WriteListModel : NSObject
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *MicroclassInfoAbstract;
@property (nonatomic,strong)NSString *MicroclassInfoAddTime;
@property (nonatomic,strong)NSString *MicroclassInfoAttr;
@property (nonatomic,strong)NSString *MicroclassInfoAttr1;
@property (nonatomic,strong)NSString *MicroclassInfoEndTime;
@property (nonatomic,strong)NSString *MicroclassInfoIsRecommend;
@property (nonatomic,strong)NSString *MicroclassInfoMaster;
@property (nonatomic,strong)NSString *MicroclassInfoObject;
@property (nonatomic,strong)NSString *MicroclassInfoStartTime;
@property (nonatomic,strong)NSString *MicroclassInfoStatic;
@property (nonatomic,strong)NSString *MicroclassInfoTarget;
@property (nonatomic,strong)NSString *MicroclassInfoTitle;
@property (nonatomic,strong)NSString *VideoNum;
//@property (nonatomic,strong)NSArray *MicroclassInfoTarget;




+(id)loadWithJSOn:(NSDictionary *)json;
@end
