//
//  StoreProjectDetailModule.m
//  CSN
//
//  Created by qhzc-iMac-02 on 2017/4/17.
//  Copyright © 2017年 QianHaiZhongChou. All rights reserved.
//

#import "StoreProjectDetailModule.h"

@implementation StoreProjectDetailModule

- (instancetype)init {
    if (self = [super init]) {
        _attributeList = [NSMutableArray array];
        _valueGroupList = [NSMutableArray array];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"attributeList"]) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in value) {
            StoreProjectAttributeModule *model = [[StoreProjectAttributeModule alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            NSMutableArray *buttonArray =  model.attributeValues;

            if ([buttonArray count] > 0) {
                int i = 0;
                int tagIdex = 0;
                CGFloat width = 0;
                
                for (GoodsAttrValueModel *model in buttonArray) {
                    
                    CGFloat buttonWidth = [Unit widthForLabelWithContent:model.attrValue withHeight:30 withFontSize:14] + 20;
                    ++tagIdex;
                    /** < 记录当前累计按钮长度 > **/
                    width += buttonWidth+10;
                    /** < 判断下一个按钮宽度是否能续到当前行后面，不行的话跳转到下一行 > **/
                    GoodsAttrValueModel * nextModel;
                    if (tagIdex < [buttonArray count]) {
                        nextModel = buttonArray[tagIdex];
                    }
                    CGFloat nextButtonWidth = [Unit widthForLabelWithContent:nextModel.attrValue withHeight:30 withFontSize:14] + 20;
                    if (SCREEN_WIDTH - 30 - width < nextButtonWidth) {
                        ++i;
                        width = 0;
                    }
                }
                
                model.cellHeight = 40 * (i+1) + 60;
            } else {
                model.cellHeight = 40;
            }
            
            [array addObject:model];
        }
        _attributeList = array;
        
    } else if ([key isEqualToString:@"valueGroupList"]) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in value) {
            StoreProjectValueGroupModule *model = [[StoreProjectValueGroupModule alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        _valueGroupList = array;
        
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@类这个字段没有定义%@",[NSString stringWithUTF8String:object_getClassName(self)],key);
    
}

+ (void)requestStoreProjectDetailModuleCompleteBlock:(void(^)(StoreProjectDetailModule *model,NSError *error))block {
    
     NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataJson" ofType:@"json"]] options:NSJSONReadingMutableContainers error:nil];
    
    if (obj && [obj[@"result"] integerValue] == 0) {
        StoreProjectDetailModule *model = [[StoreProjectDetailModule alloc]init];
        [model setValuesForKeysWithDictionary:obj[@"data"]];
        
        CGFloat titleHeight = [Unit heightWithString:model.productName font:[UIFont systemFontOfSize:16] constrainedToWidth:SCREEN_WIDTH-30];
        CGFloat remarkHeight = [Unit heightWithString:model.remark font:[UIFont systemFontOfSize:15] constrainedToWidth:SCREEN_WIDTH-30];
        
        model.basicInfoHeight = titleHeight + remarkHeight+80;
        
        model.companyHeight = 334/2;
        
        //获取可以选择的属性
        NSMutableArray *canSelectModelArray = [NSMutableArray array];
        
        for (StoreProjectValueGroupModule *gropModel in model.valueGroupList) {
            for (GoodsAttrValueModel *itemModel in gropModel.valueGroup) {
                [canSelectModelArray addObject:itemModel.attrValue];
            }
        }
        
        canSelectModelArray = [canSelectModelArray valueForKeyPath:@"@distinctUnionOfObjects.self"];
        NSLog(@"++++%@",canSelectModelArray);
        //获取全部的属性
        NSMutableArray *allAttributeArray = [NSMutableArray array];
        
        for (StoreProjectAttributeModule *gropModel in model.attributeList) {
            for (GoodsAttrValueModel *itemModel in gropModel.attributeValues) {
                [allAttributeArray addObject:itemModel];
            }
        }
        
        for (NSString *title in canSelectModelArray) {
            for (GoodsAttrValueModel *itemModel in allAttributeArray) {
                if ([title isEqualToString:itemModel.attrValue]) {
                    itemModel.isCanSelect = YES;
                }
            }
        }
        
        block(model,nil);
    } else {
        block(nil,nil);
    }

    
}


@end


@implementation StoreProjectAttributeModule
- (instancetype)init {
    if (self = [super init]) {
        _attributeValues = [NSMutableArray array];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"attributeValues"]) {
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *attriArray = [value componentsSeparatedByString:@","];
        
        for (NSString *title in attriArray) {
            GoodsAttrValueModel *model = [[GoodsAttrValueModel alloc]init];
            model.attrValue = title;
//            model.isCanSelect = YES;
            [array addObject:model];
        }
        
        _attributeValues = array;
        
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@类这个字段没有定义%@",[NSString stringWithUTF8String:object_getClassName(self)],key);
    
}
@end


@implementation StoreProjectValueGroupModule
- (instancetype)init {
    if (self = [super init]) {
        _valueGroup = [NSMutableArray array];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"valueGroup"]) {
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *attriArray = [value componentsSeparatedByString:@","];
        
        for (NSString *title in attriArray) {
            GoodsAttrValueModel *model = [[GoodsAttrValueModel alloc]init];
            model.attrValue = title;
//            model.isCanSelect = YES;
            [array addObject:model];
        }
        
        _valueGroup = array;
        _valueGroupString = value;
        
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@类这个字段没有定义%@",[NSString stringWithUTF8String:object_getClassName(self)],key);
    
}
@end

@implementation GoodsAttrValueModel

@end
