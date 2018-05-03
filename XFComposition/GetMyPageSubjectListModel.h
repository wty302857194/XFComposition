//
//  GetMyPageSubjectListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/18.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMyPageSubjectListModel : NSObject
@property (nonatomic,strong)NSString *SubjectAddTime;
@property (nonatomic,strong)NSString *SubjectID;
@property (nonatomic,strong)NSString *SubjectSocre;
@property (nonatomic,strong)NSString *SubjectStatic;
@property (nonatomic,strong)NSString *SubjectTitle;
@property (nonatomic,assign)NSInteger SubjectType;


+(id)loadWithJSOn:(NSDictionary *)json;

@end
