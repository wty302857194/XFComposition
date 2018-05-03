//
//  GetSubejectModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetSubejectModel : NSObject
@property (nonatomic,strong)NSString *joinnum;
@property (nonatomic,strong)NSArray *subjectnum;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
