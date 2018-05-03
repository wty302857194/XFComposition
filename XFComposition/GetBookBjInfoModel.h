//
//  GetBookBjInfoModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/14.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetBookBjInfoModel : NSObject
@property (nonatomic,strong)NSString *addtime;
@property (nonatomic,strong)NSString *BookMyMaxPage;
@property (nonatomic,strong)NSArray *bookid;
@property (nonatomic,strong)NSString *bookname;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,strong)NSString *currentpage;
@property (nonatomic,strong)NSString *BookBjid;
@property (nonatomic,strong)NSString *BookBjstatic;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *tuijian;
@property (nonatomic,strong)NSString *userid;
@property (nonatomic,strong)NSString *username;
@property (nonatomic,strong)NSString *userpic;
@property (nonatomic,strong)NSString *viewtimes;
+(id)loadWithJSOn:(NSDictionary *)json;
@end
