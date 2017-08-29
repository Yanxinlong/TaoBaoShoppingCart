//
//  StoreProjectDetailModule.h
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/4/17.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicDefine.h"

@interface StoreProjectDetailModule : NSObject

@property (nonatomic,assign) NSInteger productId;//	int	商品编号
@property (nonatomic,strong) NSString *productName;//	String	商品名称
@property (nonatomic,strong) NSString *detailUrl;
@property (nonatomic,strong) NSString *imgList;//	String	商品banner图片，使用，分割。当前业务只取了第一张
@property (nonatomic,strong) NSString *price;//	String	价格
@property (nonatomic,assign) NSInteger purchaseNum;//	int	购买数量
@property (nonatomic,assign) NSInteger productNum;//	int	商品数量
@property (nonatomic,assign) NSInteger isMark;//	int	是否已经收藏
@property (nonatomic,assign) NSInteger productStatus;//	int	 -1：平台下架 0:已下架 1：已上架
@property (nonatomic,strong) NSString *remark;//	String	备注
@property (nonatomic,strong) NSString *startTime;//	String	开始时间
@property (nonatomic,strong) NSString *endTime;//	String	结束时间
@property (nonatomic,assign) CGFloat productFreight;//	double	一件运费
@property (nonatomic,assign) CGFloat productFreightAdd;//	double	每增加一件运费
@property (nonatomic,strong) NSString *isAddress;//		买家是否需要填写地址
@property (nonatomic,assign) NSInteger commentNum;//	int	评论数
@property (nonatomic,assign) NSInteger companyId;//	int	企业id
@property (nonatomic,strong) NSString *companyName;//	String	企业名称
@property (nonatomic,strong) NSString *companyProduct;//	String	企业主营业务
@property (nonatomic,strong) NSString *companyLogo;//	String	企业logo
@property (nonatomic,strong) NSMutableArray *attributeList;//	List	商品属性集合
@property (nonatomic,strong) NSMutableArray *valueGroupList;//	List	产品属性组合
@property (nonatomic,assign) NSInteger headUserId;//
@property (nonatomic,strong) NSString *headHxid	;//	环信聊天id

@property (nonatomic,assign) CGFloat basicInfoHeight;

@property (nonatomic,assign) CGFloat companyHeight;



+ (void)requestStoreProjectDetailModuleCompleteBlock:(void(^)(StoreProjectDetailModule *model,NSError *error))block;

@end

@interface StoreProjectAttributeModule : NSObject

@property (nonatomic,assign) NSInteger attributeId;//	int	属性id
@property (nonatomic,strong) NSString *attributeName;//	String	属性名称
@property (nonatomic,strong) NSMutableArray *attributeValues;//	String	该属性的值集合使用","分割


@property (nonatomic,assign) CGFloat cellHeight;

@end

@interface StoreProjectValueGroupModule : NSObject

@property (nonatomic,strong) NSMutableArray *valueGroup;//	String	商品属性值组合，使用","分割
@property (nonatomic,strong) NSString *valueGroupString;//	String	商品属性值组合，使用","分割
@property (nonatomic,strong) NSString *attrs;
@property (nonatomic,assign) CGFloat price;//	double	价格
@property (nonatomic,assign) NSInteger totalNumber;//	int	总数量
@property (nonatomic,strong) NSString *imgUrl;//	String	图片链接
@property (nonatomic,assign) NSInteger sellNumber;//	int	卖出数量

/**
 *  是否选中
 **/
@property (nonatomic,assign) BOOL isSelect;

@end

@interface GoodsAttrValueModel : NSObject

/** 属性值 */
@property (nonatomic, copy) NSString *attrValue;

/**
 *  是否可以选中
 **/
@property (nonatomic,assign) BOOL isCanSelect;
/**
 *  是否选中
 **/
@property (nonatomic,assign) BOOL isSelect;

@end
