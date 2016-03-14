//
//  ESViperPresenter.h
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import "ESLoginViperInteractorO.h"
#import "ESLoginViperWireframe.h"
#import "ESLoginViperViewInterface.h"
#import "ESLoginViperModuleDelegate.h"
#import "ESLoginViperModuleInterface.h"

@interface ESLoginViperPresenter : NSObject <ESLoginViperInteractorOutput, ESLoginViperModuleInterface>

@property (nonatomic, strong) id<ESLoginViperInteractorInput> interactor;
@property (nonatomic, strong) ESLoginViperWireframe* wireframe;

@property (nonatomic, weak) UIViewController<ESLoginViperViewInterface>* userInterface;
@property (nonatomic, weak) id<ESLoginViperModuleDelegate> viperModuleDelegate;

- (void)configurePresenterWithUserInterface:(UIViewController<ESLoginViperViewInterface>*)userInterface;

@end
