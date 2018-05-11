//
//  CommentInfo.h
//  XFComposition
//
//  Created by qiannian on 2018/5/10.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "FMBean.h"

@interface CommentInfo : FMBean
@property (nonatomic,copy)NSString *CommentsInfo;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *UserID;
@property (nonatomic,copy)NSString *UserType;
@property (nonatomic,copy)NSString *Addtime;
@property (nonatomic,copy)NSString *CommentsScore;
@property (nonatomic,copy)NSString *CommentsStatic;
@property (nonatomic,copy)NSString *CommentsAttribute1;// 习作
@property (nonatomic,copy)NSString *CommentsAttribute2;//总评

@end
