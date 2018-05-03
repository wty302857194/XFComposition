//
//  MenuView.h
//  HuiBlockmenu
//
//  Created by 周凤喜 on 2017/7/11.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^menuBlock)(NSInteger);

@interface MenuView : UIView
@property(nonatomic,copy)menuBlock myblock;
@property (nonatomic,strong)UITableView *tableView;

-(id)initWithFrame:(CGRect)frame cellarray:(NSArray *)items block :(void(^)(NSInteger))block;



-(void)showView;
-(void)dismissView;
@end
