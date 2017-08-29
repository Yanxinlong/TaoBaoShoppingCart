//
//  GoodsBuyCountView.h
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/5/10.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseGoodsCountBlock)(NSInteger count);

@interface GoodsBuyCountView : UIView

@property (nonatomic,copy) ChooseGoodsCountBlock block;

@property (nonatomic,assign) NSInteger maxCount;

@end
