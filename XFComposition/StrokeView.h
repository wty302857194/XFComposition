//
//  StrokeView.h
//  XFComposition
//
//  Created by qiannian on 2018/5/15.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^StrokeViewBlcok)(int arguments,BOOL isSetColor);


@interface StrokeView : UIView<UITableViewDataSource,UITableViewDelegate>{
    

        
    NSInteger index;
    BOOL _isSetColor;
    
}
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *dataArray;
@property (copy, nonatomic)  StrokeViewBlcok strokeViewBlcok;


-(void)showStrokeView:(NSArray*)array isSetColor:(BOOL)isSetColor;
@end
