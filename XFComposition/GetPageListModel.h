//
//  GetPageListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetPageListModel : NSObject
@property (nonatomic,strong)NSString *Attribute1;
@property (nonatomic,strong)NSString *Attribute2;
@property (nonatomic,strong)NSString *TestTempID;
@property (nonatomic,strong)NSString *addtime;
@property (nonatomic,strong)NSString *allsocre;
@property (nonatomic,strong)NSString *oksocre;
@property (nonatomic,strong)NSString *pageid;
@property (nonatomic,strong)NSString *testOkSocre;

+(id)loadWithJSOn:(NSDictionary *)json;

@end
