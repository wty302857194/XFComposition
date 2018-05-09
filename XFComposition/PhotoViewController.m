//
//  PhotoViewController.m
//  XFComposition
//
//  Created by chenshunyi on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *picImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"习作";
    
    self.topConstraint.constant = SafeAreaTopHeight;
    
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HTurl,self.picUrl]]];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self leftBarButton];
}

-(void)leftBarButton{
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"left-arrow_s"] style: UIBarButtonItemStylePlain target:self action:@selector(onBack)];
    self.navigationItem.leftBarButtonItem=item;
}
-(void)onBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
