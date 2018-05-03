//
//  MicroClassTypeModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MicroClassTypeModel : NSObject
@property (nonatomic,strong)NSArray *childgrade;
@property (nonatomic,strong)NSString *tizainame;
@property (nonatomic,strong)NSString *zaitiid;

@end


@interface ChildgradeModel : NSObject
@property (nonatomic,strong)NSString *gradename;
@property (nonatomic,strong)NSString *gid;

@end
