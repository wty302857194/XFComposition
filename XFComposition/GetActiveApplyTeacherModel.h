//
//  GetActiveApplyTeacherModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetActiveApplyTeacherModel : NSObject
@property (nonatomic,strong)NSString *activeid;
@property (nonatomic,strong)NSString *jinji;
@property (nonatomic,strong)NSString *teacherStartNum;
@property (nonatomic,strong)NSString *teacherclassfirst;
@property (nonatomic,strong)NSString *teacherfreetime;
@property (nonatomic,strong)NSString *teacherid;
@property (nonatomic,strong)NSString *teacherischeck;
@property (nonatomic,strong)NSString *teachermaxnum;
@property (nonatomic,strong)NSString *teachername;
@property (nonatomic,strong)NSString *teacherphone;
@property (nonatomic,strong)NSString *teacherpic;
@property (nonatomic,strong)NSString *teacherschool;

+(id)loadWithJSOn:(NSDictionary *)json;

@end
