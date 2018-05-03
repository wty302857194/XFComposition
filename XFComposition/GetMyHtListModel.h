//
//  GetMyHtListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMyHtListModel : NSObject
@property(nonatomic,strong)NSString *ActionId;
@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *ContentInfo;
@property(nonatomic,strong)NSString *Id;
@property(nonatomic,strong)NSString *ObjectID;
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *UserPic;
@property(nonatomic,strong)NSString *isTop;
@property(nonatomic,strong)NSString *isTuiJian;
@property(nonatomic,assign)NSInteger plNum;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *viewNum;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
