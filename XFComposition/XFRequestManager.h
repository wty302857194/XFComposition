//
//  XFRequestManager.h
//  XFComposition
//
//  Created by qiannian on 2018/5/4.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^XFResponseBlock)(NSString* requestName, id responseData , BOOL isSuccess);

#define XFReq_User_getMessageDetail    @"消息详情"
#define XFReq_User_messageLook         @"消息已读"


@interface XFRequestManager : NSObject
@property (nonatomic, copy) NSString * requestName;
@property (strong, nonatomic) AFNetworkRequest * xfrequst;


+ (XFRequestManager *)sharedInstance;
-(void)XFRequstGetMessageDetail:(NSString *)MsgId userid:(NSString *)userid repondeBlock:(XFResponseBlock)block;

// 消息已读
-(void)XFRequstsetMessageRed:(NSString *)MsgId userid:(NSString *)userid repondeBlock:(XFResponseBlock)block;
// 我的消息
-(void)XFRequstGetMessageList:(NSString *)PageIndex withPageSize :(NSString *)PageSize withtype :(NSString *)type withflag :(NSString *)flag withuserid :(NSString *)userid :(XFResponseBlock)block;

+(NSString*)encodedParams:(NSDictionary*)params;

@end
