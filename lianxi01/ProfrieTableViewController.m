//
//  ProfrieTableViewController.m
//  lianxi01
//
//  Created by 王勇 on 16/3/27.
//  Copyright © 2016年 Brave. All rights reserved.
//

#import "ProfrieTableViewController.h"
#import "EditProfrieTableViewController.h"

@interface ProfrieTableViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,ChangeDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *nick;
@property (weak, nonatomic) IBOutlet UILabel *youName;

@end

@implementation ProfrieTableViewController


- (void)viewDidLoad {

        [super viewDidLoad];
    
        self.title                          = @"个人信息";
        self.headerView.layer.cornerRadius  = 40;
        self.headerView.layer.masksToBounds = YES;
    if ([UserInfo sharedUserInfo].nickName) {
        self.nick.text = [UserInfo sharedUserInfo].nickName;
        self.youName.text = [UserInfo sharedUserInfo].yourName;
        self.headerView.image = [UIImage imageWithData:[UserInfo sharedUserInfo].imageData];
    }
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

       UITableViewCell *cell               = [tableView cellForRowAtIndexPath:indexPath];
       NSInteger tag                       = cell.tag;
    
    if (tag == 1) {
       
        UIActionSheet *action               = [[UIActionSheet alloc] initWithTitle:@"选择相片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机" otherButtonTitles:@"本地相册", nil];
        
        [action showInView:self.view];
    }else{
          [self performSegueWithIdentifier:@"EditVCSegue" sender:cell];
    }
}
#pragma mark - UIActionSheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 2){
    return ;
    }
   
    //创建图片选择器
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
   //设置代理
    imagePicker.delegate = self;
    //设置图片选择属性
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0) { //照相
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){//真机打开
           
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;

        }else{// 模拟器打开
            
            NSLog(@"模拟器打开");
            return;
           
        }
        
    }else{//相册
        
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
         // 进去选择器
    
    [self presentViewController:imagePicker animated:YES completion:nil];
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    UIImage *infoImage = info[UIImagePickerControllerEditedImage];
    self.headerView.image = infoImage;
    [self saveChangeData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    // 获取编辑个人信息 控制器
    id destVC                           = segue.destinationViewController;
    if ([destVC isKindOfClass:[EditProfrieTableViewController class]]) {
        EditProfrieTableViewController *editVc = destVC;
        editVc.cell                         = sender;
        editVc.delegate                     = self;
    }
    
}
#pragma mark - delegate
- (void)saveChangeData {
  
    [UserInfo sharedUserInfo].nickName = self.nick.text;
    [UserInfo sharedUserInfo].yourName = self.youName.text;
    [UserInfo sharedUserInfo].imageData = UIImagePNGRepresentation(self.headerView.image);
    [[UserInfo sharedUserInfo] saveUserInofFromSanbox];
    NSLog(@"保存");

}


@end
