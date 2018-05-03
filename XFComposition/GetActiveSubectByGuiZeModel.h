//
//  GetActiveSubectByGuiZeModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/26.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetActiveSubectByGuiZeModel : NSObject
@property (nonatomic,assign)NSInteger allCount;
@property (nonatomic,assign)NSInteger allSocre;
@property (nonatomic,assign)NSInteger danxuanNum;
@property (nonatomic,assign)NSInteger duoxuanNum;
@property (nonatomic,strong)NSString *ids;
@property (nonatomic,assign)NSInteger panduanNum;
@property (nonatomic,assign)NSInteger tiankongNum;
@property (nonatomic,assign)NSInteger wendaNum;
+(id)loadWithJSOn:(NSDictionary *)json;
@end
