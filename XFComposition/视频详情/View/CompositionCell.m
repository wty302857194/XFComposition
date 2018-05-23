//
//  CompositionCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "CompositionCell.h"

@implementation CompositionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

-(void)setDataModel:(MicPianduanmodel *)dataModel
{
    _dataModel = dataModel;
    _saveLab.text = [_dataModel.BlogStatic isEqualToString:@"1"] ? @"【已保存】 " : @"";
    _submitLab.text = [_dataModel.BlogBg isEqualToString:@"1"] ? @"【已提交】 " : @"";
    _titleLab.text = _dataModel.BlogTitle;
    _dateLab.text = _dataModel.BlogAddTime;
}

- (IBAction)selectItem:(id)sender
{
    self.selectBtn.selected = !self.selectBtn.selected;
    if (self.selectBtn.selected) {
        [self.selectBtn setImage:[UIImage imageNamed:@"xf_quadrate_p"] forState:UIControlStateNormal];
    } else {
        [self.selectBtn setImage:[UIImage imageNamed:@"xf_quadrate"] forState:UIControlStateNormal];
    }
    self.selectItemBlock(self.selectBtn.selected);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
