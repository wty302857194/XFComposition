//
//  MicrotiajiaplRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/13.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Microtianjiainforequst)(NSDictionary *);
@interface MicrotiajiaplRequst : NSObject
-(void)MicrotianjiaPinglunWithUserid:(NSString *)userid withWeikeid:(NSString *)weikeid withUserip:(NSString *)userip withCommentinfo:(NSString *)text :(Microtianjiainforequst)block;
@end
