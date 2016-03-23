//
//  ViewController.m
//  ScrollTabDemo
//
//  Created by Jasonzb on 16/3/23.
//  Copyright © 2016年 vx173. All rights reserved.
//

#import "STViewController.h"
#import "Masonry.h"
#import "STScrollTabView.h"
#import "STMacro.h"

@interface STViewController () <UIScrollViewDelegate, STScrollTabViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet STScrollTabView *scrollTabView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (nonatomic, strong) NSArray *buttonTitleArray;
@property (nonatomic, copy) NSMutableArray *buttonArray;
@property (nonatomic, copy) NSMutableArray *viewArray;

- (void)createView;
- (UIColor *)randomColor;
- (void)scrollToCenterWithIndex:(NSUInteger)index;

@end

@implementation STViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _buttonTitleArray = @[@"娱乐", @"热点", @"体育", @"本地", @"订阅", @"财经", @"科技", @"汽车", @"时尚"];
        _buttonArray = [[NSMutableArray alloc] init];
        _viewArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollTabView.delegate = self;
    [self createView];
    _scrollTabView.buttonArray = _buttonArray;
}

#pragma mark - Event

- (IBAction)firstButtonClicked:(id)sender {
    [_firstButton setTitleColor:FONT_COLOR forState:UIControlStateNormal];
    [_contentScrollView setContentOffset:CGPointZero animated:NO];
}

#pragma mark - Custom Function

- (void)createView {
    //添加第一个view
    UIView *firstView = [[UIView alloc] init];
    firstView.backgroundColor = [self randomColor];
    [_contentScrollView addSubview:firstView];
    UIView *superView = _contentScrollView.superview;
    WS(weakSelf);
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.and.bottom.mas_equalTo(0);
        make.bottom.equalTo(superView);
        make.width.and.height.equalTo(weakSelf.contentScrollView);
    }];
    
    //将第一个button和view添加到集合中
    [_buttonArray addObject:_firstButton];
    [_viewArray addObject:firstView];
    
    UIButton *lastButton = nil;
    UIView *lastView = nil;
    
    //循环动态添加其他button和view
    for (NSInteger i = 0; i < _buttonTitleArray.count; i++) {
        //添加button
        NSString *title = _buttonTitleArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor clearColor];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i;
        [button addTarget:_scrollTabView action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollTabView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastButton) {
                make.left.equalTo(lastButton.mas_right);
            } else {
                make.left.mas_equalTo(0);
            }
            make.top.and.bottom.mas_equalTo(0);
            if (i == weakSelf.buttonTitleArray.count - 1) {
                make.right.mas_equalTo(0);
            }
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(80);
        }];
        [_buttonArray addObject:button];
        lastButton = button;
        
        //添加view
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [self randomColor];
        [_contentScrollView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.left.equalTo(lastView.mas_right);
            } else {
                make.left.equalTo(firstView.mas_right);
            }
            make.top.mas_equalTo(0);
            if (i == weakSelf.buttonTitleArray.count - 1) {
                make.right.mas_equalTo(0);
            }
            make.width.and.height.equalTo(firstView);
        }];
        [_viewArray addObject:view];
        lastView = view;
    }
}

- (UIColor *)randomColor {
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

- (void)scrollToCenterWithIndex:(NSUInteger)index {
    if (index > 2 && index < _buttonArray.count - 2) {
        UIButton *button = _buttonArray[2];
        CGPoint centerPoint = [_scrollTabView convertPoint:button.center toView:_buttonArray[index]];
        NSLog(@"%@", @(centerPoint.x));
        [_scrollTabView setContentOffset:CGPointMake(-centerPoint.x, 0) animated:YES];
    } else if (index <= 2) {
        [_scrollTabView setContentOffset:CGPointZero animated:YES];
    } else {
        CGPoint bottomOffset = CGPointMake(_scrollTabView.contentSize.width - _scrollTabView.bounds.size.width, 0);
        [_scrollTabView setContentOffset:bottomOffset animated:YES];
    }
}

#pragma mark - STScrollTabViewDelegate

- (void)segmentView:(STScrollTabView *)scrollTabView didSelectedPage:(NSUInteger)index {
    [_contentScrollView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0)];
    [self scrollToCenterWithIndex:index];
    [_firstButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _contentScrollView) {
        CGFloat x = scrollView.contentOffset.x / SCREEN_WIDTH;
        [_scrollTabView setSegmentIndex:x];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _contentScrollView) {
        NSInteger index = scrollView.contentOffset.x / SCREEN_WIDTH;
        [self scrollToCenterWithIndex:index];
    }
}

@end
