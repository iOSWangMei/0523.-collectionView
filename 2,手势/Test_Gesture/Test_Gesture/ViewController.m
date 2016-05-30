//
//  ViewController.m
//  Test_Gesture
//
//  Created by SuperWang on 15/10/25.
//  Copyright © 2015年 智游. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CGRect _rect;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *redView = [[UIView alloc]init];
    redView.frame = CGRectMake(100, 200, 200, 200);
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    
    
    //七种手势
    //1,tap(点击)
    //2,pan(平移)
    //3,swipe(轻扫)
    //4,pinch捏和
    //5,ScreenEdgePan边缘划入
    //6,rotation旋转
    //7,longPress长按
    //UIGestureRecognizer 所有手势抽象父类
    
    
    /*
    //1,点击
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    //点击所需的手指
    tapGesture.numberOfTouchesRequired = 1;
    //点击次数
    tapGesture.numberOfTapsRequired = 3;
    [self.view addGestureRecognizer:tapGesture];
    //*/
    
    
    /*
    //2,pan平移
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    [redView addGestureRecognizer:panGesture];
    //*/
    
    /*
    //3,轻扫
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesture:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
    //*/
    
    
    /*
    //4,捏合
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchGesture:)];
    [redView addGestureRecognizer:pinchGesture];
    //*/
    
    
    /*
    //5,旋转
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGesture:)];
    [redView addGestureRecognizer:rotationGesture];
    //*/
    
    /*
    //6,长按
    UILongPressGestureRecognizer *longPressGestrue = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    [redView addGestureRecognizer:longPressGestrue];
    //*/
    
    
    /*
    //7,边缘轻扫
    UIScreenEdgePanGestureRecognizer *screenEdigePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(screenEdigePan)];
    screenEdigePan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:screenEdigePan];
    //*/
    
    //[screenEdigePan requireGestureRecognizerToFail:longPressGestrue];
}

-(void)screenEdigePan
{
    NSLog(@"%s",__FUNCTION__);
}

//tap
-(void)tapGesture:(UITapGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
}

//pan
-(void)panGesture:(UIPanGestureRecognizer*)gesture
{
//    NSLog(@"%s",__FUNCTION__);
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
            
            break;
        case UIGestureRecognizerStateChanged:
        {
            //手势绑定的view
            UIView *view = gesture.view;
            CGPoint point = [gesture translationInView:view];
            NSLog(@"point:%@",NSStringFromCGPoint(point));
            view.frame = CGRectOffset(view.frame, point.x, point.y);
            [gesture setTranslation:CGPointZero inView:view];
        }
            break;
        case UIGestureRecognizerStateEnded:
            
            break;
            
        default:
            break;
    }
}

//请扫
-(void)swipeGesture:(UISwipeGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
}


//捏合
-(void)pinchGesture:(UIPinchGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            _rect = gesture.view.frame;
            NSLog(@"开始:%@",NSStringFromCGRect(_rect));
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            NSLog(@"%f",gesture.scale);
            CGFloat w = CGRectGetWidth(_rect)*(1-gesture.scale)/2;
            CGFloat h = CGRectGetHeight(_rect)*(1-gesture.scale)/2;
            UIView *view = gesture.view;
            //缩放
            //x = x+dx
            //y = y+dy
            //w = w+2*dx
            //h = h+2*xy
            view.frame = CGRectInset(_rect, w, h);
            
            NSLog(@"dx:%f-dy:%f",w,h);
            NSLog(@"%@",NSStringFromCGRect(view.frame));
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"end");
        }
            break;
            
        default:
            break;
    }
}

-(void)rotationGesture:(UIRotationGestureRecognizer*)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateChanged:
        {
            gesture.view.transform = CGAffineTransformMakeRotation(gesture.rotation);
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            gesture.view.transform = CGAffineTransformIdentity;
        }
            break;
            
        default:
            break;
    }
}

-(void)longPressGesture:(UILongPressGestureRecognizer*)gesture
{
    NSLog(@"%s",__FUNCTION__);
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            UIMenuController *menuCtr = [UIMenuController sharedMenuController];
            
            UIMenuItem *item1 = [[UIMenuItem alloc]initWithTitle:@"自定义" action:@selector(reset)];
            
            menuCtr.menuItems = @[item1];
            CGPoint poin = [gesture locationInView:gesture.view];
            [menuCtr setTargetRect:CGRectMake(poin.x, poin.y, 0, 0) inView:gesture.view];
            [menuCtr setMenuVisible:YES animated:YES];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            
        }
            break;
            
        default:
            break;
    }
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (action == @selector(reset)) {
//        return YES;
//    }
//    return NO;
//}

-(void)reset
{
    NSLog(@"%s",__FUNCTION__);
}

- (void)cut:(nullable id)sender
{
    
}
- (void)copy:(nullable id)sender
{
    
}
- (void)paste:(nullable id)sender
{
    
}

- (void)select:(nullable id)sender
{
    
}
- (void)selectAll:(nullable id)sender
{
    
}
- (void)delete:(nullable id)sender
{
    
}
- (void)makeTextWritingDirectionLeftToRight:(nullable id)sender
{
    
}
- (void)makeTextWritingDirectionRightToLeft:(nullable id)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
