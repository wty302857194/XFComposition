//
//  GetLabelTypeTreelistAllModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/8.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetLabelTypeTreelistAllModel : NSObject
@property(nonatomic,strong)NSArray *childfirst;
@property(nonatomic,strong)NSString *treeid;
@property(nonatomic,strong)NSArray *isParent;

@property(nonatomic,strong)NSString *name;




+(id)loadWithJSOn:(NSDictionary *)json;
@end
