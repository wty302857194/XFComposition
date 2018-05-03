//
//  PublicTextTitleRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/30.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^PublicTextTitleBlock)(NSDictionary *);
@interface PublicTextTitleRequst : NSObject
-(void)PublicTextTitleRequstwithGroupId :(NSString *)GroupIds withPageId :(NSString *)PageId withuserid :(NSString *)userid :(PublicTextTitleBlock)block;
@end
