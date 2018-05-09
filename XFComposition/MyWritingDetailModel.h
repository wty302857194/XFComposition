//
//  MyWritingDetailModel.h
//  XFComposition
//
//  Created by chenshunyi on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyWritingDetailModel : NSObject

@property (nonatomic, assign) NSInteger BlogID;
@property (nonatomic, copy) NSString *CreateTime;
@property (nonatomic, copy) NSString *FixPicUrl;
@property (nonatomic, assign) NSInteger ID;
@property (nonatomic, copy) NSString *PicUrl;
@property (nonatomic, assign) NSInteger Sort;
@property (nonatomic, assign) NSInteger UserID;

-(instancetype)initWithDic:(NSDictionary *)dict;

@end
