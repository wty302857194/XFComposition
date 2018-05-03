//
//  PanduanCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/28.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "PanduanCell.h"
@interface PanduanCell()
@property (nonatomic,strong)NSMutableArray *array;
@property (nonatomic,strong)NSArray *ABCDarray;
@property (nonatomic,strong)NSMutableArray *btarray;
@end
@implementation PanduanCell

-(NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
-(NSArray *)ABCDarray{
    if (!_ABCDarray) {
        _ABCDarray = [NSArray array];
        _ABCDarray = @[@"正确",@"错误"];
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
//        self.titleLabel = [[UILabel alloc]init];
//        [self.contentView addSubview:self.titleLabel];
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
    
//    self.titleLabel.sd_layout.leftSpaceToView(self.contentView, 20).topSpaceToView(self.contentView, 10).rightSpaceToView(self.contentView, 20).autoHeightRatio(0);
//    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.array removeAllObjects];
    for (NSDictionary *dic in _model.answerItem) {
        GetActiveTestModel *model = [GetActiveTestModel loadWithJSOn:dic];
        [self.array addObject:model];
    }
    
    for (int i =0; i<2; i++) {
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bt];
        
        bt.sd_layout.leftSpaceToView(self.contentView, 20+85*i ).topSpaceToView(self.titleLabel, 20).heightIs(40).widthIs(60);
        bt.layer.cornerRadius = 4;
        bt.layer.masksToBounds = YES;
        bt.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        bt.layer.borderWidth = 1;
        bt.tag = 8000+i;
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bt addTarget:self action:@selector(clickBt:) forControlEvents:UIControlEventTouchUpInside];
        bt.titleLabel.font = [UIFont systemFontOfSize:14];
        [bt setTitle:self.ABCDarray[i] forState:UIControlStateNormal];
        [self.btarray addObject:bt];
        
        
    }
}
-(void)clickBt:(UIButton *)bt{
    for (UIButton *btn in self.btarray) {
        if (btn.tag == bt.tag) {
            [btn setBackgroundColor:[UIColor redColor]];
        }else {
            [btn setBackgroundColor:[UIColor clearColor]];
            
        }
    }
    
}
@end
