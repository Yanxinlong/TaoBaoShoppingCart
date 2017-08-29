//
//  GoodsCatagoryView.h
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/5/10.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreProjectAttributeModule;
@class GoodsAttrValueModel;

typedef void(^ChooseAttributeBlock)(GoodsAttrValueModel *attModel,NSInteger cellidx);


@interface GoodsCatagoryView : UIView

@property (nonatomic,copy) ChooseAttributeBlock block;


@property (nonatomic,assign) NSInteger cellIdx;


- (instancetype)initWithFrame:(CGRect)frame withAttributeModule:(StoreProjectAttributeModule *)model withIdx:(NSInteger)idx;

- (void)fillCellWithStoreProjectAttributeModule:(StoreProjectAttributeModule *)model;

@end
