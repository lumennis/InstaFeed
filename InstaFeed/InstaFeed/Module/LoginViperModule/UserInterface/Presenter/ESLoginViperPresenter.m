//
//  ESViperPresenter.m
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import "ESLoginViperPresenter.h"

@interface ESLoginViperPresenter ()

@end

@implementation ESLoginViperPresenter

- (void)configurePresenterWithUserInterface:(UIViewController<ESLoginViperViewInterface>*)userInterface
{
    self.userInterface = userInterface;
    [self.interactor loadData];
}


#pragma mark - Output

- (void)dataLoaded:(NSArray*)array
{
    //TODO: update userinterface if needed with loaded data
}


#pragma mark - Module Interface

- (void)backSelected
{
    [self.wireframe dismissViperController];
}

@end
