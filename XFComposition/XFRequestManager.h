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
#define XFReq_User_MessageList         @"消息列表"

#define XFReq_User_messageLook         @"消息已读"
#define XFReq_User_UpdataMe            @"移到垃圾箱"
#define XFReq_User_DeleteMe            @"彻底删除"
#define XFReq_User_AddMessage          @"发送消息"
#define XFReq_User_GetUserList         @"获得收件人列表"
#define XFReq_User_SetUserIcon         @"设置用户头像"
#define XFReq_User_AddStander          @"添加标准"
#define XFReq_User_GetStandard         @"获得标准"
#define XFReq_User_DeleteStandard      @"删除标准"

#define XFReq_User_GetBlogStandard     @"获得带有评分标准"
#define XFReq_User_GetBlogComment      @"获取总评"
#define XFReq_User_GetWritePicList     @"获取习作图片列表"
#define XFReq_User_UploadAudio         @"上传录音文件"
#define XFReq_User_AddCutPic           @"添加截图"
#define XFReq_User_GetPicBlog          @"获得文库"

#define XFReq_User_SubmitComment       @"保存总评和标准"
#define XFReq_User_DeleteCutPic        @"删除截图"



@interface XFRequestManager : NSObject
@property (nonatomic, copy) NSString * requestName;
@property (strong, nonatomic) AFNetworkRequest * xfrequst;


+ (XFRequestManager *)sharedInstance;
-(void)XFRequstGetMessageDetail:(NSString *)MsgId userid:(NSString *)userid repondeBlock:(XFResponseBlock)block;

// 消息已读
-(void)XFRequstsetMessageRed:(NSString *)MsgId userid:(NSString *)userid repondeBlock:(XFResponseBlock)block;
// 我的消息
-(void)XFRequstGetMessageList:(NSString *)PageIndex withPageSize :(NSString *)PageSize withtype :(NSString *)type withflag :(NSString *)flag withuserid :(NSString *)userid :(XFResponseBlock)block;

// 移到垃圾箱
-(void)XFRequstsetMessageUpdataMe:(NSString*)MsgId userid:(NSString*)userid :(XFResponseBlock)block;
// 彻底删除
-(void)XFRequstsetMessageDeleteMe:(NSString*)MsgId userid:(NSString*)userid :(XFResponseBlock)block;
// 获得收件人列表
-(void)XFRequstGetUserList:(NSString*)ParentId userid:(NSString*)userid EnName:(NSString*)EnName seachName:(NSString*)seachName :(XFResponseBlock)block;
// 设置用户头像
-(void)XFRequstSetUserIcon:(NSString*)userid images:(NSArray*)images :(XFResponseBlock)block;
/**
 *添加标准
 *@param StandardId 标准标识  0:新增数据 非0 修改当条数据
 *@param ObjectId 对象标识
 *@param AddUser 用户标识
 *@param ModelId //模块  5：微课堂 7：公益活动
 *@param StandardText 标准
 */
-(void)XFRequstAddStandard:(NSString*)StandardId objectId:(NSString*)ObjectId addUser:(NSString*)AddUser modelId:(NSString*)ModelId standardText:(NSString*)StandardText :(XFResponseBlock)block;

/**
 *删除标准
 *@param StandardId 标准标识
 */
-(void)XFRequstDeleteStandard:(NSString*)StandardId :(XFResponseBlock)block;

/**
 *获取标准
 *@param ObjectId 对象标识
 *@param AddUser 用户标识
 *@param ModelId //模块  5：微课堂 7：公益活动
 */
-(void)XFRequstGetStandard:(NSString*)ObjectId
                   addUser:(NSString*)AddUser
                   modelId:(NSString*)ModelId
                          :(XFResponseBlock)block;


/**
 *获取带有评分的标准
 *@param blogID  //习作标识
 *@param userID 用户标识
 */
-(void)XFRequstGetBlogStandard:(NSString*)blogID
                   userID:(NSString*)userID
                          :(XFResponseBlock)block;
/**
 *获取总评分
 *@param blogID  //习作标识
 *@param userID 用户标识
 */
-(void)XFRequstGetBlogComment:(NSString*)blogID
                        userID:(NSString*)userID
                              :(XFResponseBlock)block;

/**
 *获取习作图片列表
 *@param blogID  //习作标识
 *@param userID 用户标识
 */
-(void)XFRequstGetWritePicCheckList:(NSString*)blogID
                       userID:(NSString*)userID
                           isChange:(BOOL)isChange
                             :(XFResponseBlock)block;
/**
 *上传录音文件
 *@param userID  //用户标识
 *@param fileValue 录音文件
 */
-(void)XFRequstUploadAudio:(NSString*)userID
                           fileValue:(NSData*)fileValue
                                   :(XFResponseBlock)block;

/**
 *添加截图
 *@param userID  //用户标识
 *@param PicID 习作图片标识
 *@param blogID 习作标识
 *@param ExtractPicUrl 截图图片地址
  *@param ExtractContent /截图文字
 *@param ExtractType  0：范文库  1：病文库
 */
-(void)XFRequstAddCutPic:(NSString*)userID
                   PicID:(NSString*)PicID
                  blogID:(NSString*)blogID
           ExtractPicUrl:(NSString*)ExtractPicUrl
          ExtractContent:(NSString*)ExtractContent
             ExtractType:(NSString*)ExtractType
                        :(XFResponseBlock)block;

/**
 *保存总评和标准
 *@param userID  //用户标识
 *@param commentinfo 总内容
 *@param blogID 习作标识
 *@param StandardDetail 标准id和评分
 */
-(void)XFRequstSubmitComment:(NSString*)userID
             commentinfo:(NSString*)commentinfo
                  blogID:(NSString*)blogID
          StandardDetail:(NSString*)StandardDetail
                        :(XFResponseBlock)block;

/**
 *获得文库
 *@param userID  //用户标识
 *@param blogID 习作标识
 *@param ExtractType  0：范文库  1：病文库
 */
-(void)XFRequstGetCutPicBlog:(NSString*)userID
                  blogID:(NSString*)blogID
             ExtractType:(NSString*)ExtractType
                        :(XFResponseBlock)block;

/**
 *获得文库
 *@param ExtractID  //截图标识
 */
-(void)XFRequstDeleteCutPic:(NSString*)ExtractID
                            :(XFResponseBlock)block;

+(NSString*)encodedParams:(NSDictionary*)params;

@end
