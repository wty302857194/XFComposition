//
//  GetMyActiveWorkListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMyActiveWorkListModel : NSObject
@property (nonatomic,strong)NSString *ActiveItemName;
@property (nonatomic,strong)NSString *AddTime;
@property (nonatomic,strong)NSString *BlogTitle;
@property (nonatomic,strong)NSString *IsCheck;
@property (nonatomic,strong)NSString *IsDx;
@property (nonatomic,strong)NSString *SocreInfo;
@property (nonatomic,strong)NSString *WorkID;
@property (nonatomic,strong)NSString *WriteCheckStatic;
@property (nonatomic,strong)NSString *WriteUserName;



+(id)loadWithJSOn:(NSDictionary *)json;
@end
