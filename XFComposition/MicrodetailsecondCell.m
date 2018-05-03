//
//  MicrodetailsecondCell.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/12.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MicrodetailsecondCell.h"
#import "MicroSecondCell.h"
#import "MicroPianduanCell.h"
#import "MicrozuowenCell.h"
#import "MicrojiaoliuCell.h"

#import "MicrobenkexizuoCell.h"
#import "MicroVideoModel.h"
#import "MicroWriteModel.h"
#import "MicPianduanmodel.h"

#import "GetCommentListModel.h"
#import "CommwritelistModel.h"
#import "DianPingModel.h"
@interface MicrodetailsecondCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITextView *textView;
@end
@implementation MicrodetailsecondCell
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, WidthFrame, 120) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MicroSecondCell class] forCellReuseIdentifier:@"cell0"];
        [_tableView registerClass:[MicroPianduanCell class] forCellReuseIdentifier:@"cell1"];
        [_tableView registerClass:[MicrozuowenCell class] forCellReuseIdentifier:@"cell2"];
        
        [_tableView registerClass:[MicrobenkexizuoCell class] forCellReuseIdentifier:@"cell4"];
        [_tableView registerClass:[MicrojiaoliuCell class] forCellReuseIdentifier:@"cell5"];
        

    }
    return _tableView;

}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
    }
    return self;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([self.IF isEqualToString:@"0"]) {
        MicroSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
        MicroVideoModel *model = self.dagangArray[indexPath.row];
        cell.label1.text = [NSString stringWithFormat:@"%ld.%@",(long)(indexPath.row+1),model.title];
        cell.label2.text = [NSString stringWithFormat:@"时长：[%@]",model.playlength] ;
        return cell;
        
    }else if ([self.IF isEqualToString:@"1"]){
        MicroPianduanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        MicPianduanmodel *model = self.dagangArray[indexPath.row];
        if ([model.BlogStatic isEqualToString:@"1"]) {
            cell.label1.text = @"[锁定]";
            cell.label1.textColor = UIColorFromRGBA(0, 255, 127, 1.0f);
        }else if ([model.BlogStatic isEqualToString:@"0"]){
            cell.label1.text = @"[未锁定]";
            cell.label1.textColor = [UIColor redColor];
        
        }
        cell.label2.text = model.BlogTitle;
        return cell;

    }else if ([self.IF isEqualToString:@"2"]){
        MicrozuowenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        MicPianduanmodel *model = self.dagangArray[indexPath.row];
        
        if ([model.BlogStatic isEqualToString:@"1"]) {
            cell.label1.text = @"[已保存]";
            cell.label1.textColor = UIColorFromRGBA(0, 255, 127, 1.0f);
        }else if ([model.BlogStatic isEqualToString:@"0"]){
            cell.label1.text = @"[未保存]";
            cell.label1.textColor = [UIColor redColor];
        }
        
        if ([model.BlogBg isEqualToString:@"1"]) {
            cell.label2.text = @"[已提交]";
            cell.label2.textColor = UIColorFromRGBA(0, 255, 127, 1.0f);
        }else if ([model.BlogBg isEqualToString:@"0"]){
            cell.label2.text = @"[未提交]";
            cell.label2.textColor = [UIColor redColor];
        }
        
        
        cell.label3.text = model.BlogTitle;
        return cell;
        
    }else if ([self.IF isEqualToString:@"3"]){
        MicrojiaoliuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5" forIndexPath:indexPath];
        GetCommentListModel *Model = self.dagangArray[indexPath.row];
        cell.model = Model;
        
        
        return cell;
    }
    else if([self.IF isEqualToString:@"4"]){
        MicrobenkexizuoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4" forIndexPath:indexPath];
        CommwritelistModel *model = self.dagangArray[indexPath.row];
        cell.label1.text = [NSString stringWithFormat:@"《%@》",model.BlogTitle];
        cell.label2.text = [NSString stringWithFormat:@"%@",model.BlogAddTime] ;
    
        return cell;
    }else if ([self.IF isEqualToString:@"5"]){
        MicrojiaoliuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5" forIndexPath:indexPath];
        DianPingModel *model = self.dagangArray[indexPath.row];
        NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,model.DPid];
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"icon_02"] options:SDWebImageRefreshCached];
        cell.teacherlable.text = model.username;
        cell.timeLabel.text = model.checktime;
        return cell;
        
    }
    
        return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.IF isEqualToString:@"1"]) {
        return 30;
    }else if([self.IF isEqualToString:@"3"]){
//        return 80;
        GetCommentListModel *Model = self.dagangArray[indexPath.row];
        return [self.tableView cellHeightForIndexPath:indexPath model:Model keyPath:@"model" cellClass:[MicrojiaoliuCell class] contentViewWidth:[self cellContentViewWith]];
        
    }else if([self.IF isEqualToString:@"5"]){
        return 40;
        
    }
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return self.dagangArray.count;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([self.IF isEqualToString:@"3"]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 30)];
        self.textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 5, WidthFrame-40, 100)];
        
        self.textView.backgroundColor = [UIColor lightGrayColor];
        [view addSubview:self.textView];
        UIButton *leftbt = [[UIButton alloc]initWithFrame:CGRectMake(WidthFrame-60-20, 110, 60, 20)];
        [leftbt setTitle:@"我要评论" forState:UIControlStateNormal];
        leftbt.titleLabel.font = [UIFont systemFontOfSize:10];
        [leftbt setBackgroundColor:[UIColor colorWithHexString:@"41A4DF"]];
        leftbt.layer.cornerRadius = 4;
        leftbt.layer.masksToBounds = YES;
        [leftbt addTarget:self action:@selector(pinglun) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:leftbt];
        
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([self.IF isEqualToString:@"3"]) {
        return 140;
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([self.IF isEqualToString:@"1"]) {
        
        
        
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 30)];
        UIButton *leftbt = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 60, 20)];
        [leftbt setTitle:@"添加段落" forState:UIControlStateNormal];
        leftbt.titleLabel.font = [UIFont systemFontOfSize:10];
        leftbt.layer.cornerRadius = 4;
        leftbt.layer.masksToBounds = YES;
        [leftbt setBackgroundColor:[UIColor colorWithHexString:@"41A4DF"]];
        [leftbt addTarget:self action:@selector(tianjia) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:leftbt];
        
        
        UIButton *rightbt = [[UIButton alloc]initWithFrame:CGRectMake(WidthFrame-80-10, 10, 80, 20)];
        [rightbt setTitle:@"锁定并合并对象" forState:UIControlStateNormal];
        [rightbt setBackgroundColor:[UIColor colorWithHexString:@"41A4DF"]];
        rightbt.titleLabel.font = [UIFont systemFontOfSize:10];
        rightbt.layer.cornerRadius = 4;
        rightbt.layer.masksToBounds = YES;
        [rightbt addTarget:self action:@selector(hebing) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:rightbt];
        
        return view;
        
    }else if ([self.IF isEqualToString:@"2"]) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, 30)];
        UIButton *leftbt = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 80, 20)];
        [leftbt setTitle:@"新建作文" forState:UIControlStateNormal];
        leftbt.titleLabel.font = [UIFont systemFontOfSize:10];
        [leftbt setBackgroundColor:[UIColor colorWithHexString:@"41A4DF"]];
        leftbt.layer.cornerRadius = 4;
        leftbt.layer.masksToBounds = YES;
        [leftbt addTarget:self action:@selector(xinjianzuowen) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:leftbt];
        
        
        UIButton *midbt = [[UIButton alloc]initWithFrame:CGRectMake(110, 10, 80, 20)];
        [midbt setTitle:@"保存作文" forState:UIControlStateNormal];
        midbt.titleLabel.font = [UIFont systemFontOfSize:9];
        [midbt setBackgroundColor:[UIColor colorWithHexString:@"41A4DF"]];
        midbt.layer.cornerRadius = 4;
        midbt.layer.masksToBounds = YES;
        [midbt addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:midbt];
        
        UIButton *rightbt = [[UIButton alloc]initWithFrame:CGRectMake(WidthFrame-80-20, 10, 80, 20)];
        [rightbt setTitle:@"提交老师" forState:UIControlStateNormal];
        [rightbt setBackgroundColor:[UIColor colorWithHexString:@"41A4DF"]];
        rightbt.titleLabel.font = [UIFont systemFontOfSize:9];
        [rightbt addTarget:self action:@selector(tijiaolaoshi) forControlEvents:UIControlEventTouchUpInside];
        rightbt.layer.cornerRadius = 4;
        rightbt.layer.masksToBounds = YES;
        [view addSubview:rightbt];
        
        return view;
        
        
        
    }
        
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.IF isEqualToString:@"1"]) {
        if ([self.showViewdelegate respondsToSelector:@selector(showPiandian:)]) {
            [self.showViewdelegate showPiandian:indexPath];
        }
    }else if ([self.IF isEqualToString:@"2"]){
        if ([self.showViewdelegate respondsToSelector:@selector(showzuowen:)]) {
            [self.showViewdelegate showzuowen:indexPath];
        }
    
    }

}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
//添加段落
-(void)tianjia{
    
    if ([self.delegate respondsToSelector:@selector(addcomment)]) {
        [self.delegate addcomment];
    }
    
}
//合并锁定
-(void)hebing{
    if ([self.delegate respondsToSelector:@selector(merge)]) {
        [self.delegate merge];
    }

}
//新建作文
-(void)xinjianzuowen{
    if ([self.delegate respondsToSelector:@selector(Newbuild)]) {
        [self.delegate Newbuild];
    }

}
//保存作文
-(void)baocun{
    if ([self.delegate respondsToSelector:@selector(SaveGJ)]) {
        [self.delegate SaveGJ];
    }

}
//提交老师
-(void)tijiaolaoshi{
    if ([self.delegate respondsToSelector:@selector(SubmittTeacher)]) {
        [self.delegate SubmittTeacher];
    }

}
//我要评论
-(void)pinglun{
    if ([self.delegate respondsToSelector:@selector(comment:)]) {
        [self.delegate comment:self.textView];
    }

}
-(void)setDagangArray:(NSMutableArray *)dagangArray{
//    NSLog(@"塞特的 ,个数%lu",(unsigned long)dagangArray.count);
//    NSLog(@"mmp的 ,个数%lu",(unsigned long)_dagangArray.count);
    _dagangArray = dagangArray;

    [self.tableView reloadData];
}
@end
