//
//  MHChildOrderTableViewCell.m
//  mohu
//
//  Created by AllenQin on 2018/9/11.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import "MHChildOrderTableViewCell.h"
#import "MHCustomerServiceVC.h"
#import "MHMineProductCommentController.h"
#import "MHContinuePayVC.h"

#define PADDING 0

@implementation MHChildOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
        if (self) {
            
            self.backgroundColor = [UIColor clearColor];
            _bgView = [[UIView alloc]initWithFrame:CGRectMake(kRealValue(10), 0, kScreenWidth - kRealValue(20), kRealValue(128))];
            _bgView.backgroundColor = [UIColor whiteColor];
            [self addSubview:_bgView];
            
            
   
            
            
            _leftImageView = [[UIImageView alloc] init];
//            _leftImageView.backgroundColor = kRandomColor;
            [_bgView addSubview:_leftImageView];
            [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kRealValue(100), kRealValue(100)));
                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(15));
                make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(16));
            }];
            
            _titlesLabel = [[UILabel alloc]init];
            _titlesLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
            _titlesLabel.textColor =[UIColor colorWithHexString:@"333333"];
//            _titlesLabel.text  = @"Apple/苹果 iPhone X 64G 全网通4G 双卡双待无激活码";
            _titlesLabel.numberOfLines = 2;
            [_bgView addSubview:_titlesLabel];
            [_titlesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(14));
                make.left.equalTo(self.leftImageView.mas_right).with.offset(kRealValue(15));
                make.width.mas_equalTo(kRealValue(210));
            }];
//

            
            
      
//
//            _priceLabel = [[RichStyleLabel alloc]init];
//            _priceLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
//            _priceLabel.textColor =[UIColor colorWithHexString:@"#6E6E6E"];
////            _priceLabel.text  = @"¥171";
//            _priceLabel.textAlignment = NSTextAlignmentRight;
//            [_bgView addSubview:_priceLabel];
//            [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(114));
//                make.right.equalTo(_bgView.mas_right).with.offset(-kRealValue(10));
//            }];
//
//            _numberLabel = [[UILabel  alloc]init];
//            _numberLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//            _numberLabel.text = @"x4";
//            _numberLabel.textColor =[UIColor colorWithHexString:@"#666666"];
//            [bgView addSubview:_numberLabel];
//            [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(self.leftImageView.mas_bottom).with.offset(0);
//                make.right.equalTo(bgView.mas_right).with.offset(-kRealValue(15));
//            }];
            
            
            
//            _alllabel = [[UILabel alloc]init];
//            _alllabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//            _alllabel.textColor =[UIColor colorWithHexString:@"666666"];
////            _alllabel.text  = @"共2件，实付：";
//            [_bgView addSubview:_alllabel];
//            [_alllabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(115));
//                make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(10));
//            }];
//
//            _moneyLabel = [[UILabel alloc]init];
//            _moneyLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(14)];
//            _moneyLabel.textColor =[UIColor colorWithHexString:@"000000"];
////            _moneyLabel.text  = @"995元";
//            [_bgView addSubview:_moneyLabel];
//            [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(114));
//                make.left.equalTo(self.alllabel.mas_right).with.offset(kRealValue(1));
//            }];
//
//
//
//            UILabel *lineView2 = [[UILabel alloc] init];
//            lineView2.backgroundColor = [UIColor colorWithHexString:@"F0F0F0"];
//            [_bgView addSubview:lineView2];
//            [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(_bgView.mas_top).with.offset(kRealValue(141));
//                make.left.equalTo(_bgView.mas_left).with.offset(0);
//                make.right.equalTo(_bgView.mas_right).with.offset(0);
//                make.height.mas_equalTo(1/kScreenScale);
//            }];
//
//
//            _dataLabel = [[UILabel alloc]init];
//            _dataLabel.font = [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//            _dataLabel.textColor =[UIColor colorWithHexString:@"#666666"];
//            [_bgView addSubview:_dataLabel];
//            [_dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(_bgView.mas_bottom).with.offset(-kRealValue(13));
//                make.left.equalTo(_bgView.mas_left).with.offset(kRealValue(7));
//            }];
//
//
//            _rightBtn = [[UIButton alloc] init];
//            _rightBtn.backgroundColor =  [UIColor colorWithHexString:@"#FF5100"];
//            _rightBtn.layer.cornerRadius = 4;
//            _rightBtn.userInteractionEnabled = YES;
//            [_rightBtn addTarget: self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
//            _rightBtn.titleLabel.font =  [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//            [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            _rightBtn.hidden = YES;
//            _rightBtn.layer.masksToBounds = YES;
//            [_bgView addSubview:_rightBtn];
//            [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(_bgView.mas_bottom).with.offset(-kRealValue(7));
//                make.right.equalTo(_bgView.mas_right).with.offset(-kRealValue(10));
//                make.size.mas_equalTo(CGSizeMake(kRealValue(70), kRealValue(26)));
//            }];
//
//            _leftBtn = [[UIButton alloc] init];
//            _leftBtn.userInteractionEnabled = YES;
//            [_leftBtn addTarget: self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
//            _leftBtn.backgroundColor =  [UIColor colorWithHexString:@"#E0E0E0"];
//            _leftBtn.layer.cornerRadius = 4;
//            [_leftBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
//            _leftBtn.titleLabel.font =  [UIFont fontWithName:kPingFangRegular size:kFontValue(12)];
//            _leftBtn.hidden = YES;
//            _leftBtn.layer.masksToBounds = YES;
//            [_bgView addSubview:_leftBtn];
//            [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.bottom.equalTo(_bgView.mas_bottom).with.offset(-kRealValue(7));
//                make.right.equalTo(_rightBtn.mas_left).with.offset(-kRealValue(7));
//                make.size.mas_equalTo(CGSizeMake(kRealValue(70), kRealValue(26)));
//            }];
            

        
    }
    
    return self;
}

-(void)leftClick{
    if ([self.model.orderState isEqualToString:@"UNPAID"]) {
        
        MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"确认取消订单？" ];
        alertVC.messageAlignment = NSTextAlignmentCenter;
        CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
            [alertVC showDisappearAnimation];
            [[MHUserService sharedInstance]initwithCancleorder:self.model.orderId completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    if (self.cancleClick) {
                        self.cancleClick();
                    }
                }
                
            }];
        }];
        CKAlertAction *sure = [CKAlertAction actionWithTitle:@"我在想想" handler:^(CKAlertAction *action) {
            [alertVC showDisappearAnimation];
        }];
        [alertVC addAction:cancel];
        [alertVC addAction:sure];
        [self.superVC presentViewController:alertVC animated:NO completion:nil];

    }else if ([self.model.orderState isEqualToString:@"UNEVALUATED"]){
       //push
        MHCustomerServiceVC *vc  = [[MHCustomerServiceVC alloc]init];
        vc.model = self.model;
        [self.superVC.navigationController pushViewController:vc animated:YES];
    }
}

- (void)rightClick{
    if ([self.model.orderState isEqualToString:@"UNEVALUATED"]) {
        MHMineProductCommentController *vc  = [[MHMineProductCommentController alloc]initWithorderId:[NSString stringWithFormat:@"%ld",self.model.orderId]];
        [self.superVC.navigationController pushViewController:vc animated:YES];
        
    }else if ([self.model.orderState isEqualToString:@"UNDELIVER"]){
        MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"是否确认收货？" ];
        alertVC.messageAlignment = NSTextAlignmentCenter;
        CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
            [alertVC showDisappearAnimation];
            
        }];
        CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确认" handler:^(CKAlertAction *action) {
            [alertVC showDisappearAnimation];
            [[MHUserService sharedInstance]initwithOkorder:self.model.orderId completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    if (self.cancleClick) {
                        self.cancleClick();
                    }
                }
                
            }];
        }];
        [alertVC addAction:cancel];
        [alertVC addAction:sure];
        [self.superVC presentViewController:alertVC animated:NO completion:nil];

    }else if ([self.model.orderState isEqualToString:@"UNRECEIPT"]){
        
        MHAlertViewController *alertVC = [MHAlertViewController alertControllerWithMessage:@"是否确认收货？" ];
        alertVC.messageAlignment = NSTextAlignmentCenter;
        CKAlertAction *cancel = [CKAlertAction actionWithTitle:@"取消" handler:^(CKAlertAction *action) {
            [alertVC showDisappearAnimation];
            
        }];
        CKAlertAction *sure = [CKAlertAction actionWithTitle:@"确认" handler:^(CKAlertAction *action) {
            [alertVC showDisappearAnimation];
            [[MHUserService sharedInstance]initwithOkorder:self.model.orderId completionBlock:^(NSDictionary *response, NSError *error) {
                if (ValidResponseDict(response)) {
                    if (self.cancleClick) {
                        self.cancleClick();
                    }
                }
                
            }];
        }];
        [alertVC addAction:cancel];
        [alertVC addAction:sure];
        [self.superVC presentViewController:alertVC animated:NO completion:nil];
        

        
    }else if ([self.model.orderState isEqualToString:@"UNPAID"]) {
        MHContinuePayVC *vc = [[MHContinuePayVC alloc]init];
        vc.model = self.model;
        [self.superVC.navigationController pushViewController:vc animated:YES];
    }else if ([self.model.orderState isEqualToString:@"COMPLETED"]){
        //push
        MHCustomerServiceVC *vc  = [[MHCustomerServiceVC alloc]init];
        vc.model = self.model;
        [self.superVC.navigationController pushViewController:vc animated:YES];
    }
}


-(void)createModel:(MHMyOrderListModel *)model{
    self.model = model;
    self.ActivityArr = model.products;
    _dingdanLabel.text  = [NSString stringWithFormat:@"订单号：%@",model.orderCode];
    _alllabel.text = [NSString stringWithFormat:@"共%ld件，实付：",(long)model.totalProducts];
    _moneyLabel.text = [NSString stringWithFormat:@"%@元",model.orderTruePrice];
    _dataLabel.text = [NSString stringWithFormat:@"%@  %@",model.createDate,model.createTime];
    [_priceLabel setAttributedText:[NSString stringWithFormat:@"可赚¥%@",model.commissionProfit] withRegularPattern:@"[0-9.,¥]" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FB3131"],NSFontAttributeName : [UIFont fontWithName:kPingFangRegular size:kFontValue(14)]}];
    if ([[GVUserDefaults standardUserDefaults].userRole isEqualToString:@"1"]) {
        _priceLabel.hidden = YES;
    }else{
        _priceLabel.hidden = NO;
    }
    if ([model.orderTradeState isEqualToString:@"CLOSED"]) {
          _stateLabel.text = @"已关闭";
          _leftBtn.hidden = YES;
          _rightBtn.hidden = YES;
    }else{
        if ([model.orderState isEqualToString:@"UNPAID"]) {
            _stateLabel.text = @"待付款";
            _leftBtn.hidden = NO;
            _rightBtn.hidden = NO;
            [_leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [_rightBtn setTitle:@"去支付" forState:UIControlStateNormal];
            _rightBtn.userInteractionEnabled = YES;
        }else if ([model.orderState isEqualToString:@"UNDELIVER"]){
            _stateLabel.text = @"待发货";
            _leftBtn.hidden = YES;
            _rightBtn.hidden = YES;
            _rightBtn.userInteractionEnabled = YES;
        }else if ([model.orderState isEqualToString:@"UNRECEIPT"]){
            _stateLabel.text = @"待收货";
            _leftBtn.hidden = YES;
            _rightBtn.hidden = NO;
            [_rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            _rightBtn.userInteractionEnabled = YES;
        }else if ([model.orderState isEqualToString:@"UNEVALUATED"]){
            _stateLabel.text = @"待评价";
            _leftBtn.hidden = NO;
            _rightBtn.hidden = NO;
            [_leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            [_rightBtn setTitle:@"立即评价" forState:UIControlStateNormal];
            _rightBtn.userInteractionEnabled = YES;
        }else if ([model.orderState isEqualToString:@"COMPLETED"]){
            if ([model.orderTradeState isEqualToString:@"COMPLETED"]) {
                _stateLabel.text = @"已完成";
                _leftBtn.hidden = YES;
                _rightBtn.hidden = YES;
            }else{
            
                _stateLabel.text = @"已完成";
                _leftBtn.hidden = YES;
                _rightBtn.hidden = NO;
                [_rightBtn setTitle:@"申请售后" forState:UIControlStateNormal];
            }

        }else if ([model.orderState isEqualToString:@"RETURN_GOOD"]){
            _stateLabel.text = @"退换货";
            _leftBtn.hidden = YES;
            _rightBtn.hidden = NO;
            [_rightBtn setTitle:@"查看进度" forState:UIControlStateNormal];
            _rightBtn.userInteractionEnabled = NO;
        }
    }
}


-(void)createListModel:(NSDictionary *)productDict{
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:productDict[@"productSmallImage"]] placeholderImage:nil];
    self.titlesLabel.text = productDict[@"productName"];
}

//-(UIScrollView *)activityScroll
//{
//    if (!_activityScroll) {
//        _activityScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kRealValue(44), kScreenWidth - kRealValue(32), kRealValue(60))];
//        _activityScroll.userInteractionEnabled = YES;
//        _activityScroll.backgroundColor = [UIColor whiteColor];
//        _activityScroll.showsHorizontalScrollIndicator = NO;
//        _activityScroll.showsVerticalScrollIndicator = NO;
//        for (int i = 0; i < _ActivityArr.count; i++) {
//            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(kRealValue(70) * i + kRealValue(10), 0, kRealValue(60), kRealValue(60))];
//            [img sd_setImageWithURL:[NSURL URLWithString:_ActivityArr[i][@"productSmallImage"]] placeholderImage:nil];
//            [_activityScroll addSubview:img];
//        }
//          _activityScroll.contentSize = CGSizeMake(kRealValue(70) * _ActivityArr.count, kRealValue(60));
//    }
//    return _activityScroll;
//}
//
//
//-(void)setActivityArr:(NSMutableArray *)ActivityArr
//{
//    if (_ActivityArr != ActivityArr) {
//        _ActivityArr = ActivityArr;
//        [self.activityScroll removeAllSubviews];
//        self.activityScroll = nil;
//        [_bgView addSubview:self.activityScroll];
//    }
//
//}
//

@end
