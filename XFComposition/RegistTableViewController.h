//
//  RegistTableViewController.h
//  XFComposition
//
//  Created by wbb on 2018/5/8.
//  Copyright © 2018年 周凤喜. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIView *pswTF;
@property (weak, nonatomic) IBOutlet UISwitch *mySwitch;
@property (weak, nonatomic) IBOutlet UILabel *quLab;
@property (weak, nonatomic) IBOutlet UILabel *schoolLab;
@property (weak, nonatomic) IBOutlet UIButton *studentBtn;
@property (weak, nonatomic) IBOutlet UIButton *teacherBtn;
@end
