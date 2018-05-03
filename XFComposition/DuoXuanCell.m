//
//  DuoXuanCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "DuoXuanCell.h"
@interface DuoXuanCell()
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSArray *ABCDarray;
@end
@implementation DuoXuanCell

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
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
        
        bt.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.titleLabel, 25*i + 10).heightIs(20).widthIs(20);
        bt.layer.cornerRadius = 10;
        bt.layer.masksToBounds = YES;
        bt.tag = 3000+i;
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [bt addTarget:self action:@selector(clickBt:) forControlEvents:UIControlEventTouchUpInside];
        [bt setTitle:self.ABCDarray[i] forState:UIControlStateNormal];
        [bt setBackgroundImage:[UIImage imageNamed:@"aixin_n"] forState:UIControlStateNormal];
        [bt setBackgroundImage:[UIImage imageNamed:@"aixin_s"] forState:UIControlStateSelected];
        
        GetActiveTestModel *model = self.array[i];
        UILabel *label = [[UILabel alloc]init];
        [self.contentView addSubview:label];
        
        label.sd_layout.leftSpaceToView(bt, 5).topSpaceToView(self.titleLabel, 25*i + 10).heightIs(20).widthIs(0);
        [label setSingleLineAutoResizeWithMaxWidth:0];
        label.tag =2000 +i;
        label.font = [UIFont systemFontOfSize:14];
        label.text = model.ItemInfo;
        
    }
}
-(void)clickBt:(UIButton *)bt{
    bt.selected = !bt.selected;
    
}
@end
