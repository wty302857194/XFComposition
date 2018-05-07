//
//  GetMessageListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMessageListModel : FMBean
@property (nonatomic,copy)NSString *DateTime;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,copy)NSString *MesType;
@property (nonatomic,copy)NSString *ReadFlag;
@property (nonatomic,copy)NSString *Title;

@end
