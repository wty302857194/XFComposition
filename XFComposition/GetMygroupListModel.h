//
//  GetMygroupListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMygroupListModel : NSObject
@property (nonatomic,strong)NSString *GroupIcon;
@property (nonatomic,strong)NSString *GroupInfo;
@property (nonatomic,strong)NSString *GroupName;
@property (nonatomic,strong)NSString *GroupStatic;
@property (nonatomic,strong)NSString *GroupTuiJian;
@property (nonatomic,strong)NSString *Id;
@property (nonatomic,strong)NSString *IserId;
@property (nonatomic,strong)NSString *JoinNum;
@property (nonatomic,strong)NSString *TypeName;
@property (nonatomic,strong)NSString *UserName;




+(id)loadWithJSOn:(NSDictionary *)json;
@end
