//
//  ViewController.m
//  TPLab7.1
//
//  Created by fpmi on 29.04.16.
//  Copyright (c) 2016 Nikson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIColor *colour;
    CGLineCap lineCap;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgCanvas;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmColourChooser;
@property (weak, nonatomic) IBOutlet UISlider *sldPenWidth;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sgmLineCapChooser;
@property CGPoint lastPoint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    colour = [UIColor colorWithRed: 1.0f green: 0.0f blue: 0.0f alpha: 1.0f];
    
    _sgmColourChooser.tintColor = colour;
    lineCap = kCGLineCapButt;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *) event {
    UITouch *touch = [touches anyObject];
    
    [self setLastPoint:[touch locationInView:_imgCanvas]];
}

- (IBAction)onSldPenWidthValueChanged:(UISlider *)sender {
    int intVal = roundf(sender.value);
    
    sender.value = intVal;
}

- (IBAction)onSgmColourChooserValueChanged:(UISegmentedControl *)sender {
    float clr[] = { 0.0f, 0.0f, 0.0f };
    
    clr[_sgmColourChooser.selectedSegmentIndex] = 1.0f;
    colour = [UIColor colorWithRed:clr[0] green:clr[1] blue:clr[2] alpha:1.0f];
    sender.tintColor = colour;
}
- (IBAction)onSgmLineCapChooserValueChanged:(UISegmentedControl *)sender {
    lineCap = (CGLineCap)_sgmLineCapChooser.selectedSegmentIndex;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *) event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:_imgCanvas];
    
    UIGraphicsBeginImageContext(_imgCanvas.frame.size);
    
    CGRect rect = CGRectMake(0.0f, 0.0f, _imgCanvas.frame.size.width, _imgCanvas.frame.size.height);
    
    [[_imgCanvas image] drawInRect:rect];
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), lineCap);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), (float)_sldPenWidth.value);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), colour.CGColor);
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    [_imgCanvas setImage:UIGraphicsGetImageFromCurrentImageContext()];
    
    UIGraphicsEndImageContext();
    
    _lastPoint = currentPoint;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
