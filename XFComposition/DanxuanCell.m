//
//  DanxuanCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "DanxuanCell.h"
@interface DanxuanCell()
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSArray *ABCDarray;
@property (nonatomic,strong)NSMutableArray *btarray;
@end
@implementation DanxuanCell
-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
-(NSArray *)ABCDarray{
    if (!_ABCDarray) {
        _ABCDarray = [NSArray array];
        _ABCDarray = @[@"A",@"B",@"C",@"D"];
    }
    return _ABCDarray;
}
-(NSMutableArray *)btarray{
    if (!_btarray) {
        _btarray = [NSMutableArray array];
    }
    return _btarray;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
      
    }
    return self;
}
-(void)setModel:(GetActivePageViewModel *)model{
    _model = model;
    for (UIView *subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.frame =CGRectMake(10, 10, 200, 20);
    [self.contentView addSubview:self.titleLabel];
    
  
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.array removeAllObjects];
    for (NSDictionary *dic in _model.answerItem) {
        GetActiveTestModel *model = [GetActiveTestModel loadWithJSOn:dic];
        [self.array addObject:model];
    }
     
    for (int i =0; i<self.array.count; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bt];

        bt.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.titleLabel, 30*i + 10).heightIs(20).widthIs(20);
        bt.layer.cornerRadius = 10;
        bt.layer.masksToBounds = YES;
        bt.tag = 1000+i;
        [bt addTarget:self action:@selector(clickBt:) forControlEvents:UIControlEventTouchUpInside];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [bt setTitleColor:hexColor(009dff) forState:UIControlStateNormal];
        
        bt.layer.borderWidth = 1;
        bt.layer.borderColor = hexColor(999999).CGColor;
        
        [bt setTitle:self.ABCDarray[i] forState:UIControlStateNormal];
        [self.btarray addObject:bt];
        
        GetActiveTestModel *model = self.array[i];
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];

        label.sd_layout.leftSpaceToView(bt, 5).topSpaceToView(self.titleLabel, 30*i + 10).heightIs(20).widthIs(0);
        label.tag =2000 +i;
        label.textColor = hexColor(333333);
        [label setSingleLineAutoResizeWithMaxWidth:0];
        label.font = [UIFont systemFontOfSize:14];
        label.text = model.ItemInfo;
        
    }
}
-(void)clickBt:(UIButton *)bt{
    
    for (int i = 0; i<self.btarray.count; i++) {
        UIButton *btn = self.btarray[i];
        UILabel * label = [self.contentView viewWithTag:btn.tag + 1000];

        if (btn.tag == bt.tag) {
            label.textColor = hexColor(009dff);
            [btn setBackgroundColor:hexColor(009dff)];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.layer.borderColor = hexColor(009dff).CGColor;
            
        }else {
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setTitleColor:hexColor(009dff) forState:UIControlStateNormal];
            btn.layer.borderColor = hexColor(999999).CGColor;

            label.textColor = hexColor(333333);

        }
    }
   
    
}
@end
