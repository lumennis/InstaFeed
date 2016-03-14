//
//  ESViperWireframe.h
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import "ESLoginViperViewInterface.h"

@class ESLoginViperPresenter;

@interface ESLoginViperWireframe : NSObject

@property (nonatomic, strong) ESLoginViperPresenter* presenter;

- (void)presentViperControllerFromWindow:(UIWindow*)window;
- (void)presentViperControllerFromNavigationController:(UINavigationController*)nc;
- (void)presentModalOn:(UIViewController*)viewController;
- (UIViewController<ESLoginViperViewInterface>*)setupUserInterfaceWithParent:(UIViewController*)viewController;

- (void)dismissViperController;

@end
