//
//  GetMybookListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/16.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMybookListModel : NSObject
@property (nonatomic,strong)NSString *BookAddTime;
@property (nonatomic,strong)NSString *BookAuthor;
@property (nonatomic,strong)NSString *BookName;
@property (nonatomic,strong)NSString *BookPic;
@property (nonatomic,strong)NSString *BookPrice;
@property (nonatomic,strong)NSString *BookStatic;
@property (nonatomic,strong)NSString *ID;



+(id)loadWithJSOn:(NSDictionary *)json;
@end
