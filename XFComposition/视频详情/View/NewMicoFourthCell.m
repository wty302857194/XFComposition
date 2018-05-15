//
//  NewMicoFourthCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/9.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "NewMicoFourthCell.h"
#import "CommentViewCell.h"

@implementation NewMicoFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentViewCell" bundle:nil] forCellReuseIdentifier:@"CommentViewCell"];
    
    [self setPlaceHolder];
    

}

- (void)setDatas:(NSMutableArray *)datas
{
    _datas = datas;
    self.tableViewHeightConstraint.constant = 80 *_datas.count;
    [self.tableView reloadData];
}

#pragma mark - delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.data = self.datas[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


- (void)setPlaceHolder{
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivars[i];
        
        const char *name = ivar_getName(ivar);
        
        NSString *objcName = [NSString stringWithUTF8String:name];
        
        if ([objcName isEqualToString:@"_placeholderLabel"]) {
            
            UILabel *placeHolderLabel = [[UILabel alloc] init];
            
            placeHolderLabel.text = @"200字以内";
            
            placeHolderLabel.numberOfLines = 0;
            
            placeHolderLabel.textColor = [UIColor lightGrayColor];
            
            [placeHolderLabel sizeToFit];
            
            [self.textView addSubview:placeHolderLabel];
            
            placeHolderLabel.font = self.textView.font;
            
            [self.textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
            
            break;
            
        }
        
    }
    free(ivars);
}
- (IBAction)submitComment:(id)sender
{
    if (self.textView.text.length > 0) {
        self.submitCommentBlock(self.textView);
    } else {
        [SVProgressHUD showInfoWithStatus:@"请输入内容"];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
