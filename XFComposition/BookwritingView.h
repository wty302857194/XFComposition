//
//  BookwritingView.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/27.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BookwritingView;
@protocol bookWritingDelegate <NSObject>

-(void)didsome :(UIButton *)bt;
-(void)didSave;

@end
@interface BookwritingView : UIView
@property (nonatomic,weak)id<bookWritingDelegate>delegate;

@property (nonatomic,strong)UITextField *textfield;
@property (nonatomic,strong)NSString *xingji;
@property (nonatomic,strong)NSMutableArray *btarray;
@end
