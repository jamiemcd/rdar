//
//  ViewController.m
//  UIImagePickerControllerBug
//
//  Created by Jamie McDaniel on 5/16/14.
//  Copyright (c) 2014 Curious Find. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NSArray *viewConstraints;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.button setTitle:@"Show ImagePicker" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    [self.view setNeedsUpdateConstraints];
}

- (void)buttonTouchHandler:(UIButton *)button
{
    [self logIdleTimerDisabled];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (self.viewConstraints)
    {
        [self.view removeConstraints:self.viewConstraints];
    }
    
    NSMutableDictionary *views = [@{ @"button": self.button} mutableCopy];
    NSMutableArray *constraints = [NSMutableArray array];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[button]-20-|" options:0 metrics:nil views:views]];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[button]-|" options:0 metrics:nil views:views]];
    
    self.viewConstraints = [constraints copy];
    [self.view addConstraints:self.viewConstraints];
}

- (void)logIdleTimerDisabled
{
    BOOL idleTimerDisabled = [UIApplication sharedApplication].idleTimerDisabled;
    NSLog(@"idleTimerDisabled = %d", idleTimerDisabled);
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self logIdleTimerDisabled];
    [self dismissViewControllerAnimated:YES completion:^{
        [self logIdleTimerDisabled];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self logIdleTimerDisabled];
    [self dismissViewControllerAnimated:YES completion:^{
        [self logIdleTimerDisabled];
    }];
}

@end
