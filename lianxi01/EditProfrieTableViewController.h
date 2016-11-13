//
//  EditProfrieTableViewController.h
//  lianxi01
//
//  Created by 王勇 on 16/3/27.
//  Copyright © 2016年 Brave. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ChangeDelegate <NSObject>

- (void)saveChangeData;

@end

@interface EditProfrieTableViewController : UITableViewController

//传入cell数据
@property (nonatomic ,strong) UITableViewCell *cell;
@property (nonatomic ,weak) id<ChangeDelegate>delegate;


@end
