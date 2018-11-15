//
//  ViewController.m
//  basketAnimation
//
//  Created by 王得胜 on 2018/11/16.
//  Copyright © 2018 com.youqii.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
@property (nonatomic , strong) UIView * contentView ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width ;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height ;
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,screenWidth , screenHeight)];
    self.contentView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.contentView];
    
    
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(300.0*1/4, 0) controlPoint2:CGPointMake(300.0*3/4, 300)];
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath ;
    shapeLayer.lineWidth = 3.0 ;
    //    shapeLayer.backgroundColor = [UIColor grayColor].CGColor ;
    shapeLayer.fillColor = [UIColor blueColor].CGColor ;
    shapeLayer.strokeColor = [UIColor redColor].CGColor ;
    [self.contentView.layer addSublayer:shapeLayer];
    
    // 添加一个滑动的图层
    CALayer * slipLayer = [CALayer layer];
    slipLayer.frame = CGRectMake(0, 0, 50, 50);
    slipLayer.position = CGPointMake(0, 150);
    slipLayer.contents = (__bridge id)[UIImage imageNamed:@"timg.jpeg"].CGImage ;
    slipLayer.affineTransform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4);
    [self.contentView.layer addSublayer:slipLayer];
    
    // 根据position创建一个(图层的中心点)关建帧动画，
    CAKeyframeAnimation * keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyframeAnimation.duration = 4.0 ;
    keyframeAnimation.path = bezierPath.CGPath ;
    keyframeAnimation.repeatCount = 100 ;
    // 把rotationMode设置=kCAAnimationRotateAuto 根据曲线的切线自动旋转
    keyframeAnimation.rotationMode = kCAAnimationRotateAuto ;
    
    // slipLayer 添加一个动画
    [slipLayer addAnimation:keyframeAnimation forKey:nil];
    
}
@end
