//
//  MHshopkeeperInfo.m
//  mohu
//
//  Created by yuhao on 2018/10/5.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHshopkeeperInfo.h"
#import "MHMineUserInfoCommonView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "AliyunOSSDemo.h"

@interface MHshopkeeperInfo ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong)UIScrollView *activityScroll;
@property (nonatomic, strong)UIImageView *headUserImage;
@property (nonatomic, strong)YYTextView  *textView;
@property (nonatomic, copy)NSString  *urlStr;
@property (nonatomic, strong)MHMineUserInfoCommonView *usernameView;
@property (nonatomic,strong)UITextField  *nameTextField;
@property (nonatomic,strong)UIButton  *tijiaoBtn;
@end

@implementation MHshopkeeperInfo

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"店铺资料";
    [self createview];
    
    [[MHUserService sharedInstance]initwithStoreInfo:nil completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            
            if (ValidStr(response[@"data"][@"shopName"])) {
               self.nameTextField.text = response[@"data"][@"shopName"];
            }
            if (ValidStr(response[@"data"][@"shopDesc"])) {
                self.textView.text = response[@"data"][@"shopDesc"];
            }
            [self.headUserImage sd_setImageWithURL:[NSURL URLWithString:response[@"data"][@"shopImage"]] placeholderImage:kGetImage(@"user_pic")];
        }
    }];

}
-(void)createview
{
    self.activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
    self.activityScroll.backgroundColor = KColorFromRGB(0xf1f2f5);
    self.activityScroll.showsHorizontalScrollIndicator = NO;
    self.activityScroll.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.activityScroll.showsVerticalScrollIndicator = NO;
    self.activityScroll.contentSize = CGSizeMake(0,kScreenHeight);
    
    
    //头像
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(10), kScreenWidth, kRealValue(74))];
    headview.backgroundColor = [UIColor whiteColor];
    [self.activityScroll addSubview:headview];
    
    UILabel *headlabel =[[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(24), kRealValue(150),kRealValue(30))];
    headlabel.text = @"店铺头像";
    headlabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    headlabel.textColor = KColorFromRGB(0x00000);
    headlabel.textAlignment = NSTextAlignmentLeft;
    [headview addSubview:headlabel];
    
    UIImageView *headrightIcon = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(37), kRealValue(26), kRealValue(22), kRealValue(22))];
    headrightIcon.image= kGetImage(@"ic_public_more");
    [headview addSubview:headrightIcon];
    
    self.headUserImage= [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - kRealValue(78), kRealValue(15), kRealValue(44), kRealValue(44))];
    self.headUserImage.layer.masksToBounds =YES;
    self.headUserImage.userInteractionEnabled= YES;
    self.headUserImage.layer.cornerRadius = kRealValue(22);
    [headview addSubview:self.headUserImage];
    UITapGestureRecognizer *usImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usImageTapAct)];
    [headview addGestureRecognizer:usImageTap];
    
    
    
    UIView *headview1 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(84), kScreenWidth, kRealValue(49))];
    headview1.backgroundColor = [UIColor whiteColor];
    [self.activityScroll addSubview:headview1];
    
    UILabel *headlabel1 =[[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), 0, kRealValue(150),kRealValue(49))];
    headlabel1.text = @"店铺名称";
    headlabel1.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    headlabel1.textColor = KColorFromRGB(0x00000);
    headlabel1.textAlignment = NSTextAlignmentLeft;
    [headview1 addSubview:headlabel1];
    
    
    _nameTextField = [UITextField new];
    _nameTextField.textAlignment = NSTextAlignmentRight;
    _nameTextField.placeholder = @"请输入昵称";
    [_nameTextField setFont:[UIFont fontWithName:kPingFangRegular size:kFontValue(14)]];
    [headview1 addSubview:_nameTextField];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kRealValue(49));
        make.top.equalTo(headview1.mas_top).offset(0);
        make.width.mas_equalTo(kRealValue(146));
        make.right.equalTo(headview1.mas_right).offset(-kRealValue(16));
    }];
    
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(73), kRealValue(359), 1/kScreenScale)];
    line.backgroundColor = KColorFromRGB(0xf0f0f0);
    [headview addSubview:line];
    
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(48), kRealValue(359), 1/kScreenScale)];
    line1.backgroundColor = KColorFromRGB(0xf0f0f0);
    [headview1 addSubview:line1];
    
    [self.view addSubview:self.activityScroll];
    
    
    UIView *headview2 = [[UIView alloc]initWithFrame:CGRectMake(0, kRealValue(143), kScreenWidth, kRealValue(159))];
    headview2.backgroundColor = [UIColor whiteColor];
    [self.activityScroll addSubview:headview2];
    
    UILabel *headlabel3 =[[UILabel alloc]initWithFrame:CGRectMake(kRealValue(16), kRealValue(6), kRealValue(150),kRealValue(30))];
    headlabel3.text = @"店铺介绍";
    headlabel3.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
    headlabel3.textColor = KColorFromRGB(0x00000);
    headlabel3.textAlignment = NSTextAlignmentLeft;
    [headview2 addSubview:headlabel3];
    
    
    _textView = [YYTextView new];
    _textView.frame = CGRectMake(kRealValue(16), kRealValue(37), kRealValue(343), kRealValue(112));
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 5;
    
    _textView.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    _textView.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
    _textView.textColor = [UIColor blackColor];
    _textView.placeholderText = @"请输入店铺介绍";
    _textView.placeholderTextColor = [UIColor  colorWithHexString:@"999999"];
    [headview2 addSubview:_textView];
    

    self.tijiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tijiaoBtn.backgroundColor = KColorFromRGB(0xFF5100);
    self.tijiaoBtn.titleLabel.font =[UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
    [self.tijiaoBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.tijiaoBtn setTitleColor:KColorFromRGB(0xffffff) forState:UIControlStateNormal];
    self.tijiaoBtn.layer.masksToBounds =YES;
    self.tijiaoBtn.layer.cornerRadius = 5;
    [self.tijiaoBtn addTarget:self action:@selector(loginout) forControlEvents:UIControlEventTouchUpInside];
    self.tijiaoBtn.frame =CGRectMake(kRealValue(108), kRealValue(330), kRealValue(160), kRealValue(30));
    [self.activityScroll addSubview:self.tijiaoBtn];
    

}


-(void)loginout{
    
    [[MHUserService sharedInstance]initWithFixShop:_nameTextField.text shopImage:self.urlStr shopDesc:_textView.text completionBlock:^(NSDictionary *response, NSError *error) {
        if (ValidResponseDict(response)) {
            KLToast(@"修改成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




-(void)usImageTapAct{
    
    //自定义消息框
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择", nil];
    //显示消息框
    [sheet showInView:self.view];
    
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSUInteger sourceType = 0;
    // 判断系统是否支持相机
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.delegate = self; //设置代理
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType; //图片来源
        if (buttonIndex == 0) {
            //拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.sourceType = sourceType;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }else if (buttonIndex == 1){
            //相册
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePickerController.sourceType = sourceType;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
    }else {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.sourceType = sourceType;
        imagePickerController.delegate = self; //设置代理
        imagePickerController.allowsEditing = YES;
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
}


#pragma mark -实现图片选择器代理-（上传图片的网络请求也是在这个方法里面进行，这里我不再介绍具体怎么上传图片）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]) {
        UIImage *theimage = nil;
        if ([picker allowsEditing]) {
            theimage = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            theimage =[info objectForKey:UIImagePickerControllerOriginalImage];
        }
        NSData *data = UIImageJPEGRepresentation(theimage, 0.5);
        
//        [MBProgressHUD showActivityMessageInWindow:@"正在上传"];
        [[AliyunOSSDemo sharedInstance] uploadObjectAsync:data destinName:@"head" withComplete:^(NSString *urlStr, NSError *error) {
            
            if (urlStr) {
                MHLog(@"%@",urlStr);
                self.urlStr = urlStr;
                [self.headUserImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:nil];
//                [MBProgressHUD hideHUD];
                
            }
            
            [picker dismissViewControllerAnimated:YES completion:nil];

        }];
        UIImageWriteToSavedPhotosAlbum(theimage, self, nil, nil);
    }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        KLToast(@"不支持视频");
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

@end
