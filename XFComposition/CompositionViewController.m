//
//  CompositionViewController.m
//  XFComposition
//
//  Created by longrise on 2018/4/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import "CompositionViewController.h"
#import "KKImageEditorViewController.h"

@interface CompositionViewController ()<KKImageEditorDelegate>

@end

@implementation CompositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str = [NSString stringWithFormat:@"%@%@",HTurl,self.PicUrl];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    UIImage *image = [UIImage imageWithData:data];
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
