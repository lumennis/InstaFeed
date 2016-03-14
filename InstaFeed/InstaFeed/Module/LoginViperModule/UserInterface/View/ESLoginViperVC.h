//
//  ESViperVC.h
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import "ESLoginViperModuleInterface.h"
#import "ESLoginViperViewInterface.h"

@interface ESLoginViperVC : UIViewController <ESLoginViperViewInterface>

@property (nonatomic, weak) id <ESLoginViperModuleInterface> eventHandler;

@end
