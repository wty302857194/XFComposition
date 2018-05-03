

//
//  BookwritingView.m
//  XFComposition
//
//  Created by 周凤喜 on 2017/9/27.
//  Copyright © 2017年 周凤喜. All rights reserved.
//

#import "BookwritingView.h"
@interface BookwritingView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UILabel *titleLabel;

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)NSString *str;
@property (nonatomic,strong)NSArray *titleArray;
@property(nonatomic, strong)NSMutableArray *selectedArray;//是否被点击
@property (nonatomic,strong)UIButton *sectionButton;

@end
@implementation BookwritingView
-(NSMutableArray *)btarray{
    if (!_btarray) {
        _btarray = [[NSMutableArray alloc]init];
    }
    return _btarray;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
        self.xingji = @"0";
        UILabel *titleLabel= [[UILabel alloc]initWithFrame:CGRectMake(20, 84, 50, 20)];
        titleLabel.text = @"标题：";
        titleLabel.font = [UIFont systemFontOfSize:16];
        
        [self addSubview:titleLabel];
        
        self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+5, 79, WidthFrame-70-40, 30)];
        self.textfield.placeholder = @"标题";
//        self.textfield.layer.cornerRadius = 4;
//        self.textfield.layer.masksToBounds = YES;
        self.textfield.layer.borderWidth = 1;
        self.textfield.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        [self addSubview:self.textfield];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+20, 60, 20)];
        label1.text = @"正文：";
        label1.font = [UIFont systemFontOfSize:16];
        [self addSubview:label1];
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(80, CGRectGetMaxY(titleLabel.frame)+20, WidthFrame-100, 20)];
        label2.text = @"*点击上传作文照片";
        label2.textColor = [UIColor lightGrayColor];
        label2.font = [UIFont systemFontOfSize:11];
        [self addSubview:label2];
        int z=0;
        float btW = (WidthFrame-100)/3;
        for (int i = 0; i<2; i++) {
            for (int j = 0; j<3; j++) {
                UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
                bt.frame = CGRectMake(20+(btW+30)*j, CGRectGetMaxY(label2.frame)+20+(btW+20)*i, btW, btW);
                bt.tag = 1000 +z;
                [bt setTitle:@"点击添加" forState:UIControlStateNormal];

                [bt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [bt setBackgroundColor:[UIColor lightGrayColor]];
                [self addSubview:bt];
                
                z++;
                [self.btarray addObject:bt];
            }
        }

        UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectZero];
        label3.text = @"注意：提交作文申请批阅将消耗您2个先锋币，您可以选择不同的志愿者教师，进行点评，过程圆满结束，消耗先锋币，您的作文未通过审核或未被点评，系统将退还您的先锋币。";
        label3.lineBreakMode = NSLineBreakByWordWrapping;
        label3.textColor = [UIColor lightGrayColor];
        label3.numberOfLines = 0;
        label3.font = [UIFont systemFontOfSize:12];
        CGRect textframe = label3.frame;
        CGSize size = CGSizeMake(WidthFrame-40, HeightFrame);
        CGSize h = [self getsizeWith:label3 :[UIFont systemFontOfSize:12] :size :textframe];
        
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:label3.font, NSFontAttributeName,nil];
//        textframe.size.height = [label3.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
        label3.frame = CGRectMake(20, CGRectGetMaxY(label1.frame)+btW*2+60, WidthFrame-40, h.height);
        
        

        [self addSubview:label3];
        
        UILabel *lable4 = [[UILabel alloc]init];
        lable4.text = @"点评教师等级";
        CGSize size2 = [self getsizeWith:lable4 :[UIFont systemFontOfSize:13] :size :CGRectZero];
        lable4.frame = CGRectMake(20, CGRectGetMaxY(label3.frame)+20, size2.width, 30);
        [self addSubview:lable4];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lable4.frame)+2 ,CGRectGetMaxY(label3.frame)+20 , 100, 160)style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = UIColorFromRGBA(240, 255, 255, 1.0f);
        self.tableView.tableFooterView = [[UIView alloc]init];
        self.str = @"系统分配";
//        self.tableView.layer.borderWidth = 1;
//        self.tableView.layer.borderColor = [[UIColor lightGrayColor]CGColor]
        
        _titleArray = [NSArray arrayWithObjects:@"一星教师",@"二星教师",@"三星教师",@"四星教师",@"五星教师", nil];
        _selectedArray = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];//这个用于判断展开还是缩回当前
        [self addSubview:self.tableView];
        
        
        UIButton *baocunBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [baocunBt setTitle:@"保存" forState:UIControlStateNormal];
        [baocunBt setBackgroundColor:[UIColor blueColor]];
        [baocunBt setBackgroundColor:[UIColor colorWithHexString:@"3791CD"]];
        baocunBt.layer.cornerRadius = 4;
        baocunBt.layer.masksToBounds = YES;
        [baocunBt addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
        baocunBt.frame = CGRectMake(WidthFrame/3, HeightFrame-60, WidthFrame/3, 40);
        [self addSubview:baocunBt];
        
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
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = _titleArray[indexPath.row];
    
    
    
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
    if ([_selectedArray[section] isEqualToString:@"1"]) {
        return _titleArray.count;
    }
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
    sectionView.backgroundColor = [UIColor whiteColor];
    self.sectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sectionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.sectionButton.tag = 1000;
    [self.sectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.sectionButton.frame = sectionView.frame;
    self.sectionButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.sectionButton setTitle:self.str forState:UIControlStateNormal];

    [sectionView addSubview:self.sectionButton];
    return sectionView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.str = self.titleArray[indexPath.row];
    if (indexPath.row == 0) {
        self.xingji = @"1";
    }else if(indexPath.row == 1){
        self.xingji = @"2";
    }else if(indexPath.row == 2){
        self.xingji = @"3";
    }else if(indexPath.row == 3){
        self.xingji = @"4";
    }else if(indexPath.row == 4){
        self.xingji = @"5";
    }
    [_selectedArray replaceObjectAtIndex:0 withObject:@"0"];
    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
}
#pragma mark button点击方法
-(void)buttonAction:(UIButton *)button
{
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
}
-(void)click:(UIButton *)bt{
    if ([self.delegate respondsToSelector:@selector(didsome:)]) {
        [self.delegate didsome:bt];
    }
    
}
-(void)baocun{
    if ([self.delegate respondsToSelector:@selector(didSave)]) {
        [self.delegate didSave];
    }
}
-(CGSize)getsizeWith :(UILabel *)label :(UIFont *)font :(CGSize)size :(CGRect)rect{
//    CGSize size = CGSizeMake(WidthFrame-40, HeightFrame);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:label.font, NSFontAttributeName,nil];
    rect.size = [label.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return rect.size;
}
@end
