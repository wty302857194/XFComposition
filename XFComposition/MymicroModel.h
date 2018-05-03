//
//  MymicroModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/7.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MymicroModel : NSObject
@property (nonatomic,strong)NSString *FavTime;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *MicroclassInfoId;
@property (nonatomic,strong)NSString *PicPath;
@property (nonatomic,strong)NSString *Tiltle;
@end

@interface MymicroInfo : NSObject
@property (nonatomic,strong)NSMutableArray *mymicro_blog;
@end

@interface MymicroDataInfo : NSObject
@property (nonatomic,assign)NSInteger allCount;
@property (nonatomic,strong)NSMutableArray *pageInfo;
@end

@interface MymicroData : XFBaseModel
@property (nonatomic,strong)MymicroDataInfo *ret_data;
@end
