//
//  MicroWriteModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MicroWriteModel : NSObject
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *userid;
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *writeid;
@property (nonatomic,strong)NSString *writetitle;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
