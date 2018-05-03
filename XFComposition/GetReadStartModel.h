//
//  GetReadStartModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetReadStartModel : NSObject
@property (nonatomic,strong)NSString *conname;
@property (nonatomic,strong)NSString *readpaihangid;
@property (nonatomic,strong)NSString *num;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
