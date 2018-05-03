//
//  GetBookPaihangModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetBookPaihangModel : NSObject
@property (nonatomic,strong)NSString *bookname;
@property (nonatomic,strong)NSString *bookpaihangid;
@property (nonatomic,strong)NSString *readnum;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
