//
//  VolunteerModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VolunteerModel : NSObject
@property (nonatomic,strong)NSString *activeAppmin;
@property (nonatomic,strong)NSString *activeLimit;
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

@interface VolunteerNewsListModel : NSObject

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *AddTime;
@property (nonatomic,strong)NSString *Click;
@property (nonatomic,strong)NSString *NewContent;
@property (nonatomic,strong)NSString *PicURL;
@property (nonatomic,strong)NSString *NewsTitle;
@end
