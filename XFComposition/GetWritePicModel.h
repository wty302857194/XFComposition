//
//  GetWritePicModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetWritePicModel : FMBean
@property (nonatomic,copy)NSString *BlogID;
@property (nonatomic,copy)NSString *CreateTime;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *PicUrl;
@property (nonatomic,copy)NSString *Sort;
@property (nonatomic,copy)NSString *UserID;
@property (nonatomic,copy)NSString *FixPicUrl;
@property (nonatomic,copy)NSString *PicID;
@property (nonatomic,copy)NSString *CheckUserID;
+(id)loadWithJSOn:(NSDictionary *)json;

@end
