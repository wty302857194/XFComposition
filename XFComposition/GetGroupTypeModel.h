//
//  GetGroupTypeModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/23.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetGroupTypeModel : NSObject
@property (nonatomic,assign)NSInteger Typeid;
@property (nonatomic,strong)NSString *name;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
