//
//  GetDajiaListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/3.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDajiaListModel : NSObject
@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *Author;
@property(nonatomic,strong)NSString *Click;
@property(nonatomic,strong)NSString *CommentNum;
@property(nonatomic,strong)NSString *ID;

@property(nonatomic,strong)NSString *NewsTitle;
@property(nonatomic,strong)NSString *NewsType;
@property(nonatomic,strong)NSString *PicURL;

@property(nonatomic,strong)NSString *NewsContent;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
