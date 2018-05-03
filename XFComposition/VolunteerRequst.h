//
//  VolunteerRequst.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/6.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^Volunteerrequst)(NSDictionary *);

@interface VolunteerRequst : NSObject
-(void)GetVolunteerRequstWithpagesize :(NSInteger )index :(NSString *)pagesize WithAcitivieTypeID:(NSString *)type :(Volunteerrequst)block;
- (void)GetBlogHaojuWithBlogid:(NSInteger)blogid :(Volunteerrequst)block;
- (void)GetNewsList:(Volunteerrequst)block;
@end
