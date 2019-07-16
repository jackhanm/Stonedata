//
//  AliPushViewController.m
//  WeilaiShangShi_iOS
//
//  Created by yuhao on 2019/7/9.
//  Copyright © 2019 hf. All rights reserved.
//

#import "AliPushViewController.h"
#import "MHMessageManager.h"
#import "testViewController.h"
@interface AliPushViewController ()
@end

@implementation AliPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = NO;
    self.title = @"推流";
    testViewController *vc = [[testViewController alloc]initWithtopPic];
    
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
