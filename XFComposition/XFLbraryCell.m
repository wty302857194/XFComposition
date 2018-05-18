//
//  XFLbraryCell.m
//  XFComposition
//
//  Created by qiannian on 2018/5/16.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "XFLbraryCell.h"

@implementation XFLbraryCell
- (IBAction)delete_action:(id)sender {
    
    if (_cellBlock) {
        _cellBlock (_library);
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)reloadData:(FMBean*)bean{
    
    _library = (XFLibrary*)bean;
    
    if ([_library.ExtractPicUrl containsString:@"http://xf.vqune.com"]) {
        [_imgeView sd_setImageWithURL:[NSURL URLWithString:_library.ExtractPicUrl]];

    }else{
        [_imgeView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,_library.ExtractPicUrl]]];

        
    }
    
    
}
@end
