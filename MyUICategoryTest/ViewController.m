//
//  ViewController.m
//  MyUICategoryTest
//
//  Created by 柯浩然 on 2019/8/8.
//  Copyright © 2019 yingjie zhang. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+HXAdditions.h"
#import "Masonry.h"
#import "MyUICategoryTest-Swift.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatMultiRowView];
    [self creatsingleRowScrollView];
    // Do any additional setup after loading the view.
}

- (void)creatMultiRowView {
    
    CGFloat fixedLength = 300;
    
    UIView *backView = [UIView new];
    backView.backgroundColor =  [UIColor greenColor];
    
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@-300);
        make.leading.equalTo(@15);
        make.width.mas_equalTo(fixedLength);
    }];
    
    NSArray *itemArray = [self itemArray];
    itemArray  = [itemArray filter:^BOOL(UILabel *obj) {
        
        if (obj.text.length > 0) {
            [backView addSubview:obj];
        }
        return obj.text.length>0;
    }];
    
    [itemArray hx_distributeViewsWithFixedLength:fixedLength topSpacing:6 fixedSpacing:6 leadSpacing:0 tailSpacing:0];
}

- (NSArray *)itemArray {
    
    NSMutableArray *tempArray = [NSMutableArray array];
    NSArray *stringArray = @[@"手放开",@"断点",@"古力娜扎",@"男人哭吧哭吧不是罪",@"挪威的森林",@"多想在平庸的生活拥抱你",@"听妈妈的话",@"l快乐崇拜",@"西二旗",@"西三旗",@"五棵松",@"四棵松",@"三棵松"];
   
    for (NSInteger i = 0; i<stringArray.count; i++) {
        HXLabel *label = [[HXLabel alloc] init];
        label.backgroundColor = [UIColor yellowColor];
        label.text = stringArray[i];
        label.contentInset = UIEdgeInsetsMake(0, 0, 5, 5);
        label.layer.borderColor = [UIColor redColor].CGColor;
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = 5;
        label.textAlignment = NSTextAlignmentCenter;
        [tempArray addObject:label];
    }
    
    return [tempArray copy];
}

- (void)creatsingleRowScrollView {
    
    
    UIView *backView = [UIView new];

    UIScrollView *scrollview= [[UIScrollView alloc] init];
    [self.view addSubview:scrollview];
    [scrollview addSubview: backView];
    
    NSArray *itemArray = [self itemArray];
    itemArray  = [itemArray filter:^BOOL(UILabel *obj) {
        
        if (obj.text.length > 0) {
            [backView addSubview:obj];
        }
        return obj.text.length>0;
    }];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(@0);
    }];
    
    [scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.leading.equalTo(@15);
        make.trailing.equalTo(@-15);
        make.height.equalTo(backView);
    }];
    
    [itemArray hx_distributeViewsWithFixedSpacing:6 leadSpacing:0 tailSpacing:0];
}

@end
