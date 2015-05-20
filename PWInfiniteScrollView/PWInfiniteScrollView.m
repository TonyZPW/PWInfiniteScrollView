//
//  PWInfiniteScrollView.m
//  PWInfiniteScrollView
//
//  Created by Tony_Zhao on 5/2/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

#import "PWInfiniteScrollView.h"

NSTimeInterval TIMEINTERVAL = 1;

@interface PWInfiniteScrollView ()<UIScrollViewDelegate>

@end

@implementation PWInfiniteScrollView
{
    UIScrollView *_scrollView;
    UIImageView *_centerView;
    UIImageView *_rightShowView;
    UIImageView *_leftShowView;
    UIImageView *_reuseView;
    NSArray *_images;
    NSTimer *_timer;
    NSUInteger _imageCount;
//    UIPageControl *_pageControl;
    NSUInteger _currentIndex;
}


- (id)initWithFrame:(CGRect)frame Images:(NSArray *)images itemSize:(CGSize)imageSize linespacing:(CGFloat)lineSpacing Auto:(BOOL)isAuto
{
    if(self = [super initWithFrame:frame]){

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.bounds.size.width * 0.2, 0, self.bounds.size.width * 0.6, self.bounds.size.height)];
        _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * 4, 0);
        _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
//        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        NSAssert(images != nil, @"Images must not be nil");
        
        _images = images;
        _imageCount = _images.count;
        //取第一张
        _centerView = [[UIImageView alloc] initWithImage:_images[0]];
       
        _centerView.contentMode = UIViewContentModeScaleAspectFit;
        _centerView.layer.zPosition = 100;
        _centerView.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height * 0.8);
        _centerView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        _centerView.tag = 0;
        [_scrollView addSubview:_centerView];
        
        //初始化循环利用的View
        _rightShowView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        _rightShowView.frame = CGRectMake(_scrollView.bounds.size.width  * 2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height * 0.8);
        _rightShowView.image = _images[1];

        _rightShowView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_rightShowView];
        
        _leftShowView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        _leftShowView.frame = CGRectMake(0, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height * 0.8) ;
        _leftShowView.image = _images[_imageCount - 1];
        _leftShowView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_leftShowView];
        
        
        
//        //Timer
//        if(isAuto){
//            //自动的话必须提前添加一个到右边
//            
//            _timer = [NSTimer scheduledTimerWithTimeInterval:TIMEINTERVAL target:self selector:@selector(autoChangePhoto) userInfo:nil repeats:YES];
//            
//            _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.5];
//        }
//        
//        _pageControl= [[UIPageControl alloc] init];
//        
//        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_imageCount];
//        _pageControl.frame = CGRectMake(self.center.x - pageControlSize.width / 2.0f, self.frame.size.height - 100, pageControlSize.width, pageControlSize.height);
//        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
//        _pageControl.numberOfPages = _imageCount;
//        [self addSubview:_pageControl];
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    NSAssert(NO, @"Use initWithFrame:(CGRect)frame Images:(NSArray *)images method");
    if(self = [super initWithFrame:frame]){
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSAssert(NO, @"Use initWithFrame:(CGRect)frame Images:(NSArray *)images method");
    if(self = [super initWithCoder:aDecoder]){
        
    }
    return self;
}

- (instancetype)init
{
    NSAssert(NO, @"Use initWithFrame:(CGRect)frame Images:(NSArray *)images method");
    if(self = [super init]){
        
    }
    return self;
}

//定时器改变photo位置
- (void)autoChangePhoto{
//    
//    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + _scrollView.bounds.size.width, 0) animated:YES];
//    if(_pageControl.currentPage == _imageCount){
//        _pageControl.currentPage = 0;
//    }else{
//        [self changePhoto];
//    }
}

- (void)changePhoto{
    
    CGFloat offsetX = _scrollView.contentOffset.x;
    CGFloat w = _scrollView.bounds.size.width;
    NSInteger index = 0;
    _reuseView = (UIImageView *)[_scrollView viewWithTag:1000];
    
    if(offsetX > _scrollView.bounds.size.width){ //向左划
        
        if(_reuseView.superview == nil){
            _reuseView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _reuseView.contentMode = UIViewContentModeScaleAspectFit;
            _reuseView.tag = 1000;
            [_scrollView addSubview:_reuseView];
        }
        index = _centerView.tag + 1;
        if(index >= _imageCount)index = 0;
        _reuseView.frame = CGRectMake(_scrollView.contentSize.width - w, 0, _centerView.bounds.size.width, _centerView.bounds.size.height);
        _reuseView.image = _images[(index + 1) % _imageCount];
        
    }else{//向右划
        
        if(_reuseView.superview == nil){
            _reuseView = [[UIImageView alloc] initWithFrame:CGRectZero];
            _reuseView.contentMode = UIViewContentModeScaleAspectFit;
            _reuseView.tag = 1000;
            [_scrollView addSubview:_reuseView];
        }
        _reuseView.frame = CGRectMake(-_scrollView.bounds.size.width, 0, _centerView.bounds.size.width, _centerView.bounds.size.height);
            index = _centerView.tag - 1;

            if(index < 0)index = _imageCount - 1;

            _reuseView.image = _images[(index - 1) % _imageCount];
    }
    
    
    if(offsetX >= w * 2){
        _leftShowView.image = _centerView.image;
        _centerView.image = _rightShowView.image;
        
        _rightShowView.image = _reuseView.image;
        [_reuseView removeFromSuperview];
        _reuseView = nil;
        _scrollView.contentOffset = CGPointMake(w, 0);
        _centerView.tag = index;
        _currentIndex = index;
    }
    else if(offsetX <= 0){
        _rightShowView.image = _centerView.image;
        _centerView.image = _leftShowView.image;
        
        _leftShowView.image = _reuseView.image;
        [_reuseView removeFromSuperview];
        _reuseView = nil;

        _scrollView.contentOffset = CGPointMake(w, 0);
        _centerView.tag = index;
        _currentIndex = index;
    }
   
//      [self scrollViewDidEndDecelerating:_scrollView];
}


#pragma mark ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     [self changePhoto];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self calculatePosition:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self calculatePosition:scrollView];
}

- (void)calculatePosition:(UIScrollView *)scrollView{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat delta =  (contentOffsetX / _scrollView.bounds.size.width);
    if(delta >= 0.5){
        delta = ceil(delta);
    }else{
        delta = floor(delta);
    }
    [scrollView setContentOffset:CGPointMake(delta * _scrollView.bounds.size.width, 0)];

}

- (void)dealloc{
//    [_timer invalidate];
//    _timer = nil;
//    _images = nil;
}

@end
