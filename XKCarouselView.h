//
//  XKCarouselView.h
//  DecentTrainUser
//
//  Created by xiekang on 2018/3/23.
//  Copyright © 2018年 zhengjing. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^CarouseViewBlock)(NSInteger indexP);

#define XKInterval 2

@interface XKCarouselView : UIView


/**
 图片点击选择
 */
@property(nonatomic,copy) CarouseViewBlock imageBlock;

/**
 返回的图片地址 和2个必要的参数

 @param frame
 @param urls
 @return
 */
-(instancetype)initWithFrame:(CGRect)frame imageWithURlS:(NSArray *)urlsArr;


/**
 2个必要的参数   图片地址

 @param frame
 @param LocalArr
 @return
 */
-(instancetype)initWithFrame:(CGRect)frame imageWithLocal:(NSArray *)LocalArr;

/**
 重新配置轮播的图片

 @param imagesArr
 */
-(void)setUpScollViewImages:(NSArray *)imagesArr;

/**
 重新配置本地的轮播的图片

 @param LocalImagesArr 
 */
-(void)setUpScrollViewLocalImages:(NSArray *)LocalImagesArr;


@end
