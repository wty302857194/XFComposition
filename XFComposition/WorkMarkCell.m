//
//  WorkMarkCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/17.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "WorkMarkCell.h"
@interface WorkMarkCell()
@property (nonatomic,strong)IBOutlet  UILabel *titleLabel;
@property (nonatomic,strong)IBOutlet  UILabel *label3;
@property (nonatomic,strong)IBOutlet  UILabel *label4;
@property (strong, nonatomic) IBOutlet UIButton *thirdBtn;
@property (strong, nonatomic) IBOutlet UIButton *fouthBrn;

- (IBAction)button_action:(id)sender;
@end
@implementation WorkMarkCell
-(void)awakeFromNib{
    
    [super awakeFromNib];
    _thirdBtn.layer.cornerRadius = _fouthBrn.layer.cornerRadius = 6;
    _thirdBtn.layer.masksToBounds =  _fouthBrn.layer.masksToBounds = YES;
    
    
    
}

-(void)setModel:(GetTeachNeedCheckListModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"《%@》",_model.WorkName];
    if ([_model.IsCheck integerValue] == 0) {
        self.label3.text = @"未点评";
        [self.thirdBtn setBackgroundColor:[UIColor colorWithHexString:@"009dff"]];
        [self.thirdBtn setTitle:@"点评习作" forState:UIControlStateNormal];
        self.thirdBtn.enabled = YES;
    }else {
        self.label3.text = @"已点评";
        [self.thirdBtn setBackgroundColor:[UIColor colorWithHexString:@"BEBFBE"]];
        self.thirdBtn.enabled = NO;
        [self.thirdBtn setTitle:@"已点评" forState:UIControlStateNormal];
    }
    if ([_model.Isback integerValue] == 0) {
        self.label4.text = @"未评审";
    }else{
        self.label4.text = @"已评审.优秀";
    }
}
- (IBAction)button_action:(id)sender {
    UIButton * btn = (UIButton*)sender;
    if ([self.delegate respondsToSelector:@selector(dianping : withModel:)]) {
        [self.delegate dianping:btn withModel:_model];
    }
    
}
@end
