//
//  BookDetailSecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookDetailSecondCell.h"

@implementation BookDetailSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    
        _table = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 30)];
        _table.font = [UIFont systemFontOfSize:11];
        [self addSubview:_table];
        
        _quanbuview = [[UIView alloc] init];
        _quanbuview.backgroundColor = [UIColor lightGrayColor];
        _quanbuview.frame = CGRectMake(20, 40, 200, 5);

        [self addSubview:_quanbuview];

        _yijingview = [[UIView alloc] init];
        _yijingview.backgroundColor = [UIColor redColor];
        _yijingview.frame = CGRectMake(0, 0, 0, 0);
        [self addSubview:_yijingview];

        
    }
    return self;
}

-(void)setModel:(GetBookInfoModel *)model{
    
    _table.text = [NSString stringWithFormat:@"我的读书进度(%@/%@)",model.BookMyMaxPage,model.bookpages];
  
    int a = [model.BookMyMaxPage intValue];
    int b = [model.bookpages intValue];
    
    if (a == 0||b == 0){
        
    }else{
          _yijingview.frame = CGRectMake(20, 40, 200*a/b, 5);
    }
  
    
}
@end
