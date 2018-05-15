//
//  Global.h
//  HomeCare
//
//  Created by Lawrence on 13-10-10.
//  Copyright (c) 2013年 ztesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject

// 判断调用字符对象是否为空
+ (id)checkNSStringIsNull:(id)stringId;

+ (void)setSubViewExternNone:(UIViewController *)viewController;

+ (void)promptMessage:(NSString *)message inView:(UIView *)view;

+ (void)promptMessageYoffset:(CGFloat)yyOffset withMessage:(NSString *)message inView:(UIView *)view;// 向上偏移20；

+ (void)promptDetailMessage:(NSString *)message inView:(UIView *)view;

+ (UIColor *)hexStringToColor:(NSString *)stringToConvert;

+ (NSString *)timeSp2String:(double)sp;

+ (NSString *)currentTime;

+ (NSString *)currentTimeFormat2;

+ (NSDate *)string2Date:(NSString *)src;

// 处理日期选择器的（今天／明天／后天）
+ (NSInteger)numberOfDaysFromCurrentTime:(NSDate *)currentTime toEndTime:(NSDate *)endTime timeStringFormat:(NSString *)format;

+ (NSString *)getIPAddress;

// 获取软件版本号
+ (NSString *)getSoftVersion;

// 获取北京时间
+ (NSDate *)retainStandardFormatDateWith:(NSDate *)date;

// NSDate 的16前位字符串
+ (NSString *)currentDateString:(NSDate *)nowDate;

// 校验是否时ASSIC码字符（要求输入ASSIC）
+(BOOL)checkStringContainsASCIICode:(NSString *)checkString;

// 根据文字大小和控件宽度计算控件高度
+ (CGFloat)heightForText:(NSString *)text textFont:(CGFloat)fontSize standardWidth:(CGFloat)controlWidth;

// 根据文字大小和控件高度计算控件宽度
+ (CGFloat)widthForText:(NSString *)text textFont:(CGFloat)fontSize  standardHeight:(CGFloat)controlHeight;

// 自定义文本颜色，大小
+ (NSAttributedString *)customTextString:(NSString *)textStr withRange:(NSRange)temRange withAttributedType:(BOOL)attributedType;

// 自定义文本颜色，大小替换
+ (NSAttributedString *)customizationTextString:(NSString *)textStr withRange:(NSRange)temRange withFontSize:(CGFloat)textFont withTextColor:(UIColor *)textColor withAttributedType:(BOOL)attributedType;

// 自定义文本颜色和大小
+ (NSAttributedString *)customizationTextString:(NSString *)textStr withRange:(NSRange)temRange withFontSize:(CGFloat)textFont withTextColor:(UIColor *)textColor withAttributesArrayType:(NSInteger)attributedType;


// 判断字符串为null nil "   ";
+ (NSString *)isBlankString:(NSString *)string;

// 去除字符串的逗号，或者更多符号
+ (NSString *)stringDeleteString:(NSString *)str;

// 判断字符是否包含某字符串
+ (BOOL)refrenceString:(NSString *)refrenceStr withContainSomeString:(NSString *)str;

// 手机号转化为格式334
+ (NSMutableString *)formatStringTo334WithSourceStr:(NSString *)sourceStr;

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;

// 压缩图片
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

// 第三方裁剪上传图片带来的方向问题
+ (UIImage *)fixOrientation:(UIImage *)originalImage;


// 下拉刷新的动态图
+ (NSArray *)getGifImageArray;
+ (NSArray *)getGifImageFirst;
+ (NSArray *)getGifImageSecond;


// url 返回image
+ (UIImage *)downloaderImg:(NSString *)urlStr;
// image base64 编码为字符串
+ (NSString *)encodeBase64WithImage:(UIImage *)origrinImage;
// base64解码为image
+ (UIImage *)decodedImageWithImageStr:(NSString *)origrinImageStr;

// 存取沙盒
+ (void)saveImageArray:(NSDictionary *)saveDataDic;
+ (NSDictionary *)readImageArray;

+ (void)saveOrderCodeArray:(NSMutableDictionary *)saveDataDic;
+ (NSMutableDictionary *)readOrderCodeArray;

// 跳转设置(openUrl)
+ (BOOL)jumpIphoneSettingPage:(UIView *)showOnView;

// 跳转 app 权限集合页面
+ (void)openSettingsURLString;

//阿拉伯数字转为汉字
+ (NSString *)chineseWithArabString:(NSString *)arabStr;

//存储PDF文件并读取
+ (NSURL *)readPDFFileWithDocumentRef:(NSData *)documentRef;

#pragma mark -- 文件路径读取 --
// 读取路径
+ (NSString *)pathForSourceFileName:(NSString *)fileName withType:(NSString *)type;

+ (NSString *)getGameCnforString:(NSString *)str;

+ (NSString *)dataStringForString:(NSString *)string;

//压缩图片
+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage;

//view生成image
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;
@end
