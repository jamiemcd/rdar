//
//  ViewController.m
//  PageViewControllerBug
//
//  Created by Jamie McDaniel on 6/29/13.
//  Copyright (c) 2013 Curious Find. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, readwrite) NSUInteger pageNumber;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *beginningButton;

@end

@implementation ViewController

- (id)initWithPageNumber:(NSUInteger)pageNumber
{
    self = [super init];
    if (self)
    {
        self.pageNumber = pageNumber;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

	self.label = [[UILabel alloc] init];
    [self.label setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.label.font = [UIFont boldSystemFontOfSize:160];
    self.label.text = [NSString stringWithFormat:@"%i", self.pageNumber];
    [self.view addSubview:self.label];
    
    self.previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.previousButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.previousButton setTitle:@"Previous" forState:UIControlStateNormal];
    [self.previousButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.previousButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.previousButton addTarget:self action:@selector(previousButtonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.previousButton];
    
    self.beginningButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.beginningButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.beginningButton setTitle:@"Go to Beginning" forState:UIControlStateNormal];
    [self.beginningButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.beginningButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.beginningButton addTarget:self action:@selector(beginningButtonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.beginningButton];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.nextButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.nextButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [self.nextButton addTarget:self action:@selector(nextButtonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nextButton];
    
    NSDictionary *views = @{ @"label": self.label,
                             @"previousButton": self.previousButton,
                             @"beginningButton": self.beginningButton,
                             @"nextButton": self.nextButton };
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[previousButton]" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[previousButton]" options:0 metrics:nil views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.beginningButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[beginningButton]" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[nextButton]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[nextButton]" options:0 metrics:nil views:views]];
    
    if (self.pageNumber == 1)
    {
        self.previousButton.hidden = YES;
        self.beginningButton.hidden = YES;
    }
    
    if (self.pageNumber == 10)
    {
        self.nextButton.hidden = YES;
    }
}

- (void)previousButtonTouchHandler:(UIButton *)sender
{
    if (self.delegate)
    {
        [self.delegate viewControllerDidTouchPreviousButton:self];
    }
}

- (void)beginningButtonTouchHandler:(UIButton *)sender
{
    if (self.delegate)
    {
        [self.delegate viewControllerDidTouchBeginningButton:self];
    }
}

- (void)nextButtonTouchHandler:(UIButton *)sender
{
    if (self.delegate)
    {
        [self.delegate viewControllerDidTouchNextButton:self];
    }
}

@end
