//
//  ViewController.h
//  PageViewControllerBug
//
//  Created by Jamie McDaniel on 6/29/13.
//  Copyright (c) 2013 Curious Find. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

@protocol ViewControllerDelegate

@optional
- (void)viewControllerDidTouchPreviousButton:(ViewController *)viewController;
- (void)viewControllerDidTouchBeginningButton:(ViewController *)viewController;
- (void)viewControllerDidTouchNextButton:(ViewController *)viewController;

@end

@interface ViewController : UIViewController

@property (nonatomic, readonly) NSUInteger pageNumber;
@property (nonatomic, weak) id <ViewControllerDelegate> delegate;

- (id)initWithPageNumber:(NSUInteger)pageNumber;

@end


