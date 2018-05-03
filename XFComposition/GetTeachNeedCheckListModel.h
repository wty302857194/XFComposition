//
//  GetTeachNeedCheckListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTeachNeedCheckListModel : NSObject
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *IsCheck;
@property (nonatomic,strong)NSString *Isback;
@property (nonatomic,strong)NSString *ScoreInfo;
@property (nonatomic,strong)NSString *WorkId;
@property (nonatomic,strong)NSString *WorkName;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
