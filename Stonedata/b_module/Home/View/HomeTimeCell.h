//
//  HomeTimeCell.h
//  mohu
//
//  Created by 余浩 on 2018/9/3.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPagingView.h"
#import "MHChildOrderViewController.h"

@interface HomeTimeCell : UITableViewCell<SGPageTitleViewDelegate, SGPageContentCollectionViewDelegate>

@property (nonatomic, copy) NSArray *array;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier superVC:(UIViewController *)superVC;
@end
