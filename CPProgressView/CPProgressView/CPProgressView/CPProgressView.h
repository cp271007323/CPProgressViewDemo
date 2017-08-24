//
//  CPProgressView.h
//  CPProgressView
//
//  Created by lk06 on 17/1/13.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /**0 ~ 100*/
    CPProgressSizeType_zero2Hundred,
    /**0.00 ~ 1*/
    CPProgressSizeType_LessThanOne,
} CPProgressSizeType;

typedef void(^CPProgressViewCompleteBlcok)();

@interface CPProgressView : UIView
/**半径*/
@property (nonatomic , assign) CGFloat radius;          
/**进度*/
@property (nonatomic , assign) CGFloat progress;        
/**进度类型*/
@property (nonatomic , assign) CPProgressSizeType type;
/**X轴偏移量*/
@property (nonatomic , assign) CGFloat progressOffset_X;
/**Y轴偏移量*/
@property (nonatomic , assign) CGFloat progressOffset_Y;
/**进度颜色*/
@property (nonatomic , strong) UIColor *progressColor;
/**背景颜色*/
@property (nonatomic , strong) UIColor *progressBackgroundColor;
/**内圆与外圆的间距*/
@property (nonatomic , assign) CGFloat progressSpacing;


/**初始化*/
+ (instancetype)progressViewWithSuperView:(UIView *)superView
                                   radius:(CGFloat)radius;
/**初始化*/
- (instancetype)initWithSuperView:(UIView *)superView
                           radius:(CGFloat)radius;

/**写入进度 ，完成回调*/
-(void)setProgress:(CGFloat)progress
              type:(CPProgressSizeType)type
          complete:(CPProgressViewCompleteBlcok)compelte;


@end
