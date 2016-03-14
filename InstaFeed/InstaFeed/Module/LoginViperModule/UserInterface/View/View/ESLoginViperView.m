//
//  ESViperView.m
//  InstaFeed
//
//  Created by Евгений on 3/13/16.
//  Copyright © 2016 Евгений. All rights reserved.
//

#import "ESLoginViperView.h"
#import "LVGKeyboardInputView.h"
#import "Macros.h"

@interface ESLoginViperView () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView* backgroundImageView;
@property (nonatomic, strong) UIImageView *logoImageView;
@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView* placeholderViewInScrollView;

@property (nonatomic, strong) LVGKeyboardInputView* keyboardInputView;
@property (nonatomic, strong) NSArray* textFields;

@property (nonatomic, strong) UITextField* loginTextField;
@property (nonatomic, strong) UITextField* passwordTextField;

@end
#warning вынести все в константы
@implementation ESLoginViperView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor lightGrayColor];
        self.backgroundImageView;
        self.scrollView;
        self.logoImageView;
        self.loginTextField;
        self.passwordTextField;
        [self setupKeyboard];
    }
    return self;
}


#pragma mark - Lazy Load

- (UIImageView*)backgroundImageView
{
    if (!_backgroundImageView)
    {
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.userInteractionEnabled = YES;
        _backgroundImageView.image = [UIImage imageNamed:@"LoginBackground"];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_backgroundImageView];
        
        [_backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _backgroundImageView;
}

- (UIScrollView*)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.contentSize = self.bounds.size;
        _scrollView.userInteractionEnabled = YES;
        [_backgroundImageView addSubview:_scrollView];

        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_backgroundImageView);
        }];
        
        if (!_placeholderViewInScrollView)
        {
            _placeholderViewInScrollView = [UIView new];
            [_scrollView addSubview:_placeholderViewInScrollView];
            
            [_placeholderViewInScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(_scrollView);
                make.centerX.equalTo(_scrollView);
                make.centerY.equalTo(_scrollView);
            }];
        }
    }
    return _scrollView;
}

- (UIImageView*)logoImageView
{
    if (!_logoImageView)
    {
        _logoImageView = [UIImageView new];
        _logoImageView.image = [UIImage imageNamed:@"InstaIcon"];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_placeholderViewInScrollView addSubview:_logoImageView];
        
        [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self).centerOffset(CGPointMake(0, -150));
            make.width.equalTo(@150);
            make.height.equalTo(@150);
        }];
        
        UIImageView *instaLogoImageView = [UIImageView new];
        instaLogoImageView.image = [UIImage imageNamed:@"InstaLogo"];
        instaLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_placeholderViewInScrollView addSubview:instaLogoImageView];
        
        [instaLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_logoImageView).centerOffset(CGPointMake(0, 110));
            make.width.equalTo(@150);
            make.height.equalTo(@60);
        }];

        
    }
    return _logoImageView;
}

- (UITextField*)loginTextField
{
    if (!_loginTextField)
    {
        _loginTextField = [UITextField new];
        _loginTextField.delegate = self;
        _loginTextField.layer.cornerRadius = 5.f;
        _loginTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _loginTextField.textAlignment = NSTextAlignmentCenter;
        _loginTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _loginTextField.backgroundColor = UIColorFromRGBWithAlpha(0xAAAAAA, 0.3f);
        _loginTextField.font = [UIFont systemFontOfSize:12.f];
        _loginTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Login", nil) attributes:@{NSForegroundColorAttributeName: [[UIColor whiteColor] colorWithAlphaComponent:0.5]}];
        [_placeholderViewInScrollView addSubview:_loginTextField];
        
        [_loginTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self).centerOffset(CGPointMake(0, 60));
            make.width.equalTo(@200);
            make.height.equalTo(@30);
        }];
    }
   return _loginTextField;
}

- (UITextField *)passwordTextField
{
    if (!_passwordTextField)
    {
        _passwordTextField = [UITextField new];
        _passwordTextField.delegate = self;
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.layer.cornerRadius = 5.f;
        _passwordTextField.textAlignment = NSTextAlignmentCenter;
        _passwordTextField.backgroundColor = UIColorFromRGBWithAlpha(0xAAAAAA, 0.3f);
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Password", nil) attributes:@{NSForegroundColorAttributeName: [[UIColor whiteColor] colorWithAlphaComponent:0.5]}];
        _passwordTextField.font = [UIFont systemFontOfSize:12.f];
        [_placeholderViewInScrollView addSubview:_passwordTextField];
        
        [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_loginTextField).centerOffset(CGPointMake(0, 40));
            make.width.equalTo(@200);
            make.height.equalTo(@30);
        }];
    }
    return _passwordTextField;
}

- (UIButton*)loginButton
{
    if (!_loginButton)
    {
        _loginButton = [UIButton new];
        [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
        _loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        _loginButton.layer.borderWidth = 1.f;
        _loginButton.layer.borderColor = [UIColor grayColor].CGColor;
        _loginButton.backgroundColor = [UIColor clearColor];
        _loginButton.layer.cornerRadius = 5.f;
        [_loginButton setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
        [_placeholderViewInScrollView addSubview:_loginButton];
        
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_loginTextField).centerOffset(CGPointMake(0, 80));
            make.width.equalTo(@200);
            make.height.equalTo(@30);
        }];
    }
    return _loginButton;
}

#pragma mark - Keyboard

- (void)setupKeyboard
{
    
    if (!_textFields)
    {
        _textFields = @[_loginTextField, _passwordTextField];
    }
    
    if (!_keyboardInputView)
    {
        _keyboardInputView = [[LVGKeyboardInputView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    }
    
    [_keyboardInputView.inputItems setArray: self.textFields];
    _keyboardInputView.scrollView = _scrollView;
    _keyboardInputView.toolbar.tintColor = [UIColor grayColor];
    
    for(UITextField *tf in self.textFields)
        tf.inputAccessoryView = self.keyboardInputView;
    
    __weak __typeof(self) weakSelf = self;
    _keyboardInputView.doneActionBlock = ^{
        [weakSelf endEditing];
    };
    
    _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, CGRectGetMaxY(_loginButton.frame));
    _keyboardInputView.scrollViewOriginContentHeight = _scrollView.contentSize.height;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _scrollView.scrollEnabled = YES;
    _keyboardInputView.activeInputView = textField;
    [_keyboardInputView updateKeyboardInputBtns];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_keyboardInputView updateOffset];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self endEditing];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    NSUInteger index = [self.keyboardInputView.inputItems indexOfObject:textField] + 1;
    
    if(index < self.keyboardInputView.inputItems.count)
    {
        [self.keyboardInputView.inputItems[index] becomeFirstResponder];
        [self.keyboardInputView updateOffset];
    }
    else
    {
        [self endEditing];
    }
    
    return NO;
}

- (void) endEditing {
    
    [self.keyboardInputView endEditing];
}

@end