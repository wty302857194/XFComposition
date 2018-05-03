//
//  GetMytongjiModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMytongjiModel : NSObject
@property (nonatomic,assign)NSInteger checknum;
@property (nonatomic,assign)NSInteger successnum;
@property (nonatomic,assign)NSInteger todaynum;




+(id)loadWithJSOn:(NSDictionary *)json;
@end
