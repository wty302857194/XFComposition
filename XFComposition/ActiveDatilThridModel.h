//
//  ActiveDatilThridModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActiveDatilThridModel : NSObject
@property(nonatomic,strong)NSString *allcount;
@property(nonatomic,strong)NSArray *childsecond;
@property(nonatomic,strong)NSString *thridid;
@property(nonatomic,strong)NSString *isParent;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *rukucount;
+(id)loadWithJSOn:(NSDictionary *)json;
@end
