//
//  MicroClassGradeModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MicroClassGradeModel : NSObject
@property (nonatomic,strong)NSString *gid;
@property (nonatomic,strong)NSString *gradename;






+(id)loadWithJSOn:(NSDictionary *)json;
@end
