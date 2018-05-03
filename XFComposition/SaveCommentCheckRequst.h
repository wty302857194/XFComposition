//
//  SaveCommentCheckRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/10/21.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^SaveCommentCheckBlock)(NSDictionary *);
@interface SaveCommentCheckRequst : NSObject
-(void)SaveCommentCheckRequstWithRemarkID :(NSString *)RemarkID withRemark :(NSString *)Remark withuserid :(NSString *)userid withblogPicID :(NSString *)blogPicID withXLocation :(NSString *)XLocation withYLocation :(NSString *)YLocation :(SaveCommentCheckBlock)block;

- (void)XFUpdateBlogPic:(NSString *)imgid fixpic:(NSString *)fixpic :(SaveCommentCheckBlock)block;

@end
