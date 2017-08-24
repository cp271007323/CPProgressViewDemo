//
//  CPProgressView.m
//  CPProgressView
//
//  Created by lk06 on 17/1/13.
//  Copyright © 2017年 lk06. All rights reserved.
//

#import "CPProgressView.h"

#define CPStartAngle (-M_PI_2)
#define CPEndAngle (M_PI * 2)

@interface CPProgressView ()
@property (nonatomic , assign) CGPoint cpCenter;
@property (nonatomic , copy) CPProgressViewCompleteBlcok  completeBlock;
@end

@implementation CPProgressView

+ (instancetype)progressViewWithSuperView:(UIView *)superView
                                   radius:(CGFloat)radius{
    return [[CPProgressView alloc] initWithSuperView:superView radius:radius];
}

- (instancetype)initWithSuperView:(UIView *)superView
                           radius:(CGFloat)radius{
    
    self = [super initWithFrame:CGRectMake(0, 0, radius * 2 + 2, radius * 2 + 2)];
    if (self) {
        self.radius = radius;
        self.center = superView.center;
        self.backgroundColor = [UIColor clearColor];
        [self initData];
    }
    return self;
}

-(void)initData{
    self.progressSpacing = 3;
    self.progressColor = [[UIColor whiteColor] colorWithAlphaComponent:.7];
    self.progressBackgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.7];
    self.cpCenter = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
}

#pragma mark - set

-(void)setProgress:(CGFloat)progress type:(CPProgressSizeType)type complete:(CPProgressViewCompleteBlcok)compelte{
    self.type = type;
    self.progress = progress;
    __weak typeof(self) weakself = self;
    self.completeBlock = ^{
        if (compelte) {
            compelte();
            [weakself removeFromSuperview];
        }
    };
}

-(void)setProgressOffset_X:(CGFloat)progressOffset_X{
    _progressOffset_X = progressOffset_X;
    self.center = CGPointMake(self.center.x + _progressOffset_X, self.center.y);
}

-(void)setProgressOffset_Y:(CGFloat)progressOffset_Y{
    _progressOffset_Y = progressOffset_Y;
    self.center = CGPointMake(self.center.x, self.center.y + _progressOffset_Y);
}


-(void)setProgress:(CGFloat)progress{
    _progress = self.type == CPProgressSizeType_zero2Hundred ? progress * .01 : progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.cpCenter radius:self.radius startAngle:CPStartAngle endAngle:CPEndAngle clockwise:YES];
    [self.progressBackgroundColor set];
    [path fill];
    CGFloat pro = self.progress;
    
    path = [UIBezierPath bezierPathWithArcCenter:self.cpCenter radius:self.radius startAngle:CPStartAngle endAngle:CPEndAngle clockwise:YES];
    [self.progressColor set];
    [path stroke];
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:self.cpCenter];
    [path addArcWithCenter:self.cpCenter radius:self.radius - self.progressSpacing startAngle:CPStartAngle endAngle:(CPEndAngle * pro) - M_PI_2  clockwise:YES];
    [self.progressColor set];
    [path closePath];
    [path fill];
    
    if (pro >= 1) {
        if (self.completeBlock) self.completeBlock();
    }
}


@end
