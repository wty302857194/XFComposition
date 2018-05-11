//
//  TYImageEditViewController.m
//  MyPracticeViewController
//
//  Created by wbb on 2018/5/11.
//  Copyright © 2018年 cjh. All rights reserved.
//

#import "TYImageEditViewController.h"

@interface TYImageEditViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TYImageEditViewController
- (IBAction)yuYin:(UIButton *)sender {
    switch (sender.tag) {
        case 10://语音
        {
            
        }
            break;
        case 11://截图
        {
            
        }
            break;
        case 12://旁批
        {
            
        }
            break;
        case 13://手绘
        {
            
        }
            break;
        case 14://撤销
        {
            
        }
            break;
        case 15://tableview
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
