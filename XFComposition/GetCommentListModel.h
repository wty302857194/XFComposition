//
//  GetCommentListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/9.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetCommentListModel : NSObject
@property (nonatomic,strong)NSString *CID;
@property (nonatomic,strong)NSString *C_Content;
@property (nonatomic,strong)NSString *C_Intime;
@property (nonatomic,strong)NSString *C_PkId;
@property (nonatomic,strong)NSString *C_Status;
@property (nonatomic,strong)NSString *C_UserId;
@property (nonatomic,strong)NSString *C_UserIp;
@property (nonatomic,strong)NSString *UserName;
@property (nonatomic,strong)NSString *UserPic;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
