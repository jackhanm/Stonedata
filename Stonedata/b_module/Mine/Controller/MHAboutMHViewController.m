//
//  MHAboutMHViewController.m
//  mohu
//
//  Created by yuhao on 2018/9/29.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHAboutMHViewController.h"
#import "MHMineuserInfoCommonViewSecond.h"
#import "MHMineUserInfoCommonView.h"
#import "UIImage+Common.h"
#import "MHWebviewViewController.h"
#import <Photos/PHPhotoLibrary.h>
@interface MHAboutMHViewController ()
@property (nonatomic, strong)UIImageView *savepic ;
@end

@implementation MHAboutMHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于未来商视";
    self.view.backgroundColor = KColorFromRGB(0xf1f2f5);
    
    UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(143), kRealValue(76), kRealValue(90), kRealValue(90))];
    iconView.image = kGetImage(@"img_app_icon_main");
    iconView.layer.masksToBounds =YES;
    iconView.layer.cornerRadius=10;
    [self.view addSubview:iconView];
    
    UILabel *version = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(170), kScreenWidth, 30)];
    version.textAlignment = NSTextAlignmentCenter;
    version.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    version.textColor = KColorFromRGB(0x000000);
    NSString *str =APPVERSION;
    version.text = [NSString stringWithFormat:@"未来商视 v%@",str];
    [self.view addSubview:version];
    
    
    MHMineuserInfoCommonViewSecond *contact = [[MHMineuserInfoCommonViewSecond alloc]initWithFrame:CGRectMake(0, kRealValue(250), kScreenWidth, kRealValue(50)) lefttitle:@"联系未来商视" righttitle:@"复制" rightSubtitle:@"400-051-8180" istopLine:YES isBottonLine:YES];
    contact.righttitle.textColor = KColorFromRGB(0xF29F52);
    [self.view addSubview:contact];
    
    UITapGestureRecognizer *tapActfuzhi = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fuzhiAct)];
    [contact.righttitle addGestureRecognizer:tapActfuzhi];
    
    
    
    
    MHMineUserInfoCommonView *MHliscen = [[MHMineUserInfoCommonView alloc]initWithFrame:CGRectMake(0, kRealValue(310), kScreenWidth, kRealValue(50)) righttitle:@"《未来商视注册协议》" lefttitle:@"未来商视协议" istopLine:YES isBottonLine:YES];
    [self.view addSubview:MHliscen];
    
    UITapGestureRecognizer *tapAct = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MhlisenAct)];
    [MHliscen addGestureRecognizer:tapAct];
    
    
    UILabel *company = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(437), kScreenWidth, 20)];
    company.textAlignment = NSTextAlignmentCenter;
    company.text = @"未来商视 官 方 公 众 号";
    company.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
    company.textColor = KColorFromRGB(0x666666);
    [self.view addSubview:company];
    
    UILabel *save = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(452), kScreenWidth, 20)];
    save.textAlignment = NSTextAlignmentCenter;
    save.text = @"长 按 保 存";
    save.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
    save.textColor = KColorFromRGB(0x666666);
    [self.view addSubview:save];
    
    self.savepic = [[UIImageView alloc]init];
//    self.savepic.backgroundColor= kRandomColor;
    self.savepic.image = kGetImage(@"qrcode");
    self.savepic.userInteractionEnabled = YES;
    self.savepic.frame = CGRectMake(kRealValue(143), kRealValue(471), kRealValue(90), kRealValue(90));
    [self.view addSubview:self.savepic];
    
    UILongPressGestureRecognizer *longpan = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPanAct)];
    [self.savepic addGestureRecognizer:longpan];
    
    UILabel *own = [[UILabel alloc]initWithFrame:CGRectMake(0, kRealValue(571), kScreenWidth, 20)];
    own.textAlignment = NSTextAlignmentCenter;
    own.text = @"版权所有@未来商视网络科技有限公司";
    own.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(10)];
    own.textColor = KColorFromRGB(0x666666);
    [self.view addSubview:own];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}
-(void)fuzhiAct
{
    UIPasteboard *copy = [UIPasteboard generalPasteboard];
    [copy setString:@"400-051-8180"];
    if (copy == nil )
    {
        
        KLToast(@"复制失败")
        
        
    }else{
        KLToast(@"复制成功")
        
        
    }
    
}
-(void)MhlisenAct
{
    MHWebviewViewController *vc = [[MHWebviewViewController alloc]initWithurl:@"https://wap.mohuyoupin.com/registration_agreement.html" comefrom:@"mine"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)longPanAct
{
    //保存图片
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied)
    {
        // 无权限
        // do something...
        KLToast(@"请先打开相册权限设置");
        return;
    }
    UIImage *image =  [UIImage imageFromView:self.savepic];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    KLToast(@"保存成功");
    MHLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
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
