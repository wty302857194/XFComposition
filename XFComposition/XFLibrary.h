//
//  XFLibrary.h
//  XFComposition
//
//  Created by qiannian on 2018/5/16.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "FMBean.h"

@interface XFLibrary : FMBean
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *PicID;
@property (nonatomic,copy)NSString *BlogID;
@property (nonatomic,copy)NSString *UserID;
@property (nonatomic,copy)NSString *ExtractType;
@property (nonatomic,copy)NSString *ExtractPicUrl;
@property (nonatomic,copy)NSString *ExtractContent;// 习作
@property (nonatomic,copy)NSString *CreateTime;//总评
@end
