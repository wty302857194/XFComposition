//
//  GetBookBjModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetBookBjModel : NSObject
@property (nonatomic,strong)NSString *addtime;
@property (nonatomic,strong)NSString *bookid;
@property (nonatomic,strong)NSString *bookname;
@property (nonatomic,strong)NSString *bookpic;
@property (nonatomic,strong)NSString *deptname;
@property (nonatomic,strong)NSString *bookId;
@property (nonatomic,strong)NSString *pages;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *username;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
