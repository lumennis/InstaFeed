//
//  ESViperView.h
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import <Masonry/Masonry.h>

@protocol ESLoginViperContentViewDelegate <NSObject>

@end

@interface ESLoginViperView : UIView

@property (nonatomic, strong) UIButton* loginButton;

@end
