//
//  NSArray+HXAdditions.m
//  HXFundManager
//
//  Created by 柯浩然 on 2019/7/25.
//  Copyright © 2019 China Asset Management Co., Ltd. All rights reserved.
//

#import "NSArray+FMAdditions.h"

@implementation NSArray (HXAdditions)
- (void)hx_distributeViewsWithFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    
   __block UIView *lastView = nil;
    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];

    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (!lastView) {
                
                make.leading.mas_equalTo(leadSpacing);
            }else {
                make.leading.equalTo(lastView.mas_trailing).offset(fixedSpacing);
            }
            if (idx == self.count - 1) {//last one
                make.trailing.equalTo(tempSuperView).offset(-tailSpacing);
            }
            make.top.bottom.equalTo(@0);
        }];
        
        lastView = view;
    }];
}

- (MAS_VIEW *)mas_commonSuperviewOfViews
{
    MAS_VIEW *commonSuperview = nil;
    MAS_VIEW *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[MAS_VIEW class]]) {
            MAS_VIEW *view = (MAS_VIEW *)object;
            if (previousView) {
                commonSuperview = [view mas_closestCommonSuperview:commonSuperview];
            } else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

- (NSArray *)map:(id (^) (id obj))block {
    NSCParameterAssert(block != NULL);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id element = block(obj);
        if (element) {
            [array addObject:element];
        }
    }];
    return array;
}

- (NSArray *)filter:(BOOL (^) (id obj))block {
    NSCParameterAssert(block != NULL);
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL element = block(obj);
        if (element) {
            [array addObject:obj];
        }
    }];
    return array;
}

@end
