//
//  MyPageListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyPageListModel : NSObject
@property (nonatomic,assign)NSInteger BookActiveID;
@property (nonatomic,assign)NSInteger ID;
@property (nonatomic,assign)NSInteger PageAllScore;
@property (nonatomic,strong)NSString *PageTitle;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
