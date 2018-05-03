//
//  MyView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/8/29.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "MyView.h"
#import "MyFristTableViewCell.h"
#import "MySecondTableViewCell.h"
#import "MyThridTableViewCell.h"
#import "MyFourTableViewCell.h"
@interface MyView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSArray *array1;
@property (nonatomic,strong)NSArray *array2;
@property (nonatomic,strong)NSArray *array3;
@end
@implementation MyView
-(NSArray *)array1{
    if (!_array1) {
//        _array1 = @[@[@"个人中心",@"推荐图书",@"我的习作"],@[@"做题笔记",@"读书笔记"],@[@"我的微课",@"我的圈子",@"更多服务"]];
        _array1 =@[@"个人中心",@"推荐图书",@"我的习作",@"做题笔记",@"读书笔记",@"我的微课",@"我的圈子",@"更多服务"];
    }
    return _array1;
}
-(NSArray *)array2{
    if (!_array2) {
//        _array2 = @[@[@"个人中心",@"推荐图书",@"我的习作"],@[@"做题笔记",@"读书笔记"],@[@"我的微课",@"我的圈子",@"更多服务"]];
        _array2 =@[@"做题笔记",@"读书笔记"];
    }
    return _array2;
}
-(NSArray *)array3{
    if (!_array2) {
//        _array3 = @[@[@"个人中心",@"推荐图书",@"我的习作"],@[@"做题笔记",@"读书笔记"],@[@"我的微课",@"我的圈子",@"更多服务"]];
        _array3 =@[@"我的微课",@"我的圈子",@"更多服务"];
    }
    return _array3;
//    http://xf.vqune.com/web/style/img01.jpg
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WidthFrame, HeightFrame)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[MyFristTableViewCell class] forCellReuseIdentifier:@"cellFrist"];
        [_tableView registerClass:[MySecondTableViewCell class] forCellReuseIdentifier:@"cellSecond"];
        [_tableView registerClass:[MyThridTableViewCell class] forCellReuseIdentifier:@"cellThrid"];
    }
    return _tableView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.tableView];
    }
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return  1;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return  3;
    }else if (section == 3){
        return 2;
    }
    else if (section == 4){
        return 3;
    }
    else {
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MyFristTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellFrist" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        MySecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellSecond" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }else if (indexPath.section == 5){
        
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *loginbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [loginbutton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
        [loginbutton setTitle:@"退出" forState:UIControlStateNormal];
        loginbutton.frame = CGRectMake(WidthFrame/2-50, 10, 100, 30);
        loginbutton.backgroundColor = UIColorFromRGBA(65, 105, 225, 1.0f);
        loginbutton.layer.cornerRadius = 6;
        loginbutton.clipsToBounds = YES;
        [cell addSubview:loginbutton];
        
        return cell;
    }
    
    else {
        MyThridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellThrid" forIndexPath:indexPath];
        return cell;
    }
        
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else if (indexPath.section == 1){
        return 40;
    }else if (indexPath.section == 2){
        return 40;
    }else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2;
}

-(void)login{
    NSUserDefaults *appDefatult=[NSUserDefaults standardUserDefaults];
    [appDefatult removeObjectForKey:@"ccc"];
    [appDefatult synchronize];//同步
    appDefatult=nil;
//    self.tabBarController.selectedIndex=0;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
