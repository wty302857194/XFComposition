//
//  GetTitleCommentModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/11/1.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetTitleCommentModel : NSObject
@property(nonatomic,strong)NSString *AddTime;
@property(nonatomic,strong)NSString *CommentInfo;
@property(nonatomic,strong)NSString *UserID;
@property(nonatomic,strong)NSString *UserName;
@property(nonatomic,strong)NSString *UserPic;
@property(nonatomic,strong)NSArray *backInfo;
@property(nonatomic,strong)NSString *backNum;
@property(nonatomic,strong)NSString *commentid;


+(id)loadWithJSOn:(NSDictionary *)json;
@end
