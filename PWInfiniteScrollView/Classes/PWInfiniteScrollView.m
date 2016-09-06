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
    UIImageView *_reuseImageView;
    NSArray *_images;
    NSTimer *_timer;
    NSUInteger _imageCount;
    UIPageControl *_pageControl;
    NSUInteger _currentIndex;
}


- (id)initWithFrame:(CGRect)frame Images:(NSArray *)images Auto:(BOOL)isAuto
{
    if(self = [super initWithFrame:frame]){
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, 0);
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        NSAssert(images != nil, @"Images must not be nil");
        
        _images = images;
        _imageCount = _images.count;
        //取第一张
        _centerView = [[UIImageView alloc] initWithImage:_images[0]];
        _centerView.contentMode = UIViewContentModeScaleAspectFit;

        _centerView.frame = CGRectMake(_scrollView.bounds.size.width, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        _centerView.tag = 0;
        [_scrollView addSubview:_centerView];
        //初始化循环利用的View
        _reuseImageView = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
        _reuseImageView.frame = CGRectMake(_scrollView.bounds.size.width  * 2, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        _reuseImageView.image = _images[1];
        _reuseImageView.contentMode = UIViewContentModeScaleAspectFit;
        //Timer
        if(isAuto){
            //自动的话必须提前添加一个到右边
            [_scrollView addSubview:_reuseImageView];
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:TIMEINTERVAL target:self selector:@selector(autoChangePhoto) userInfo:nil repeats:YES];
            
            _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.5];
        }
        
        _pageControl= [[UIPageControl alloc] init];
        
        CGSize pageControlSize = [_pageControl sizeForNumberOfPages:_imageCount];
        _pageControl.frame = CGRectMake(self.center.x - pageControlSize.width / 2.0f, self.frame.size.height - 100, pageControlSize.width, pageControlSize.height);
        _pageControl.pageIndicatorTintColor = [UIColor blueColor];
        _pageControl.numberOfPages = _imageCount;
        [self addSubview:_pageControl];
        
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
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x + _scrollView.bounds.size.width, 0) animated:YES];
    if(_pageControl.currentPage == _imageCount){
        _pageControl.currentPage = 0;
    }else{
        [self changePhoto];
    }
}


- (void)changePhoto{
    
    CGFloat offsetX = _scrollView.contentOffset.x;
    CGFloat w = self.bounds.size.width;
    CGRect resumeViewRect = _reuseImageView.frame;
    NSInteger index = 0;
    if(offsetX > _centerView.frame.origin.x){ //向左划
        
        resumeViewRect.origin.x = _scrollView.contentSize.width - w;
        
        index = _centerView.tag + 1;
        
        if(index >= _imageCount)index = 0;
        
    }else{//向右划
        
        resumeViewRect.origin.x = 0;
        
        index = _centerView.tag - 1;
        
        if(index < 0)index = _imageCount - 1;
    }
    
    _currentIndex = index;
    _reuseImageView.frame = resumeViewRect;
    
    _reuseImageView.tag = index;
    
    _reuseImageView.image = _images[index];
    
    if(offsetX <=0 || offsetX >= w * 2){
        
        UIImageView *temp = _centerView;
        
        _centerView = _reuseImageView;
        
        _reuseImageView = temp;
        temp = nil;
        
        // 2.2.设置显示位置
        _centerView.frame = _reuseImageView.frame;
        
        _scrollView.contentOffset = CGPointMake(w, 0);
        
        [_reuseImageView removeFromSuperview];
        [self scrollViewDidEndDecelerating:_scrollView];
        
    }else{
        if(![_scrollView.subviews containsObject:_reuseImageView]){
            [_scrollView addSubview:_reuseImageView];
        }
    }
}


#pragma mark ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changePhoto];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     _pageControl.currentPage = (_currentIndex + 1) % _imageCount;
}

- (void)dealloc{
    [_timer invalidate];
    _timer = nil;
    _images = nil;
}

@end
