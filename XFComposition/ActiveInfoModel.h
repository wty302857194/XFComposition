//
//  ActiveInfoModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/4.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActiveInfoModel : NSObject
@property (nonatomic,strong)NSString *activeAppmin;
@property (nonatomic,strong)NSString *activeLimit;
@property (nonatomic,strong)NSString *activePast;
@property (nonatomic,strong)NSString *activePost;
@property (nonatomic,strong)NSString *activeendtime;
@property (nonatomic,strong)NSString *activeid;
@property (nonatomic,strong)NSString *activeinfo;
@property (nonatomic,strong)NSString *activename;
@property (nonatomic,strong)NSString *activepic;
@property (nonatomic,strong)NSString *activestarttime;
@property (nonatomic,strong)NSString *activetype;
@property (nonatomic,strong)NSArray *itemlist;




+(id)loadWithJSOn:(NSDictionary *)json;
@end
