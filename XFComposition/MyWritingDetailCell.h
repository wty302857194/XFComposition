//
//  MyWritingDetailCell.h
//  XFComposition
//
//  Created by chenshunyi on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyWritingDetailModel.h"

@interface MyWritingDetailCell : UITableViewCell

-(void)reloadCellData:(id)cellData;

+(CGFloat)cellHeight:(id)cellData;
@end
