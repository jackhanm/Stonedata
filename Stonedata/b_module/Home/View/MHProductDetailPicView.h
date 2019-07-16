//
//  MHProductDetailPicView.h
//  mohu
//
//  Created by 余浩 on 2018/9/20.
//  Copyright © 2018年 AllenQin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MHProductDetailPicViewDelegate <NSObject>
@optional
- (void)pullDragAndShowProduct;
- (void)PicViewdidscroll:(CGFloat )offset;

@end
@interface MHProductDetailPicView : UIView
@property (nonatomic,weak) id<MHProductDetailPicViewDelegate>PicViewDelegate;
@property (nonatomic,strong)NSMutableArray *PictureArr;
@property (nonatomic,strong)NSString *des;
@end
