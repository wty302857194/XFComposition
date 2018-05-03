//
//  GetActiveTestModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/30.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetActiveTestModel : NSObject
@property (nonatomic,strong)NSString *ItemID;

@property (nonatomic,strong)NSString *ItemInfo;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
