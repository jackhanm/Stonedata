//
//  MHUserListModel.h
//  mohu
//
//  Created by AllenQin on 2018/9/26.
//  Copyright © 2018 AllenQin. All rights reserved.
//

#import "MHBaseModel.h"

@interface MHUserListModel : MHBaseModel

@property (nonatomic , copy) NSString              * userImage;
@property (nonatomic , copy) NSString              * shopName;
@property (nonatomic , assign) NSInteger             shopId;
@property (nonatomic , copy) NSString              *fansCount;
@property (nonatomic , copy) NSString              *shopAvatar;

@end
