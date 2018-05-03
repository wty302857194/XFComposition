//
//  UITextField+LCAdd.m
//  GBHelper
//
//  Created by lc-macbook pro on 2018/3/28.
//  Copyright © 2018年 http://www.cnblogs.com/saytome/. All rights reserved.
//

#import "UITextField+LCAdd.h"

@implementation UITextField (LCAdd)

+ (UITextField *)lc_fieldWithPlaceHolder:(NSString *)placeHolder {
    UITextField *textfield = [[UITextField alloc]init];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.rightViewMode = UITextFieldViewModeAlways;
    
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //textfield.textColor = [AppSkin appDarkGreenColor];
    textfield.placeholder = placeHolder;
    
    return textfield;
}

- (void)lc_setPlaceHolderTextColor:(UIColor *)color {
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}


- (NSRange) selectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}
- (void) setSelectedRange:(NSRange) range
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end
