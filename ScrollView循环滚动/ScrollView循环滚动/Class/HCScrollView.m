//
//  HCScrollView.m
//  ScrollView循环滚动
//
//  Created by HC on 15/3/12.
//  Copyright (c) 2015年 test. All rights reserved.
//

#import "HCScrollView.h"

@interface HCScrollView ()<UIScrollViewDelegate>
{
    UIScrollView *myScrollView;
    int scrollViewPage;//scrollView 的Page,取值范围1,2,3
    NSMutableArray *imageArray;//imageView 的数据源
    UIPageControl *pageControl;
    int currentPage;//当前显示的第几个image
    NSTimer *timer;
}

@end

@implementation HCScrollView

-(instancetype)initWithFrame:(CGRect)frame withImageArray:(NSArray *)array
{
    if (self = [super initWithFrame:frame]) {
        //
        imageArray = [NSMutableArray arrayWithArray:array];
        //处理一下imageArray,将最后一个对象转移到第一个，这样显示的时候才能和传过来的数组相对应
        NSArray *array = [imageArray subarrayWithRange:NSMakeRange(imageArray.count-1, 1)];
        [imageArray removeObjectsInArray:array];
        for (id arr in array) {
            [imageArray insertObject:arr atIndex:0];
        }
        //scrollview
        myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        myScrollView.pagingEnabled = YES;
        myScrollView.delegate = self;
        myScrollView.showsHorizontalScrollIndicator = NO;
        myScrollView.showsVerticalScrollIndicator = NO;
        myScrollView.contentSize = CGSizeMake(CGRectGetWidth(myScrollView.frame)*3, CGRectGetHeight(myScrollView.frame));
        [self addSubview:myScrollView];
        //pageControl
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        pageControl.center = CGPointMake(CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame) - 20);
        pageControl.numberOfPages = imageArray.count;
        pageControl.currentPage = 0;
        [self addSubview:pageControl];
        for (int i = 0;i<3;i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(myScrollView.frame)*i, 0, CGRectGetWidth(myScrollView.frame), CGRectGetHeight(myScrollView.frame))];
            imageView.tag = 100+i;
            NSString *name = [imageArray objectAtIndex:i];
            imageView.image = [UIImage imageNamed:name];
            [myScrollView addSubview:imageView];
        }
        //myScrollView 显示的一直都是第二页
        myScrollView.contentOffset = CGPointMake(CGRectGetWidth(myScrollView.frame), 0);
        currentPage = 0;
        timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    scrollViewPage = page;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self changeImageDataSource];
    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [timer invalidate];
}

-(void)autoScroll
{
    [UIView animateWithDuration:0.25 animations:^{
        [myScrollView setContentOffset:CGPointMake(myScrollView.frame.size.width * 2, 0) animated:NO];
    }];
    [self changeImageDataSource];
}

-(void)changeImageDataSource
{
    if (scrollViewPage == 0) {
        
        NSArray *array = [imageArray subarrayWithRange:NSMakeRange(imageArray.count-1, 1)];
        [imageArray removeObjectsInArray:array];
        for (id arr in array) {
            [imageArray insertObject:arr atIndex:0];
        }
        for (int i = 0; i<imageArray.count; i++) {
            UIImageView *imageView = (UIImageView *)[myScrollView viewWithTag:100+i];
            imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        }
        currentPage --;
        if (currentPage < 0) {
            currentPage = (int)(imageArray.count - 1);
        }
    }
    if (scrollViewPage==2) {
        
        NSArray *array = [imageArray subarrayWithRange:NSMakeRange(0, 1)];
        [imageArray removeObjectsInArray:array];
        for (id arr in array) {
            [imageArray addObject:arr];
        }
        for (int i = 0; i<imageArray.count; i++) {
            UIImageView *imageView = (UIImageView *)[myScrollView viewWithTag:100+i];
            imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:i]];
        }
        currentPage ++;
        if (currentPage == imageArray.count) {
            currentPage = 0;
        }
    }
    pageControl.currentPage =currentPage;
    [myScrollView setContentOffset:CGPointMake(myScrollView.frame.size.width, 0)];
    
}









@end
