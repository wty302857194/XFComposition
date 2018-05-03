//
//  GetBookInfoModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetBookInfoModel : NSObject
@property (nonatomic,strong)NSString *BookBuyAddress;
@property (nonatomic,strong)NSString *BookMyMaxPage;
@property (nonatomic,strong)NSArray *BookMyTag;
@property (nonatomic,strong)NSString *BookPrice;
@property (nonatomic,strong)NSString *bookauthor;
@property (nonatomic,strong)NSString *bookinfo;
@property (nonatomic,strong)NSString *bookname;
@property (nonatomic,strong)NSString *bookpages;
@property (nonatomic,strong)NSString *bookpic;
@property (nonatomic,strong)NSString *bookpublish;
@property (nonatomic,strong)NSString *currentread;
@property (nonatomic,strong)NSString *finishread;
@property (nonatomic,strong)NSString *isdaodu;
@property (nonatomic,strong)NSString *wandread;
+(id)loadWithJSOn:(NSDictionary *)json;
@end
