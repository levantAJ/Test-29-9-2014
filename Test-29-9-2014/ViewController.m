//
//  ViewController.m
//  Test-29-9-2014
//
//  Created by AJ on 9/29/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addBackground];
    [self addMenuButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Add button
- (void)addMenuButton{
    [self.btnMenu setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    self.btnMenu.backgroundColor = [UIColor blackColor];
}

#pragma mark Add background
- (void)addBackground{
    UIImageView *backGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    backGround.image = [UIImage imageNamed:@"splash.png"];
    [self.view addSubview:backGround];
    backGround = nil;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
