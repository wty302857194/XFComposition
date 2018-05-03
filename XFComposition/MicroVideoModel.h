//
//  MicroVideoModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MicroVideoModel : NSObject

@property (nonatomic,strong)NSString *filepath;
@property (nonatomic,strong)NSString *guid;
@property (nonatomic,strong)NSString *videoId;
@property (nonatomic,strong)NSString *orderid;
@property (nonatomic,strong)NSString *picpath;
@property (nonatomic,strong)NSString *playlength;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *viewtime;
@property (nonatomic,strong)NSString *MicroclassItemMp4Path;




+(id)loadWithJSOn:(NSDictionary *)json;

@end
