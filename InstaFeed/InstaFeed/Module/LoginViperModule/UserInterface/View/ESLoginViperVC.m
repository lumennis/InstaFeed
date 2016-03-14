//
//  ESViperVC.m
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import "ESLoginViperVC.h"
#import "ESLoginViperView.h"

@interface ESLoginViperVC () <ESLoginViperContentViewDelegate>

@property (nonatomic, strong) ESLoginViperView* contentView;

@end

@implementation ESLoginViperVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.contentView = [ESLoginViperView new];
    }
    return self;
}

- (void)loadView
{
    self.view = self.contentView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.contentView.loginButton addTarget:self action:@selector(loginSelected) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Action

- (void)loginSelected
{
    
}



@end
