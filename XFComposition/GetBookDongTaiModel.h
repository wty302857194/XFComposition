//
//  GetBookDongTaiModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetBookDongTaiModel : NSObject
@property (nonatomic,strong)NSString *addtime;
@property (nonatomic,strong)NSString *bookid;
@property (nonatomic,strong)NSString *bookname;
@property (nonatomic,strong)NSString *deptname;
@property (nonatomic,strong)NSString *dongtaiid;
@property (nonatomic,strong)NSString *pages;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *username;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
