//
//  ChooseAttributeModel.h
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/4/20.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChooseAttributeModel : NSObject

@property (nonatomic,assign) NSInteger cartId;//		购物车中数据id
@property (nonatomic,assign) NSInteger num;//		商品数量
@property (nonatomic,strong) NSString *valueGroup;//	String	商品属性值组合，使用","分割
@property (nonatomic,assign) NSInteger productId;//	int	商品id

@end
