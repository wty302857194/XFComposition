//
//  Global.m
//  HomeCare
//
//  Created by Lawrence on 13-10-10.
//  Copyright (c) 2013年 ztesoft. All rights reserved.
//

#import "Global.h"
#import "MBProgressHUD.h"
// ipaddress
#include <ifaddrs.h>
#include <arpa/inet.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LOWWER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SYSTEM_RUNS_IOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define DocumentsPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] // 沙盒路径

@implementation Global

+ (id)checkNSStringIsNull:(id)stringId
{
    if (stringId) {
        return stringId;
    }else {
         return @"";
    }
}

+ (void)setSubViewExternNone:(UIViewController *)viewController
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
        viewController.extendedLayoutIncludesOpaqueBars = NO;
        viewController.modalPresentationCapturesStatusBarAppearance = NO;
        viewController.navigationController.navigationBar.translucent = NO;
        viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif
}

+ (void)promptMessage:(NSString *)message inView:(UIView *)view
{
    MBProgressHUD *hud;
    if (view == nil) {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    } else {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
	
	// Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:14];
	hud.margin = 10.f;
	hud.yOffset = 0.f;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:1];
}

+ (void)promptMessageYoffset:(CGFloat)yyOffset withMessage:(NSString *)message inView:(UIView *)view
{
    MBProgressHUD *hud;
    if (view == nil) {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    } else {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:14];
    hud.margin = 10.f;
    hud.yOffset = yyOffset;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.3];
}


+ (void)promptDetailMessage:(NSString *)message inView:(UIView *)view
{
    MBProgressHUD *hud;
    if (view == nil) {
        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    } else {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText = message;
    hud.labelFont = [UIFont systemFontOfSize:14];
    hud.margin = 10.f;
    hud.yOffset = 0.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1];

}


/* 16进制颜色(html颜色值)字符串转为UIColor */
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    
    NSString *aString = nil;
    
    if ([cString length] < 6) return [UIColor blackColor];
    
    /* 去除"0X","#"等标识符 */
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] == 8) {
        aString = [cString substringToIndex:1];
        cString = [cString substringFromIndex:2];
    } else {
        aString = @"ff";
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int a, r, g, b;
    
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}

+ (NSString *)currentTime
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *currentFormatter = threadDictionary[@"currentdateformatter"];
    if (!currentFormatter) {
        @synchronized(self) {
            if (!currentFormatter) {
                currentFormatter = [[NSDateFormatter alloc] init];
                //2017/5/1 22:07:30
                [currentFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
                threadDictionary[@"currentdateformatter"] = currentFormatter;
            }
        }
    }
    return [currentFormatter stringFromDate:[NSDate date]];
}

//时图显示
+ (NSString *)currentTimeFormat2
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *currentFormatter = threadDictionary[@"currentdateformatter2"];
    if (!currentFormatter) {
        @synchronized(self) {
            if (!currentFormatter) {
                currentFormatter = [[NSDateFormatter alloc] init];
                [currentFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                threadDictionary[@"currentdateformatter2"] = currentFormatter;
            }
        }
    }
    return [currentFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)timeSp2String:(double)sp
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"mydateformatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                threadDictionary[@"mydateformatter"] = dateFormatter;
            }
        }
    }
    
    NSString *accessTime = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:sp/1000.0]];
    return accessTime;
}

+ (NSDate *)string2Date:(NSString *)src
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"timeformatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
                threadDictionary[@"timeformatter"] = dateFormatter;
            }
        }
    }
    NSDate *resultDate = [dateFormatter dateFromString:src];
    return resultDate;
}

+ (NSDate *)retainStandardFormatDateWith:(NSDate *)date
{
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];
    NSInteger frominterval = [timeZone secondsFromGMTForDate: date];
    return [date  dateByAddingTimeInterval: frominterval];
}

// 当前时间
+ (NSString *)currentDateString:(NSDate *)nowDate
{
    NSDateFormatter *_dateFormmtter = [[NSDateFormatter alloc] init];
    [_dateFormmtter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];
    [_dateFormmtter setTimeZone:timeZone];
    NSString *startDateString = [_dateFormmtter stringFromDate:nowDate];
    
    return [startDateString substringWithRange:NSMakeRange(0, 16)];
}


+ (NSInteger)numberOfDaysFromCurrentTime:(NSDate *)currentTime toEndTime:(NSDate *)endTime timeStringFormat:(NSString *)format
{
    // format可以形如： @"yyyy-MM-dd"
    NSTimeZone *localTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:localTimeZone];
    [formatter setDateFormat:NSLocalizedString(format,nil)];
    
    // 时分秒转为00:00:00
    NSDate *currentDate = [formatter dateFromString:[formatter stringFromDate:currentTime]];
    NSDate *endDate = [formatter dateFromString:[formatter stringFromDate:endTime]];
    
    // 计算时间戳
    NSTimeInterval dToday = [currentDate timeIntervalSince1970];
    NSTimeInterval dNewDate = [endDate timeIntervalSince1970];
    
    NSInteger nSecs = (NSInteger)(dNewDate - dToday);
    NSInteger oneDaySecs = 24*3600;
    
    return nSecs / oneDaySecs;
}

// 获取IPAddress
+ (NSString *)getIPAddress
{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
// 获取软件的版本号
+ (NSString *)getSoftVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *versionStr = infoDictionary[@"CFBundleShortVersionString"];
    NSLog(@"版本号－－－－%@",infoDictionary);
    return versionStr;
}

+ (BOOL)checkStringContainsASCIICode:(NSString *)checkString
{
    const char *ASCIIString = [checkString cStringUsingEncoding:NSASCIIStringEncoding];
    if (ASCIIString) {
        return YES;
    }else {
        return NO;
    }
}

// 根据文字大小和控件宽度计算控件高度
+ (CGFloat)heightForText:(NSString *)text textFont:(CGFloat)fontSize standardWidth:(CGFloat)controlWidth
{
    if ([text length]==0) {
        return 0;
    }else {
        NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
        return [text boundingRectWithSize:CGSizeMake(controlWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height;
    }
}

+ (CGFloat)widthForText:(NSString *)text textFont:(CGFloat)fontSize  standardHeight:(CGFloat)controlHeight
{
    if ([text length]==0) {
        return 0;
    }else {
        NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
        return  [text boundingRectWithSize:CGSizeMake(1000,controlHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.width;
    }
}

+ (NSAttributedString *)customTextString:(NSString *)textStr withRange:(NSRange)temRange withAttributedType:(BOOL)attributedType
{
    NSMutableAttributedString *rateStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    NSString *attributeName = nil;
    id attributeValue = nil;
    
    if (attributedType) {
        attributeName = NSFontAttributeName;
        attributeValue = [UIFont systemFontOfSize:18.f];
    }else {
        attributeName = NSForegroundColorAttributeName;
        attributeValue = [UIColor blackColor];
    }
    
    [rateStr addAttribute:attributeName value:attributeValue range:temRange];
    return rateStr;
}

// 自定义文本的大小和颜色

+ (NSAttributedString *)customizationTextString:(NSString *)textStr withRange:(NSRange)temRange withFontSize:(CGFloat)textFont withTextColor:(UIColor *)textColor withAttributedType:(BOOL)attributedType
{
    NSMutableAttributedString *rateStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    NSString *attributeName = nil;
    id attributeValue = nil;
    
    if (attributedType) {
        // 字体大小
        attributeName = NSFontAttributeName;
        attributeValue = [UIFont systemFontOfSize:textFont];
    }else {
        // 颜色
        attributeName = NSForegroundColorAttributeName;
        attributeValue = textColor;
    }
    
    [rateStr addAttribute:attributeName value:attributeValue range:temRange];
    return rateStr;
}

+ (NSAttributedString *)customizationTextString:(NSString *)textStr withRange:(NSRange)temRange withFontSize:(CGFloat)textFont withTextColor:(UIColor *)textColor withAttributesArrayType:(NSInteger)attributedType
{
    NSMutableAttributedString *rateStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    if (attributedType==0) {
        [rateStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont],NSForegroundColorAttributeName:textColor} range:temRange];
    }else {
        
    }
    return rateStr;
}

//
+ (NSString *)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
    {
        return @"0";
    }else if ([string isKindOfClass:[NSNull class]]) {
        return @"0";
    }else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return @"0";
    }else {
        return string;
    }
}


+ (NSString *)stringDeleteString:(NSString *)str
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == ',') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}

+ (BOOL)refrenceString:(NSString *)refrenceStr withContainSomeString:(NSString *)str;
{
    //字条串是否包含有某字符串
    if (refrenceStr==nil) {
        return NO;
    }else if ([refrenceStr length]==0) {
        return NO;
    }else {
        if ([refrenceStr rangeOfString:str].location == NSNotFound) {
            return NO;
        } else {
            return YES;
        }
    }
}

+ (NSString *)formatStringTo334WithSourceStr:(NSString *)sourceStr
{
    if ([sourceStr length]==0) {
        return @"";
    }
    
    NSMutableString *temString = [NSMutableString stringWithString:sourceStr];
    [temString insertString:@" " atIndex:0];
    
    NSMutableString *temp = [NSMutableString string];
    for(int i =0; i < temString.length; i++)
    {
        NSString *str = [temString substringWithRange:NSMakeRange(i, 1)];
        [temp appendString:str];
        if ((i+1) % 4 == 0&&i<11) {
            [temp appendString:@" "];
        }
    }
    
    NSRange r;
    r.location = 0;
    r.length = 1;
    [temp deleteCharactersInRange:r];
    // NSLog(@"delete---%@---",temp);
    return temp;
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 压缩图片
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newSize.width, newSize.height), NO,[UIScreen mainScreen].scale);
    //    UIGraphicsBeginImageContextWithOptions(newSize, NO, 2.0);
    //UIGraphicsBeginImageContext(newSize);//根据当前大小创建一个基于位图图形的环境
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];//根据新的尺寸画出传过来的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    UIGraphicsEndImageContext();//关闭当前环境
    
    newImage = [newImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return newImage;
}

+ (UIImage *)fixOrientation:(UIImage *)originalImage
{
    if (originalImage.imageOrientation == UIImageOrientationUp) return originalImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (originalImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.width, originalImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, originalImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (originalImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, originalImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, originalImage.size.width, originalImage.size.height,
                                             CGImageGetBitsPerComponent(originalImage.CGImage), 0,
                                             CGImageGetColorSpace(originalImage.CGImage),
                                             CGImageGetBitmapInfo(originalImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (originalImage.imageOrientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.height,originalImage.size.width), originalImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,originalImage.size.width,originalImage.size.height), originalImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (NSArray *)getGifImageArray {
    NSMutableArray *idleImages = [[NSMutableArray alloc] init];
    //这块为你刷新时出现的gif图 需要循环添加到数组中
    for (NSUInteger i = 1; i <= 3; i++) {
        
        UIImage *temImage = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_pic%ld",i]];
        UIImage *image = [Global imageWithImageSimple:temImage scaledToSize:CGSizeMake(30, 30)];
        [idleImages addObject:image];
    }
    return idleImages;
}
+ (NSArray *)getGifImageFirst {
    NSMutableArray *idleImages = [[NSMutableArray alloc] init];
    //这块为你刷新时出现的gif图 需要循环添加到数组中
    UIImage *temImage = [UIImage imageNamed:@"refresh_pic1"];
    UIImage *image = [Global imageWithImageSimple:temImage scaledToSize:CGSizeMake(30, 30)];
    [idleImages addObject:image];
    return idleImages;
}
+ (NSArray *)getGifImageSecond {
    NSMutableArray *idleImages = [[NSMutableArray alloc] init];
    //这块为你刷新时出现的gif图 需要循环添加到数组中
    UIImage *temImage = [UIImage imageNamed:@"refresh_pic1"];
    UIImage *image = [Global imageWithImageSimple:temImage scaledToSize:CGSizeMake(30, 30)];
    [idleImages addObject:image];
    return idleImages;
}

#pragma mark -- 地址url 转image ,image转base64遍码
+ (UIImage *)downloaderImg:(NSString *)urlStr
{
    __block UIImage *imageIcon = nil;
    if ([urlStr length]==0) {
        return imageIcon;
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSError *downloadError = nil;
    NSData *imageData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&downloadError];
    
    if (downloadError == nil && imageData != nil) {
        imageIcon = [UIImage imageWithData:imageData];
    }else if (downloadError != nil){
        NSLog(@"Error happened = %@", downloadError);
    }else {
        NSLog(@"No data could get downloaded from the URL.");
    }

    return imageIcon;
}

+ (NSString *)encodeBase64WithImage:(UIImage *)origrinImage
{
    NSString *_encodedImageStr = @"";
    // 把图片转换为Base64的字符串
    if (!origrinImage) {
        return _encodedImageStr;
    }
    NSData *_data = UIImagePNGRepresentation(origrinImage);
    _encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return _encodedImageStr;
}

+ (UIImage *)decodedImageWithImageStr:(NSString *)origrinImageStr
{
    UIImage *_decodedImage =  nil;
    if ([origrinImageStr length]==0) {
        return _decodedImage;
    }
    // 把Base64的字符串转换为图片
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64EncodedString:origrinImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    _decodedImage = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}

#pragma mark -- tabbar 五个标的读取－－

+ (void)saveImageArray:(NSDictionary *)saveDataDic
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [DocumentsPath stringByAppendingPathComponent:@"data.plist"];
    BOOL tabbarIconHave = [[NSFileManager defaultManager] fileExistsAtPath:filepath];
    
    if (tabbarIconHave)
    {
        NSLog(@"tabbarIconHave already have");
        // delete
        BOOL tabbarDele = [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
        if (tabbarDele) {
            NSLog(@"tabbarDele dele success");
        }else {
            NSLog(@"tabbarDele dele fail");
        }
    }
    // 2.组装存储数据
    BOOL writeSuccess = [saveDataDic writeToFile:filepath atomically:YES];
    if (writeSuccess) {
        NSLog(@"tabbarDele write success");
    }else {
        NSLog(@"tabbarDele write fail");
    }
}

+ (NSDictionary *)readImageArray
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [DocumentsPath stringByAppendingPathComponent:@"data.plist"];
    if (!filepath) {
        return nil;
    }
    // 2.读取数据
    NSDictionary *sourceDataDic = [[NSDictionary alloc] initWithContentsOfFile:filepath];
    return sourceDataDic;
}
//存储ordercode
+ (void)saveOrderCodeArray:(NSMutableDictionary *)saveDataDic
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [DocumentsPath stringByAppendingPathComponent:@"orderCode.plist"];
//    BOOL tabbarIconHave = [[NSFileManager defaultManager] fileExistsAtPath:filepath];
    
//    if (tabbarIconHave)
//    {
//        NSLog(@"tabbarIconHave already have");
//        // delete
//        BOOL tabbarDele = [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
//        if (tabbarDele) {
//            NSLog(@"tabbarDele dele success");
//        }else {
//            NSLog(@"tabbarDele dele fail");
//        }
//    }
    // 2.组装存储数据
    BOOL writeSuccess = [saveDataDic writeToFile:filepath atomically:YES];
    if (writeSuccess) {
        NSLog(@"tabbarDele write success");
    }else {
        NSLog(@"tabbarDele write fail");
    }
}
+ (NSMutableDictionary *)readOrderCodeArray
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [DocumentsPath stringByAppendingPathComponent:@"orderCode.plist"];
    if (!filepath) {
        return nil;
    }
    // 2.读取数据
    NSMutableDictionary *sourceDataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    return sourceDataDic?:[[NSMutableDictionary alloc] initWithCapacity:0];
}

+ (BOOL)jumpIphoneSettingPage:(UIView *)showOnView
{
    if (SYSTEM_VERSION_LOWWER_THAN_OR_EQUAL_TO(@"10.0")) {
        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:@"prefs:root="]];
        return YES;
    } else {
        if (showOnView) {
            [Global promptMessage:@"请前往设置里去修改" inView:showOnView];
        }
        return NO;
    }
}

+ (void)openSettingsURLString
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

+ (NSString *)chineseWithArabString:(NSString *)arabStr {
    NSArray *arab_numbers = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_strs = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"〇"];
    NSArray *digits = @[@"", @"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *tranDict = [NSDictionary dictionaryWithObjects:chinese_strs forKeys:arab_numbers];
    NSString *chineseStr = @"";
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < arabStr.length; i++) {
        NSString *subStr = [arabStr substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [tranDict objectForKey:subStr];
        NSString *b = digits[arabStr.length - i - 1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_strs[9]]) {
            if ([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]]) {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_strs[9]]) {
                    [sums removeLastObject];
                }
            } else {
                sum = chinese_strs[9];
            }
            
            if ([[sums lastObject] isEqualToString:sum]) {
                continue;
            }
        }
        [sums addObject:sum];
    }
    chineseStr = [sums componentsJoinedByString:@""];
    
    return chineseStr;
}


+ (NSURL *)readPDFFileWithDocumentRef:(NSData *)documentRef
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    if (!docDir) {
        NSLog(@"Documents 目录未找到");
    }
    NSString *filePath = [docDir stringByAppendingPathComponent:@"电子发票.pdf"];
    [documentRef writeToFile:filePath atomically:YES];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    return url;
}
//+ (void)transformEncodingFromFilePath:(NSString *)filePath{
//    //调用上述转码方法获取正常字符串
//    NSString *body = [self examineTheFilePathStr:filePath];
//    //转换为二进制
//    NSData *data = [body dataUsingEncoding:NSUTF16StringEncoding];
//    //覆盖原来的文件
//    [data writeToFile:filePath atomically:YES];
//    //此时在读取该文件，就是正常格式啦
//}
//+ (NSString *)examineTheFilePathStr:(NSString *)str{
//    NSStringEncoding *useEncodeing = nil;
//    //带编码头的如utf-8等，这里会识别出来
//    NSString *body = [NSString stringWithContentsOfFile:str usedEncoding:useEncodeing error:nil];
//    //识别不到，按GBK编码再解码一次.这里不能先按GB18030解码，否则会出现整个文档无换行bug
//    if (!body) {
//        body = [NSString stringWithContentsOfFile:str encoding:0x80000632 error:nil];
//    }
//    //还是识别不到，按GB18030编码再解码一次.
//    if (!body) {
//        body = [NSString stringWithContentsOfFile:str encoding:0x80000631 error:nil];
//    }
//    
//    return body;//有值代表需要转换  为空表示不需要转换
//}


+ (NSString *)pathForSourceFileName:(NSString *)fileName withType:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cjh_setting" ofType:@"plist"];
    return path;
}

+ (NSString *)getGameCnforString:(NSString *)str {
    if ([str isEqualToString:@"football_9"]) {
        return @"胜负彩/任选九";
    }else if ([str isEqualToString:@"qxc"]) {
        return @"七星彩";
    }else if ([str isEqualToString:@"ssc"]) {
        return @"时时彩";
    }else if ([str isEqualToString:@"hbkuai3"]) {
        return @"湖北快3";
    }else if ([str isEqualToString:@"d11"]) {
        return @"11选5";
    }else if ([str isEqualToString:@"jxssc"]) {
        return @"时时彩";
    }else if ([str isEqualToString:@"jxd11"]) {
        return @"老11选5";
    }else if ([str isEqualToString:@"feiyu"]) {
        return @"新排列3";
    }else if ([str isEqualToString:@"kl10"]) {
        return @"快乐10分";
    }else if ([str isEqualToString:@"football_sfc"]) {
        return @"胜负彩/任选九";
    }else if ([str isEqualToString:@"hljd11"]) {
        return @"易乐11选5";
    }else if ([str isEqualToString:@"kl8"]) {
        return @"排列8";
    }else if ([str isEqualToString:@"gxkuai3"]) {
        return @"新快3";
    }else if ([str isEqualToString:@"lnd11"]) {
        return @"辽宁11选5";
    }else if ([str isEqualToString:@"ssq"]) {
        return @"双色球";
    }else if ([str isEqualToString:@"gdd11"]) {
        return @"粤11选5";
    }else if ([str isEqualToString:@"ahkuai3"]) {
        return @"好运快3";
    }else if ([str isEqualToString:@"dlt"]) {
        return @"大乐透";
    }else if ([str isEqualToString:@"nmgkuai3"]) {
        return @"易快3";
    }else if ([str isEqualToString:@"zjd11"]) {
        return @"易乐11选5";
    }else if ([str isEqualToString:@"x3d"]) {
        return @"江苏排列3";
    }else if ([str isEqualToString:@"pl5"]) {
        return @"排列5";
    }else if ([str isEqualToString:@"qlc"]) {
        return @"七乐彩";
    }else if ([str isEqualToString:@"kuai3"]) {
        return @"快3";
    }else if ([str isEqualToString:@"pl3"]) {
        return @"排列3";
    }else if ([str isEqualToString:@"klpk"]) {
        return @"";
    }else if ([str isEqualToString:@"oldkuai3"]){
        return @"老快3";
    }
    return @"";
}
+ (NSString *)dataStringForString:(NSString *)string {
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate *date2 = [formatter dateFromString:string];
    [formatter setDateFormat:@"YYYY.MM.dd"];
    NSString *dateTime=[formatter stringFromDate:date2];
    return dateTime;
}


+(NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}
#pragma mark 生成image
+ (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}  
@end
