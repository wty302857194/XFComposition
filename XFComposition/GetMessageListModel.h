//
//  GetMessageListModel.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/24.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetMessageListModel : FMBean
@property (nonatomic,strong)NSString *DateTime;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *MesType;
@property (nonatomic,strong)NSString *ReadFlag;
@property (nonatomic,strong)NSString *Title;

@end
