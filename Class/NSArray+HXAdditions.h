//
//  NSArray+HXAdditions.h
//
//  Created by 柯浩然 on 2019/7/25.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSArray (HXAdditions)
- (void)hx_distributeViewsWithFixedSpacing:(CGFloat)fixedSpacing  leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;
///排列有一个固定的Length。然后会进行换行
- (void)hx_distributeViewsWithFixedLength:(CGFloat)fixedLength topSpacing:(CGFloat)topSpacing fixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;
/**
 *一个数组通过一定的运算法则转化为另一个数组，这两个数组里的元素个数是一样的，但是元素类型是可以不一样的
 */
- (NSArray *)map:(id (^) (id obj))block;

/**
 *一个数组通过一定的运算法则过滤掉相应的元素，成为另一个数组，这两个数组里的元素个数是不一样的，但是元素类型是一样的
 */
- (NSArray *)filter:(BOOL (^) (id obj))block;

@end

NS_ASSUME_NONNULL_END
