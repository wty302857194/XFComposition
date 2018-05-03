//
//  UIScrollView+LCRefresh.h
//  JiZhang
//
//  Created by lc-macbook pro on 2018/3/29.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    LCRefreshNone,
    LCRefreshHeader,
    LCRefreshFooter,
    LCRefreshHeaderAndFooter,
} LCRefreshType;

@interface UIScrollView (LCRefresh)


@property (nonatomic, assign) BOOL lc_isLastPage;

@property (nonatomic, assign) NSUInteger lc_pageIndex;
@property (nonatomic, assign) NSUInteger lc_pageSize;




//@property (nonatomic, copy) NSString *lc_pageIndex;
//@property (nonatomic, copy) NSString *lc_pageSize;


- (void)lc_setRefreshWithType:(LCRefreshType)type
                  headerBlock:(MJRefreshComponentRefreshingBlock)headerBlock
                  footerBlock:(MJRefreshComponentRefreshingBlock)footerBlock ;

- (void)lc_endRefresh;
- (void)lc_resetDataBeforeRefresh;
- (BOOL)lc_currentPageIsFirst;

@end
