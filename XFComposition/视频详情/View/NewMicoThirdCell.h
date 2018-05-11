//
//  NewMicoThirdCell.h
//  XFComposition
//
//  Created by 李琰 on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompositionCell.h"

/** 视频拉伸方式 */
typedef NS_ENUM(NSUInteger, ClickType){
    ClickTypeAdd,       //新建
    ClickTypeSave,      //保存
    ClickTypeSubmit,    //提交
};

typedef void(^DidSelectRowBlock)(MicPianduanmodel *model);

typedef void(^ClickBlock)(NSArray<MicPianduanmodel *> *array, ClickType type);

@interface NewMicoThirdCell : UITableViewCell<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint;
@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, strong)  ClickBlock clickBlock;

@property (nonatomic, strong)  DidSelectRowBlock didSelectRowBlock;


@end
