//
//  EditProfrieTableViewController.m
//  lianxi01
//
//  Created by 王勇 on 16/3/27.
//  Copyright © 2016年 Brave. All rights reserved.
//

#import "EditProfrieTableViewController.h"

@interface EditProfrieTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textF;

@end

@implementation EditProfrieTableViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    [self setupForDismissKeyboard];

    self.title = self.cell.textLabel.text;
    self.textF.text = self.cell.detailTextLabel.text;
    // 添加右边保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    
}

- (void)saveBtnClick
{
    // 1.更改上一页cell的detailtextlabel 的text
    self.cell.detailTextLabel.text = self.textF.text;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(saveChangeData)]) {
        // 告诉代理 点击保存按钮
        [self.delegate saveChangeData];
    }

}


@end
