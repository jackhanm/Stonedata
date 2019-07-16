//
//  MHProductHucaidetailHeadCell.h
//  mohu
//
//  Created by yuhao on 2018/10/9.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYCyclePagerView.h"
#import "TYPageControl.h"
#import "RichStyleLabel.h"
#import "MHProductDetailCellHead.h"



typedef void(^HucaiPersonAll)(void);



@interface MHProductHucaidetailHeadCell : UITableViewCell
@property (nonatomic, strong)HucaiPersonAll hucaiSeeAll;
@property (nonatomic, strong)UIImageView *headImgView;
@property (nonatomic, strong)UIImageView *rightImgView;
@property (nonatomic, strong) TYCyclePagerView *headImgScrollview;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) UIView * limitTimeBuy;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIView *titlebgView;
@property (nonatomic, strong) UIView *SizebgView;

//hucai
//中奖名单
@property (nonatomic, strong) UIView *prizeView;
//参团好友
@property (nonatomic, strong) UIView *prizenumView;
@property (nonatomic, strong) UIView *hucaibgView;
@property (nonatomic, strong) UIImageView *SaledPicView;
@property (nonatomic, strong)UIImageView *leftImgView;
@property (nonatomic, strong)RichStyleLabel *currentPrice ;
@property (nonatomic, strong)UILabel *originalPrice;
@property (nonatomic, strong)UILabel *SalelNum;
@property (nonatomic, strong)UIButton *likebt;
@property (nonatomic, strong)UILabel *likelabel;
@property (nonatomic, strong)YYLabel *titlelabel;
@property (nonatomic, strong)MHProductDetailCellHead *choseePropertyView;
@property(nonatomic, strong) NSMutableArray *bannerArr;
//
@property (nonatomic, strong)NSMutableDictionary *dic;
@property (nonatomic, strong)NSMutableDictionary *expandDic;
@property (nonatomic, strong)UILabel *labeltime ;

@property(nonatomic, strong)UILabel *secondelabel;
@property(nonatomic, strong)UILabel *minutelabel;
@property(nonatomic, strong)UILabel *hourlabel;
@property(nonatomic, strong)UILabel *labeltitle ;
@property(nonatomic, strong)UILabel *maohao1;
@property(nonatomic, strong)UILabel *maohao2;
@end
