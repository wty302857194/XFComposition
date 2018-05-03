//
//  SubmissionHeadView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/20.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "SubmissionHeadView.h"
@interface SubmissionHeadView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)UITableView *tableView2;
@property(nonatomic, strong)UITableView *tableView3;

@property(nonatomic, strong)NSMutableArray *selectedArray;//是否被点击
@property(nonatomic, strong)NSMutableArray *selectedArray2;//是否被点击
@property(nonatomic, strong)NSMutableArray *selectedArray3;//是否被点击

@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSArray *titleArray2;
@property (nonatomic,strong)NSArray *titleArray3;

@property (nonatomic,strong)UIButton *sectionButton;
@property (nonatomic,strong)NSString *str;
@property (nonatomic,strong)NSString *str2;
@property (nonatomic,strong)NSString *str3;

@end
@implementation SubmissionHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 20, 20)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:imageView];
        self.str = @"作品类别";
        self.str2 = @"作品状态";
        self.str3 = @"请选择圈子";
        _selectedArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];//这个用于判断展开还是缩回当前section的cell
        _selectedArray2 = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];//这个用于判断展开还是缩回当前section的cell
        _selectedArray3 = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];//这个用于判断展开还是缩回当前section的cell
        _titleArray = [NSArray arrayWithObjects:@"征文",@"投稿", nil];
        _titleArray2 = [NSArray arrayWithObjects:@"待审核",@"没有入库",@"入库", nil];
        _titleArray3 = [NSArray arrayWithObjects:@"测试圈子",@"我的圈子",@"测试33", nil];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(50 ,0 , 100, 160)style:UITableViewStylePlain];
        self.tableView.tableFooterView = [[UIView alloc]init];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
//        self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@""
        [self addSubview:self.tableView];
        
        self.tableView2 = [[UITableView alloc]initWithFrame:CGRectMake(160 ,0 , 100, 160)style:UITableViewStylePlain];
        self.tableView2.tableFooterView = [[UIView alloc]init];
        self.tableView2.delegate = self;
        self.tableView2.dataSource = self;
        self.tableView2.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        [self addSubview:self.tableView2];
        
        self.tableView3 = [[UITableView alloc]initWithFrame:CGRectMake(270 ,0 , 100, 160)style:UITableViewStylePlain];
        self.tableView3.tableFooterView = [[UIView alloc]init];
        self.tableView3.delegate = self;
        self.tableView3.dataSource = self;
        self.tableView3.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        [self addSubview:self.tableView3];

    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    if (tableView == self.tableView) {
        cell.textLabel.text = _titleArray[indexPath.row];
    }else if (tableView == self.tableView2){
        cell.textLabel.text = _titleArray2[indexPath.row];
    }else if (tableView == self.tableView3){
        cell.textLabel.text = _titleArray3[indexPath.row];
    }
    
    return cell;
}

#pragma mark section的个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark cell的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        if ([_selectedArray[section] isEqualToString:@"1"]) {
            return _titleArray.count;
        }
    }else if (tableView == self.tableView2) {
        if ([_selectedArray2[section] isEqualToString:@"1"]) {
            return _titleArray2.count;
        }
    }else if (tableView == self.tableView3) {
        if ([_selectedArray3[section] isEqualToString:@"1"]) {
            return _titleArray3.count;
        }
    }
    //判断section的标记是否为1,如果是说明为展开,就返回真实个数,如果不是就说明是缩回,返回0.
    
    
    return 0;
}

#pragma cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma mark - section内容
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    sectionView.backgroundColor = [UIColor cyanColor];
    self.sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.sectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.sectionButton.frame = sectionView.frame;
    self.sectionButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [sectionView addSubview:self.sectionButton];
    if (tableView == self.tableView) {
        //每个section上面有一个button,给button一个tag值,用于在点击事件中改变_selectedArray[button.tag - 1000]的值
        
        [self.sectionButton setTitle:self.str forState:UIControlStateNormal];
        
        self.sectionButton.tag = 1000;
        
        return sectionView;
        
    }else if (tableView == self.tableView2) {
        //每个section上面有一个button,给button一个tag值,用于在点击事件中改变_selectedArray[button.tag - 1000]的值
        [self.sectionButton setTitle:self.str2 forState:UIControlStateNormal];
        
        self.sectionButton.tag = 1001;
        
        return sectionView;
        
    }else if (tableView == self.tableView3) {
        //每个section上面有一个button,给button一个tag值,用于在点击事件中改变_selectedArray[button.tag - 1000]的值
        [self.sectionButton setTitle:self.str3 forState:UIControlStateNormal];
        
        self.sectionButton.tag = 1002;
        
        return sectionView;
        
    }
    
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableView){
        
        if (self.sectionButton.tag ==1000) {
            self.str = self.titleArray[indexPath.row];
            //            [self.sectionButton setTitle:self.titleArray[indexPath.row] forState:UIControlStateNormal];
        }
        [_selectedArray replaceObjectAtIndex:0 withObject:@"0"];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }else if (tableView == self.tableView2){
        if (self.sectionButton.tag ==1001) {
            self.str2 = self.titleArray2[indexPath.row];
            
        }
        [_selectedArray2 replaceObjectAtIndex:0 withObject:@"0"];
        [_tableView2 reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        
    }else if (tableView == self.tableView3){
        if (self.sectionButton.tag ==1002) {
            self.str3 = self.titleArray3[indexPath.row];
            
        }
        [_selectedArray3 replaceObjectAtIndex:0 withObject:@"0"];
        [_tableView3 reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    if ([self.delegate respondsToSelector:@selector(reshData: : :)]) {
        [self.delegate reshData :self.str : self.str2 :self.str3];
    }
    
}
#pragma mark button点击方法
-(void)buttonAction:(UIButton *)button
{
    if (button.tag == 1000) {
        if ([_selectedArray[button.tag - 1000] isEqualToString:@"0"]) {
            
            //如果当前点击的section是缩回的,那么点击后就需要把它展开,是_selectedArray对应的值为1,这样当前section返回cell的个数就变为真实个数,然后刷新这个section就行了
            
            [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"1"];
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
            [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"0"];
            [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        
    }else if (button.tag == 1001){
        if ([_selectedArray2[button.tag - 1001] isEqualToString:@"0"]) {
            
            //如果当前点击的section是缩回的,那么点击后就需要把它展开,是_selectedArray对应的值为1,这样当前section返回cell的个数就变为真实个数,然后刷新这个section就行了
            [_selectedArray2 replaceObjectAtIndex:button.tag - 1001 withObject:@"1"];
            [_tableView2 reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1001] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
            [_selectedArray2 replaceObjectAtIndex:button.tag - 1001 withObject:@"0"];
            [_tableView2 reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1001] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        
    }else if (button.tag == 1002){
        if ([_selectedArray3[button.tag - 1002] isEqualToString:@"0"]) {
            
            //如果当前点击的section是缩回的,那么点击后就需要把它展开,是_selectedArray对应的值为1,这样当前section返回cell的个数就变为真实个数,然后刷新这个section就行了
            [_selectedArray3 replaceObjectAtIndex:button.tag - 1002 withObject:@"1"];
            [_tableView3 reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1002] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
            [_selectedArray3 replaceObjectAtIndex:button.tag - 1002 withObject:@"0"];
            [_tableView3 reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1002] withRowAnimation:UITableViewRowAnimationFade];
        }
        
        
    }
    
    
}



@end
