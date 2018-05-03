//
//  haocihaojumodel.h
//  XFComposition
//
//  Created by longrise on 2018/3/24.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface haocihaojumodel : NSObject

@property (nonatomic,strong)NSString *info;
@property (nonatomic,strong)NSString *byusername;
@property (nonatomic,strong)NSString *commentinfo;
@property (nonatomic,strong)NSString *blogid;
@property (nonatomic,strong)NSString *addtime;
//@property (nonatomic,strong)NSString *activeid;
//@property (nonatomic,strong)NSString *activeinfo;
//@property (nonatomic,strong)NSString *activename;
//@property (nonatomic,strong)NSString *activepic;
//@property (nonatomic,strong)NSString *activestarttime;
//@property (nonatomic,strong)NSString *activetype;
//@property (nonatomic,strong)NSArray *itemlist;




+(id)loadWithJSOn:(NSDictionary *)json;

@end
