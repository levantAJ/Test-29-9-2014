//
//  ViewController.h
//  Test-29-9-2014
//
//  Created by AJ on 9/29/14.
//  Copyright (c) 2014 AJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnMenu;
@property (weak, nonatomic) IBOutlet UIView *viewParent;
- (IBAction)btnMenuTouchUpInside:(id)sender;

@end

