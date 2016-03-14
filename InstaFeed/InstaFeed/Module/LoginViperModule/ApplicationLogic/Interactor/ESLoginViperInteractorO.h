//
//  ESViperInteractorO.h
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

@protocol ESLoginViperInteractorInput <NSObject>

- (void)loadData;

@end


@protocol ESLoginViperInteractorOutput <NSObject>

- (void)dataLoaded:(NSArray*)array;

@end

