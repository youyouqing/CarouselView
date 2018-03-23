//
//  XKCarouselView.m
//  DecentTrainUser
//
//  Created by xiekang on 2018/3/23.
//  Copyright © 2018年 zhengjing. All rights reserved.
//

#import "XKCarouselView.h"


@interface XKCarouselView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrolleView;


@property(nonatomic,strong)UIPageControl *pageControl;


@property(nonatomic,strong)NSTimer *timer;

@end
@implementation XKCarouselView

-(instancetype)initWithFrame:(CGRect)frame imageWithURlS:(NSArray *)urlsArr;
{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        if (urlsArr.count == 0) {
            return nil;
        }//无数据就不用初始化了
        
        self.scrolleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        self.scrolleView.pagingEnabled = YES;
        
        
        
        self.scrolleView.delegate = self;
        
        self.scrolleView.showsVerticalScrollIndicator = NO;
        self.scrolleView.showsHorizontalScrollIndicator = NO;
        
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        
        [self addSubview:self.pageControl];
        
        [self addSubview:self.scrolleView];
        
        [self.pageControl addTarget:self action:@selector(clickPageControl) forControlEvents:UIControlEventValueChanged];
        
        
        [self setUpScollViewImages:urlsArr];
        
        if (urlsArr.count>1) {
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:XKInterval target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
            
        }
        
    }
   
    
    return self;
    
}


-(instancetype)initWithFrame:(CGRect)frame imageWithLocal:(NSArray *)LocalArr;
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        if (LocalArr.count == 0) {
            return nil;
        }//无数据就不用初始化了
        
        self.scrolleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        self.scrolleView.pagingEnabled = YES;
        
        self.scrolleView.delegate = self;
        
        self.scrolleView.showsVerticalScrollIndicator = NO;
        self.scrolleView.showsHorizontalScrollIndicator = NO;
        
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        
        [self addSubview:self.pageControl];
        
        [self addSubview:self.scrolleView];
        
        [self.pageControl addTarget:self action:@selector(clickPageControl) forControlEvents:UIControlEventValueChanged];
        
        [self setUpScrollViewLocalImages:LocalArr];
        
        if (LocalArr.count>1) {
            
            self.timer = [NSTimer scheduledTimerWithTimeInterval:XKInterval target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
            
        }
        
        
    }
    
    
    
    return self;
}

-(void)setUpScollViewImages:(NSArray *)imagesArr;
{
    
    if (imagesArr.count == 1) {
        
        self.scrolleView.contentSize = self.frame.size;
 
        UIImageView *image = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))];
        image.image = [UIImage imageNamed:imagesArr[0]];
        [self.scrolleView addSubview:image];
        image.userInteractionEnabled = YES;
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickFouncation)];
        [image addGestureRecognizer:tap];
        [self.timer setFireDate:[NSDate distantFuture]];
        return;
    }
    
    self.scrolleView.contentSize = CGSizeMake((imagesArr.count+2)*self.frame.size.width, 0);
    
    self.scrolleView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
    
    for (int i = 0; i<imagesArr.count+2; i++) {
        
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:(CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))];
       
        if (i == 0) {
            
             NSString *imageName =   [imagesArr lastObject];
            
             image.image = [UIImage imageNamed:imageName];
        }
        else if(i == imagesArr.count+1)
        {
            NSString *imageName =   [imagesArr firstObject];
            
            image.image = [UIImage imageNamed:imageName];
            
        }
        else
        {
            
           
            
            image.image = [UIImage imageNamed:imagesArr[i-1]];
            
        }
        
        [self.scrolleView addSubview:image];
        image.userInteractionEnabled = YES;
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickFouncation)];
        [image addGestureRecognizer:tap];
        [self.timer setFireDate:[NSDate distantFuture]];
        
    }
    
    self.pageControl.numberOfPages = imagesArr.count;
    
    
}

-(void)setUpScrollViewLocalImages:(NSArray *)LocalImagesArr;
{
    
    if (LocalImagesArr.count == 1) {
        
        self.scrolleView.contentSize = self.frame.size;
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))];
        image.image = [UIImage imageNamed:LocalImagesArr[0]];
        [self.scrolleView addSubview:image];
        image.userInteractionEnabled = YES;
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickFouncation)];
        [image addGestureRecognizer:tap];
        [self.timer setFireDate:[NSDate distantFuture]];
        return;
    }
    
    self.scrolleView.contentSize = CGSizeMake((LocalImagesArr.count+2)*self.frame.size.width, 0);
    
    self.scrolleView.contentOffset = CGPointMake(self.frame.size.width, 0);
    
    
    for (int i = 0; i<LocalImagesArr.count+2; i++) {
        
        
        UIImageView *image = [[UIImageView alloc] initWithFrame:(CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))];
        
        if (i == 0) {
            
            NSString *imageName =   [LocalImagesArr lastObject];
            
            image.image = [UIImage imageNamed:imageName];
        }
        else if(i == LocalImagesArr.count+1)
        {
            NSString *imageName =   [LocalImagesArr firstObject];
            
            image.image = [UIImage imageNamed:imageName];
            
        }
        else
        {
            
            
            
            image.image = [UIImage imageNamed:LocalImagesArr[i-1]];
            
        }
        
        [self.scrolleView addSubview:image];
        image.userInteractionEnabled = YES;
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClickFouncation)];
        [image addGestureRecognizer:tap];
        [self.timer setFireDate:[NSDate distantFuture]];
        
    }
    
    self.pageControl.numberOfPages = LocalImagesArr.count;
    
    
}

-(void)imageClickFouncation
{
    
    NSInteger index = self.scrolleView.contentOffset.x / self.frame.size.width;
    
    if (self.imageBlock) {
        
        if (self.scrolleView.contentSize.width == self.frame.size.width) {
            self.imageBlock(index);
        }else{
            self.imageBlock(index - 1);
        }
    }
}



-(void)clickPageControl
{
    [self.timer setFireDate:[NSDate distantFuture]];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.scrolleView.contentOffset = CGPointMake((self.pageControl.currentPage + 1) * self.frame.size.width, 0);
        
    } completion:^(BOOL finished) {
        
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:XKInterval]];
    }];
    
    
}
-(void)timeAction
{
    
    NSInteger index = self.scrolleView.contentOffset.x / self.frame.size.width+1;
    
    CGPoint piont = self.scrolleView.contentOffset;
    
    piont.x = self.frame.size.width * index;
    
    [self.scrolleView setContentOffset:piont animated:YES];
    
}
#pragma mark   UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;     {
    if (scrollView.contentOffset.x <= 0) {//滚动到最前面时回到真实的最后一张
        self.scrolleView.contentOffset = CGPointMake(self.frame.size.width * self.pageControl.numberOfPages , 0);
    }
    //滚动到最后一张假图的时候 回到第一张真图
    if (scrollView.contentOffset.x >= (self.pageControl.numberOfPages + 1) * self.frame.size.width) {
        self.scrolleView.contentOffset = CGPointMake(self.frame.size.width, 0);
    }
    
    
    self.pageControl.currentPage = self.scrolleView.contentOffset.x / self.frame.size.width - 1;
    
}
//用户拖拽时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //暂停定时器 定时器没有暂停的方法 只能设置 开启时间
    [self.timer setFireDate:[NSDate distantFuture]];
}

//结束拖拽时在开启定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:XKInterval]];
    
}
@end
