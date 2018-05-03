//
//  GetActivePageModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/31.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetActivePageModel : NSObject
@property (nonatomic,strong)NSString *BookName;
@property (nonatomic,strong)NSArray *SinCSb;
@property (nonatomic,strong)NSArray *MuiCSb;
@property (nonatomic,strong)NSArray *PDSb;
@property (nonatomic,strong)NSArray *TKSb;
@property (nonatomic,strong)NSArray *WDSb;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
