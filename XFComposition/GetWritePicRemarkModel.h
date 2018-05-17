//
//  GetWritePicRemarkModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetWritePicRemarkModel : NSObject
@property (nonatomic,strong)NSString *CreateTime;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *PicID;
@property (nonatomic,strong)NSString *Remark;
@property (nonatomic,strong)NSString *Sort;
@property (nonatomic,strong)NSString *UserID;
@property (nonatomic,strong)NSString *XLocation;
@property (nonatomic,strong)NSString *YLocation;

+(id)loadWithJSOn:(NSDictionary *)json;
@end


/*
 {
 ""Id"": 134,   //标识
 ""CreateTime"": ""2017/5/1 22:07:30"",
 ""BlogID"": ""43"",  //习作ID
 ""PicID"": ""43"",  //习作图片ID
 ""UserID"": ""23"", //用户ID
 ""Sort"": ""0"", //排序
 ""AudioUrl"": ""这段写的好"",    //点评内容
 ""XLocation"": ""10.08"",  //X轴
 ""YLocation"": ""10.08""  //Y轴
 }
 */
@interface GetWriteAudioModel : NSObject
@property (nonatomic,strong)NSString *CreateTime;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *PicID;
@property (nonatomic,strong)NSString *BlogID;
@property (nonatomic,strong)NSString *Sort;
@property (nonatomic,strong)NSString *UserID;
@property (nonatomic,strong)NSString *XLocation;
@property (nonatomic,strong)NSString *YLocation;
@property (nonatomic,strong)NSString *AudioUrl;

+(id)loadWithJSOn:(NSDictionary *)json;
@end
