//
//  StrokeView.m
//  XFComposition
//
//  Created by qiannian on 2018/5/15.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "StrokeView.h"
#import "StrokeViewCell.h"
@implementation StrokeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)close_action:(id)sender {
    
    [self removeFromSuperview];

}
- (IBAction)sure_action:(id)sender {
    
    
    if (_strokeViewBlcok) {
        _strokeViewBlcok (index,_isSetColor);
    }
    
    [self removeFromSuperview];
    
    
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    _dataArray =[NSMutableArray array];
    
    [_tableView registerNib:[UINib nibWithNibName:@"StrokeViewCell" bundle:nil] forCellReuseIdentifier:@"StrokeViewCell"];
    
}
-(void)showStrokeView:(NSArray *)array isSetColor:(BOOL)isSetColor{
    
    _dataArray = array;
    
    _isSetColor = isSetColor;
    if (isSetColor) {
        _titleLabel.text = @"颜色设置";

    }else{
        
        _titleLabel.text = @"画笔设置";

    }
    [_tableView reloadData];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
 self.sd_layout.leftEqualToView(window).rightEqualToView(window).topEqualToView(window).bottomEqualToView(window);
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StrokeViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"StrokeViewCell"];
    [cell reloadData:_dataArray[indexPath.row]];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StandardInfo * info = _dataArray[indexPath.row];
    for (StandardInfo *bean in _dataArray) {
    
        bean.isSelected = NO;
    }
    info.isSelected =YES;

    index = indexPath.row;
    [_tableView reloadData];
}
@end
