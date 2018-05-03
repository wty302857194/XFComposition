//
//  DianPingModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DianPingModel : NSObject
@property (nonatomic,strong)NSString *activename;
@property (nonatomic,strong)NSString *checkname;
@property (nonatomic,strong)NSString *checktime;
@property (nonatomic,strong)NSString *grade;
@property (nonatomic,strong)NSString *DPid;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *username;




+(id)loadWithJSOn:(NSDictionary *)json;
@end
