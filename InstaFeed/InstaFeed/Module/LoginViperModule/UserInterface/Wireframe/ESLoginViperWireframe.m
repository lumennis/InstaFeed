//
//  ESViperWireframe.m
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import "ESLoginViperWireframe.h"
#import "ESLoginViperInteractor.h"
#import "ESLoginViperVC.h"
#import "ESLoginViperPresenter.h"

@interface ESLoginViperWireframe ()

@property (nonatomic, strong) ESLoginViperVC* viperController;
@property (nonatomic, strong) UIViewController* presentedController;
@property (nonatomic, strong) UIViewController* parentViewController;

@end

@implementation ESLoginViperWireframe

- (void)presentViperControllerFromWindow:(UIWindow*)window
{
    [self _setup];
    
    UINavigationController* nc = [[UINavigationController alloc] initWithRootViewController:self.viperController];
    
    //dispatch_sync(dispatch_get_main_queue(), ^{
         window.rootViewController = nc;
    //});
    
    self.presentedController = nc;
}

- (void)presentViperControllerFromNavigationController:(UINavigationController*)nc
{
    [self _setup];
    
    //dispatch_sync(dispatch_get_main_queue(), ^{
        [nc pushViewController:self.viperController animated:YES];
    //});
    
    self.presentedController = nc;
}

- (void)presentModalOn:(UIViewController*)viewController
{
    [self _setup];
    
    //dispatch_sync(dispatch_get_main_queue(), ^{
        [viewController presentViewController:self.viperController animated:YES completion:nil];
    //});
    
    self.presentedController = viewController;
}

- (UIViewController<ESLoginViperViewInterface>*)setupUserInterfaceWithParent:(UIViewController*)viewController
{
    [self _setup];
    
    self.parentViewController = viewController;
    
    return self.viperController;
}

- (void)dismissViperController
{
    //dispatch_sync(dispatch_get_main_queue(), ^{
        if ([self _isModal])
        {
            [self.presentedController dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [(UINavigationController*)self.presentedController popViewControllerAnimated:YES];
        }
    //});
}


#pragma mark - Private

- (void)_setup
{
    ESLoginViperVC* viperController = [ESLoginViperVC new];
    ESLoginViperInteractor* interactor = [ESLoginViperInteractor new];
    ESLoginViperPresenter* presenter = [ESLoginViperPresenter new];
    
    interactor.output = presenter;
    
    viperController.eventHandler = presenter;
    
    presenter.interactor = interactor;
    presenter.wireframe = self;
    [presenter configurePresenterWithUserInterface:viperController];
    
    self.presenter = presenter;
    self.viperController = viperController;
}

- (BOOL)_isModal
{
    if (self.viperController.presentingViewController)
    {
        return YES;
    }
    if (self.viperController.presentingViewController.presentedViewController == self.viperController)
    {
        return YES;
    }
    if (self.viperController.navigationController.presentingViewController.presentedViewController == self.viperController.navigationController)
    {
        return YES;
    }
    return NO;
}

@end