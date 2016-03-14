//
//  ESViperInteractor.h
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import "ESLoginViperInteractorO.h"

@interface ESLoginViperInteractor : NSObject <ESLoginViperInteractorInput>

@property (nonatomic, weak) id <ESLoginViperInteractorOutput> output;

@end
