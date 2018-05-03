//
//  UIScrollView+LCRefresh.m
//  JiZhang
//
//  Created by lc-macbook pro on 2018/3/29.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "UIScrollView+LCRefresh.h"

#define kPAGEINDEX 1
@implementation UIScrollView (LCRefresh)

const void *__pageIndex = @"__lc_pageIndex";
const void *__pageSize = @"__lc_pageSize";
const void *__islastPage = @"__lc_lastPage";


- (void)setLc_pageSize:(NSUInteger)lc_pageSize {
    objc_setAssociatedObject(self, __pageSize, @(lc_pageSize), OBJC_ASSOCIATION_RETAIN);
}


- (NSUInteger)lc_pageSize {
    NSNumber *temp = objc_getAssociatedObject(self, __pageSize);
    if (temp.integerValue) {
        return temp.integerValue;
    }else {
        return 2;
    }
}



- (void)setLc_pageIndex:(NSUInteger)lc_pageIndex {
      objc_setAssociatedObject(self, __pageIndex, @(lc_pageIndex), OBJC_ASSOCIATION_RETAIN);
}


- (NSUInteger)lc_pageIndex {
    NSString *temp = objc_getAssociatedObject(self, __pageIndex);
    if (temp.integerValue) {
        return temp.integerValue;
    }else {
        return kPAGEINDEX;
    }
}


- (void)setLc_isLastPage:(BOOL)lc_isLastPage {
    objc_setAssociatedObject(self, __islastPage, @(lc_isLastPage), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)lc_isLastPage {
    NSNumber *temp = objc_getAssociatedObject(self, __islastPage);
    if (temp.integerValue) {
        return YES;
    }else {
        return NO;
    }
}


//
//
//- (void)setLc_pageIndex:(NSString *)lc_pageIndex {
//    objc_setAssociatedObject(self, __pageIndex, lc_pageIndex, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)lc_pageIndex {
//    NSString *temp = objc_getAssociatedObject(self, __pageIndex);
//    if (temp.length) {
//        return temp;
//    }else {
//        return @"1";
//    }
//}
//
//- (void)setLc_pageSize:(NSString *)lc_pageSize {
//    objc_setAssociatedObject(self, __pageSize, lc_pageSize, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)lc_pageSize {
//    NSString *temp = objc_getAssociatedObject(self, __pageSize);
//    if (temp.length) {
//        return temp;
//    }else {
//        return @"20";
//    }
//}




- (void)lc_setRefreshWithType:(LCRefreshType)type
                  headerBlock:(MJRefreshComponentRefreshingBlock)headerBlock
                  footerBlock:(MJRefreshComponentRefreshingBlock)footerBlock {
    
    switch (type) {
        case LCRefreshFooter:
        {
            self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:footerBlock];
        }
            break;
            
        case LCRefreshHeader:
        {
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerBlock];
        }
            break;
            
        case LCRefreshHeaderAndFooter:
        {
            self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerBlock];
        
            self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:footerBlock];
        }
        default:
            break;
    }
    
    if ([self.mj_header isKindOfClass:[MJRefreshNormalHeader class]]) {
        MJRefreshNormalHeader *header = (id)self.mj_header;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
    }
}


- (void)lc_endRefresh {
    if ([self isKindOfClass:[UIScrollView class]]) {
        [self.mj_header endRefreshing];
        [self.mj_footer endRefreshing];
        
        if (self.lc_isLastPage) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.mj_footer resetNoMoreData];
        }
        [self.mj_header endRefreshing];
    }
}

- (void)lc_resetDataBeforeRefresh {
    self.lc_pageIndex = kPAGEINDEX;
    self.lc_isLastPage = YES;
    [self.mj_footer resetNoMoreData];
}

- (BOOL)lc_currentPageIsFirst  {
    return self.lc_pageIndex == kPAGEINDEX;
}
@end
