//
//  GetVoletacherModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetVoletacherModel : NSObject
@property (nonatomic,strong)NSString *teacherGyNum;
@property (nonatomic,strong)NSString *teacherId;
@property (nonatomic,strong)NSString *teacherName;
@property (nonatomic,strong)NSString *teacherPic;
@property (nonatomic,strong)NSString *teacherStartNum;//星级
@property (nonatomic,strong)NSString *teacherschool;
@property (nonatomic,strong)NSString *teacherzc;



+(id)loadWithJSOn:(NSDictionary *)json;
@end
