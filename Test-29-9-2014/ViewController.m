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
    self.tableData = [[NSArray alloc] initWithObjects:@"Profile", @"Explore", @"Favorites", @"Search", @"Inbox", @"Sessions", @"Mics", nil];
    [self.tbvOptions setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Parrent View
- (IBAction)btnMenuTouchUpInside:(id)sender{
    [self showParentView];
}

- (IBAction)btnCloseTouchUpInside:(id)sender {
    self.viewParent.hidden = YES;
}
- (void)showParentView{
//    [self blurView];
    [self blur];
    [self.viewParent bringSubviewToFront:self.btnClose];
    [self.viewParent bringSubviewToFront:self.tbvOptions];
//    self.viewParent = [self blurView];
    [self.view addSubview:self.viewParent];
    self.viewParent.transform =CGAffineTransformMakeScale(.5, .5);
    
    self.viewParent.hidden = NO;
    self.viewParent.alpha = 0.0f;
    self.viewParent.backgroundColor = [UIColor whiteColor];
    self.viewParent.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView beginAnimations:@"fadeInNewView" context:NULL];
    [UIView setAnimationDuration:0.5];
    self.viewParent.transform = CGAffineTransformMakeScale(1,1);
    self.viewParent.alpha = 1.0f;
    [UIView commitAnimations];
    [self.tbvOptions reloadData];
}


- (void)blur{
    CALayer *layer = [self.viewParent layer];
    [layer setShouldRasterize:YES];
    [layer setRasterizationScale:0.5];
    
    //Get a screen capture from the current view.
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //Blur the image
    CIImage *blurImg = [CIImage imageWithCGImage:viewImg.CGImage];
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    [clampFilter setValue:blurImg forKey:@"inputImage"];
    [clampFilter setValue:[NSValue valueWithBytes:&transform objCType:@encode(CGAffineTransform)] forKey:@"inputTransform"];
    
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:clampFilter.outputImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat:10.0f] forKey:@"inputRadius"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImg = [context createCGImage:gaussianBlurFilter.outputImage fromRect:[blurImg extent]];
    UIImage *outputImg = [UIImage imageWithCGImage:cgImg];
    
    //Add UIImageView to current view.
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.viewParent.bounds];
    imgView.image = outputImg;
    [self.viewParent addSubview:imgView];
}

#pragma mark Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }

    if (indexPath.row==0) {
        UIImageView *image = (UIImageView*)[cell viewWithTag:101];
        image.backgroundColor = [UIColor greenColor];
        image = nil;
    }
    
    UILabel *lblTitle = (UILabel*)[cell viewWithTag:102];
    NSLog(@"%@", [self.tableData objectAtIndex:indexPath.row]);
    lblTitle.text = [self.tableData objectAtIndex:indexPath.row];
    
//    lblTitle = nil;
//    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    UITableViewCell *cell = (UITableViewCell*)[self tableView:self.tbvOptions
                                        cellForRowAtIndexPath:indexPath];
    UIImageView *image = (UIImageView*)[cell viewWithTag:101];
    image.backgroundColor = [UIColor greenColor];
    image = nil;
}
- (void)tableView: (UITableView *) tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell*)[self tableView:self.tbvOptions
                                        cellForRowAtIndexPath:indexPath];
    UIImageView *image = (UIImageView*)[cell viewWithTag:101];
    image.backgroundColor = [UIColor clearColor];
    image = nil;
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
