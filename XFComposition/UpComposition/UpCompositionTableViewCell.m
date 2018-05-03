//
//  UpCompositionTableViewCell.m
//  XFComposition
//
//  Created by wbb on 2018/4/19.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "UpCompositionTableViewCell.h"
#import "UpCompositionModel.h"

@implementation UpCompositionTableViewCell

- (void)setModel:(UpCompositionModel *)model {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,model.MicroclassInfoAttr1?:@""]] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLab.text = model.MicroclassInfoTitle?:@"";
    self.timeLab.text = [NSString stringWithFormat:@"活动时间：%@-%@",model.MicroclassInfoStartTime,model.MicroclassInfoEndTime];
    if (model.isWeiKe) {
        self.contentLab.text = [NSString stringWithFormat:@"课程设计导师：%@",model.MicroclassInfoMaster];
    }else {
        self.contentLab.text = model.MicroclassInfoTarget;
    }
}

@end
