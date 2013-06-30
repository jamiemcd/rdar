//
//  PageViewController.m
//  PageViewControllerBug
//
//  Created by Jamie McDaniel on 6/29/13.
//  Copyright (c) 2013 Curious Find. All rights reserved.
//

#import "PageViewController.h"
#import "ViewController.h"

@interface PageViewController () <UIPageViewControllerDataSource, ViewControllerDelegate>

// An array of 10 ViewController instances
@property (nonatomic, strong) NSArray *viewControllersArray;

@end

@implementation PageViewController

- (id)init
{
    self = [super initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    if (self)
    {

    }
    
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.dataSource = self;
    
    self.viewControllersArray = @[ [[ViewController alloc] initWithPageNumber:1],
                                   [[ViewController alloc] initWithPageNumber:2],
                                   [[ViewController alloc] initWithPageNumber:3],
                                   [[ViewController alloc] initWithPageNumber:4],
                                   [[ViewController alloc] initWithPageNumber:5],
                                   [[ViewController alloc] initWithPageNumber:6],
                                   [[ViewController alloc] initWithPageNumber:7],
                                   [[ViewController alloc] initWithPageNumber:8],
                                   [[ViewController alloc] initWithPageNumber:9],
                                   [[ViewController alloc] initWithPageNumber:10] ];
    
    ViewController *viewController = self.viewControllersArray[0];
    viewController.delegate = self;
    [self setViewControllers:@[viewController] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

// This method takes a ViewController and returns the previous ViewController in the array (or nil)
- (ViewController *)previousViewControllerForViewController:(ViewController *)viewController
{
    ViewController *previousViewController;
    NSUInteger index = viewController.pageNumber - 1;
    if (index > 0)
    {
        previousViewController = self.viewControllersArray[index - 1];
        previousViewController.delegate = self;
    }
    
    return previousViewController;
}

// This method takes a ViewController and returns the next ViewController in the array (or nil)
- (ViewController *)nextViewControllerForViewController:(ViewController *)viewController
{
    ViewController *nextViewController;
    NSUInteger index = viewController.pageNumber - 1;
    if (index < [self.viewControllersArray count] - 1)
    {
        nextViewController = self.viewControllersArray[index + 1];
        nextViewController.delegate = self;
    }
    
    return nextViewController;
}

- (void)navigateToViewController:(ViewController *)viewController reverse:(BOOL)reverse
{
    [self setViewControllers:@[viewController]
                   direction:(reverse) ? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward
                    animated:YES
                  completion:nil];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{    
    return [self previousViewControllerForViewController:(ViewController *)viewController];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    return [self nextViewControllerForViewController:(ViewController *)viewController];
}

#pragma mark - ViewControllerDelegate

- (void)viewControllerDidTouchPreviousButton:(ViewController *)viewController
{
    ViewController *previousViewController = [self previousViewControllerForViewController:viewController];
    if (previousViewController)
    {
        [self navigateToViewController:previousViewController reverse:YES];
    }
}

- (void)viewControllerDidTouchBeginningButton:(ViewController *)viewController
{
    // This is where the bug occurs. If you touch the "Go to Beginning" button and we navigate to the beginning, then if you swipe to the next page it will be incorrect.
    // Oddly enough, if you instead go to the next page via the "Next" button, it works correctly.
    //
    // This bug is discussed at http://stackoverflow.com/questions/12939280/uipageviewcontroller-navigates-to-wrong-page-with-scroll-transition-style
    //
    // The work around listed, however, creates a memory leak. ViewControllers are not dealloced.
    //
    ViewController *beginningViewController = self.viewControllersArray[0];
    [self navigateToViewController:beginningViewController reverse:YES];
}

- (void)viewControllerDidTouchNextButton:(ViewController *)viewController
{
    ViewController *nextViewController = [self nextViewControllerForViewController:viewController];
    if (nextViewController)
    {
        [self navigateToViewController:nextViewController reverse:NO];
    }
}

@end
