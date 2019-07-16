//
//  MHPriceMoreListModel.h
//  mohu
//
//  Created by yuhao on 2018/10/12.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHPriceMoreListModel : MHBaseModel
@property (nonatomic, copy)NSString *productId;
@property (nonatomic, copy)NSString *productName;
@property (nonatomic, copy)NSString *productSmallImage;
@property (nonatomic, copy)NSString *productPrice;
@property (nonatomic, copy)NSString *status;
@property (nonatomic, copy)NSString *drawId;
@property (nonatomic, copy)NSString *shareCount;
@end
