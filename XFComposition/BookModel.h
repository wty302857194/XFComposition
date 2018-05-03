//
//  BookModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/5.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookModel : NSObject
@property (nonatomic,strong)NSString *BookAddTime;
@property (nonatomic,strong)NSString *BookAttirbute1;
@property (nonatomic,strong)NSString *BookAuthor;
@property (nonatomic,strong)NSString *BookBuyAddress;
@property (nonatomic,strong)NSString *BookIntroduction;
@property (nonatomic,strong)NSString *BookName;
@property (nonatomic,strong)NSString *BookPic;
@property (nonatomic,strong)NSString *BookPublic;
@property (nonatomic,strong)NSString *BookStatic;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *UserName;
@property (nonatomic,strong)NSArray *textTime;
@property (nonatomic,strong)NSArray *Booktypename;



+(id)loadWithJSOn:(NSDictionary *)json;

@end
