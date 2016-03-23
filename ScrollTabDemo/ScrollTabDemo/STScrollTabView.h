//
//  STScrollTabView.h
//  ScrollTabDemo
//
//  Created by Jasonzb on 16/3/23.
//  Copyright © 2016年 vx173. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STScrollTabView;

@protocol STScrollTabViewDelegate <NSObject>

@optional
- (void)segmentView:(STScrollTabView *)scrollTabView didSelectedPage:(NSUInteger)index;

@end

@interface STScrollTabView : UIScrollView

@property (nonatomic, strong) NSArray *buttonArray;
@property (nonatomic, weak)id<STScrollTabViewDelegate> delegate;

// 设置索引
- (void)setSegmentIndex:(CGFloat)index;
- (void)buttonDidClick:(UIButton *)sender;

@end
