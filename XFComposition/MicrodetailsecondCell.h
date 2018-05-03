//
//  MicrodetailsecondCell.h
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MicrodetailsecondCell;
@protocol AddcommentDelegate <NSObject>

-(void)addcomment;
-(void)merge;


-(void)Newbuild;
-(void)SaveGJ;
-(void)SubmittTeacher;
-(void)comment :(UITextView *)textView;
@end

@protocol AddzuowenDelegate <NSObject>



@end

@protocol ShowViewDelegate <NSObject>

-(void)showPiandian:(NSIndexPath *)index;
-(void)showzuowen :(NSIndexPath *)index;
@end

@interface MicrodetailsecondCell : UICollectionViewCell
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dagangArray;
@property (nonatomic,strong)NSString *IF;
@property (nonatomic,weak)id<AddcommentDelegate>delegate;
@property (nonatomic,weak)id<ShowViewDelegate>showViewdelegate;
@end
