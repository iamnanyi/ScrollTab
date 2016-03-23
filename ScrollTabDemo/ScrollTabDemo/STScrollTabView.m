//
//  STScrollTabView.m
//  ScrollTabDemo
//
//  Created by Jasonzb on 16/3/23.
//  Copyright © 2016年 vx173. All rights reserved.
//

#import "STScrollTabView.h"
#import "STMacro.h"

@implementation STScrollTabView

// 选择了某个按钮
- (void)buttonDidClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(segmentView:didSelectedPage:)]) {
        [self.delegate segmentView:self didSelectedPage:[self.buttonArray indexOfObject:sender]];
    }
}

// 设置索引
- (void)setSegmentIndex:(CGFloat)index {
    NSInteger firstIndex = (NSInteger)index;
    CGFloat firstScale = index - firstIndex;
    NSInteger secondIndex = -1;
    if (firstScale > 0) {
        secondIndex = firstIndex + 1;
    }
    [self.buttonArray enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL * __nonnull stop) {
        if (idx == firstIndex) {
            UIColor *color = RGBA(230 - (firstScale * 230), 153 - (firstScale * 153), 153 - (firstScale * 153), 1);
            [button setTitleColor:color forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:17 - (firstScale * 4)];
        } else if (idx == secondIndex) {
            UIColor *color = RGBA(0 + (firstScale * 230), 0 + (firstScale * 153), 0 + (153 * firstScale), 1);
            [button setTitleColor:color forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13 + (firstScale * 4)];
        } else {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
        }
    }];
}

- (NSArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [[NSArray alloc] init];
    }
    return _buttonArray;
}

@end
