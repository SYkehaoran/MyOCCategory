//
//  NSArray+HXAdditions.m
//
//  Created by 柯浩然 on 2019/7/25.
//

#import "NSArray+HXAdditions.h"
#import "Masonry.h"
@implementation NSArray (HXAdditions)

- (void)hx_distributeViewsWithFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    [self hx_distributeViewsWithFixedLength:0 topSpacing:0 fixedSpacing:fixedSpacing leadSpacing:leadSpacing tailSpacing:tailSpacing];
}
    
- (void)hx_distributeViewsWithFixedLength:(CGFloat)fixedLength topSpacing:(CGFloat)topSpacing fixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
   
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    BOOL shouldNewRow = fixedLength>0;
    
    __block UIView *lastView = nil;
    __block CGFloat currentWidth = 0;
    __block UIView *lastRowFirstView = nil;
    MAS_VIEW *tempSuperView = [self mas_commonSuperviewOfViews];
    [self enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat viewWidth = [view sizeThatFits:CGSizeZero].width;
    
        currentWidth += viewWidth;
        NSLog(@"viewWidth = %f currentWidth = %f",viewWidth,currentWidth);
        BOOL scaleOut = shouldNewRow && viewWidth > fixedLength;
        BOOL newRow = shouldNewRow && ( scaleOut || currentWidth>fixedLength);
        
        if (newRow) {
            lastView = nil;
            currentWidth = viewWidth;
        }
        currentWidth += fixedSpacing;
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (!lastView) {
                
                make.leading.mas_equalTo(leadSpacing);
            }else {
                make.leading.equalTo(lastView.mas_trailing).offset(fixedSpacing);
            }
            
            if (lastView) {
                make.top.equalTo(lastView);
            }else if (newRow && lastRowFirstView) {
                make.top.equalTo(lastRowFirstView.mas_bottom).offset(topSpacing);
            }else {
                make.top.equalTo(@0);
            }
            
            if (scaleOut) {
                make.trailing.mas_equalTo(tempSuperView);
            }else if(idx == self.count-1 && !shouldNewRow){
                make.trailing.mas_equalTo(tempSuperView);
            }
            
            if (idx == self.count-1) {
                make.bottom.equalTo(@0);
            }
        }];
        
        if (newRow) {
            newRow = NO;
            lastRowFirstView = view;
        }
        
        if (!lastRowFirstView) {
            lastRowFirstView = view;
        }
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
