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
- (void)resetFrame:(int)count
{
    
    self.tableViewHeightConstraint.constant = 80 *6;
}

#pragma mark - delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentLab.text = @"alskdkaks凯撒圣诞节阿森纳";
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
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
- (IBAction)submitComment:(id)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
