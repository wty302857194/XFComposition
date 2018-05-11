//
//  NewMicoFristCell.m
//  XFComposition
//
//  Created by 李琰 on 2018/5/7.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "NewMicoFristCell.h"
#import <objc/runtime.h>

@interface NewMicoFristCell ()

@end

@implementation NewMicoFristCell




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleLab.text = @"";
    _teacherLab.text = @"";
    _courseLab.text = @"";
    
    _teachGuideLab.text = @"";
    _workLab.text = @"";
    
    _collectionBtn.layer.masksToBounds = YES;
    _collectionBtn.layer.cornerRadius = 4;
    
    _shareBtn.layer.masksToBounds = YES;
    _shareBtn.layer.cornerRadius = 4;
    
}




- (IBAction)collectionCourse:(id)sender {
   self.clickBlock(0);
}

- (IBAction)shareCourse:(id)sender {
    self.clickBlock(1);
}

-(void)setDataModel:(MicrodetailModel *)dataModel
{
    _dataModel = dataModel;
    if (_dataModel.className) {
        _titleLab.text = [NSString stringWithFormat:@"《%@》",_dataModel.className];
    }
    _teacherLab.text = _dataModel.classMaster;
    if (_dataModel.classStartTime) {
        _courseLab.text = [NSString stringWithFormat:@"%@~%@",[_dataModel.classStartTime substringToIndex:9],[_dataModel.classEndTime substringToIndex:9]];
    }
    
    _teachGuideLab.text = _dataModel.classTarget;
    _workLab.text = _dataModel.classInfo;
    
    
}


- (float)getCellHeight
{
    return 422.0f + self.teachGuideLab.frame.size.height + self.workLab.frame.size.height;
}

/* 获取对象的所有属性 */
+(NSArray *)getAllProperties
{
    u_int count;
    // 传递count的地址过去 &count
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    //arrayWithCapacity的效率稍微高那么一丢丢
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        //此刻得到的propertyName为c语言的字符串
        const char* propertyName =property_getName(properties[i]);
        //此步骤把c语言的字符串转换为OC的NSString
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    //class_copyPropertyList底层为C语言，所以我们一定要记得释放properties
    // You must free the array with free().
    free(properties);
    
    return propertiesArray;
}

/**
 @method 获取指定宽度width,字体大小fontSize,字符串value的高度
 @param value 待计算的字符串
 @param width 限制字符串显示区域的宽度
 @result float 返回的高度
 */
- (float) heightForString:(NSString *)value andWidth:(float)width{
    //获取当前文本的属性
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    NSRange range = NSMakeRange(0, attrStr.length);
    // 获取该段attributedString的属性字典
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    // 计算文本的大小
    CGSize sizeToFit = [value boundingRectWithSize:CGSizeMake(width - 30.0, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                        attributes:dic        // 文字的属性
                                           context:nil].size; // context上下文。包括一些信息，例如如何调整字间距以及缩放。该对象包含的信息将用于文本绘制。该参数可为nil
    return sizeToFit.height + 16.0;
}


@end
