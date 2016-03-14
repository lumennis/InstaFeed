//
//  KeyboardInputView.m
//


#import "LVGKeyboardInputView.h"
#import "Macros.h"

@interface LVGKeyboardInputView ()

@property (strong, nonatomic) UIBarButtonItem *prevKeyboardItem;
@property (strong, nonatomic) UIBarButtonItem *nextKeyboardItem;
@property (strong, nonatomic) UIBarButtonItem *doneKeyboardItem;

@end

@implementation LVGKeyboardInputView {
    
    CGFloat _kbOriginY;
    CGFloat contentSizeIncreaserY;
}

- (id)initWithFrame:(CGRect)frame {
    
    if(self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void) loadUI {
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.prevKeyboardItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"IQButtonBarArrowLeft"]  style:UIBarButtonItemStylePlain target:self action:@selector(prevKeyboardBtn)];
    self.nextKeyboardItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"IQButtonBarArrowRight"] style:UIBarButtonItemStylePlain target:self action:@selector(nextKeyboardBtn)];
    self.doneKeyboardItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", nil) style:UIBarButtonItemStyleDone target:self action:@selector(doneKeyboardBtn)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [fixedSpace setWidth:20];
    //LVGLocalizedString(@"Done", nil)
    [self.toolbar setItems:@[self.prevKeyboardItem, fixedSpace, self.nextKeyboardItem, flexSpace, self.doneKeyboardItem]];
    [self addSubview:self.toolbar];
    
    self.inputItems = [[NSMutableArray alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - Keyboard Input Accessory

- (void)updateKeyboardInputBtns {
    
    NSUInteger index = [self.inputItems indexOfObject:_activeInputView];
    self.prevKeyboardItem.enabled = index != 0;
    self.nextKeyboardItem.enabled = index != (self.inputItems.count - 1);
}

- (void)prevKeyboardBtn {
    
    NSUInteger index = [self.inputItems indexOfObject:_activeInputView];
    long int newIndex = index - 1;
    if(newIndex >= 0)
        [self.inputItems[newIndex] becomeFirstResponder];
    
    [self updateKeyboardInputBtns];
}

- (void)nextKeyboardBtn {
    
    NSUInteger newIndex = [self.inputItems indexOfObject:_activeInputView] + 1;
    if(newIndex < self.inputItems.count)
        [self.inputItems[newIndex] becomeFirstResponder];
    
    [self updateKeyboardInputBtns];
}

- (void)doneKeyboardBtn {
    
    [self endEditing];
    
    if(self.doneActionBlock)
        self.doneActionBlock();
}

- (void) endEditing {
    
    [self.activeInputView resignFirstResponder];
}


#pragma mark Keyboard

- (void) updateOffset {
    
    if(_kbOriginY == 0)
        return;
    
    CGRect convertedRect = [self.activeInputView.superview convertRect:self.activeInputView.frame toView:self.scrollView];
    convertedRect.origin.y -= self.scrollView.contentOffset.y;
    
    CGFloat itemHeightToBeVisisble = [self.activeInputView isKindOfClass:[UITextView class]] ? 50 : convertedRect.size.height;
    if(CGRectGetMinY(convertedRect) + itemHeightToBeVisisble > _kbOriginY) {
        
        CGFloat _yShift = convertedRect.origin.y - (_kbOriginY - itemHeightToBeVisisble) + self.scrollView.contentOffset.y;
        [self.scrollView setContentOffset: CGPointMake(0, _yShift) animated:YES];
    }
    
    CGFloat increase = self.scrollView.frame.size.height - _kbOriginY;
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, self.scrollViewOriginContentHeight + increase)];
}

- (void) keyboardWillShow:(NSNotification *) notification {

    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGFloat kbHeight = kbSize.height;
    if(SYSTEM_VERSION_LESS_THAN(@"8.0") && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
        kbHeight = kbSize.width;
    
    _kbOriginY = self.scrollView.bounds.size.height - kbHeight;
    
    CGFloat _yShift = 0;
    contentSizeIncreaserY = _yShift + (self.scrollView.contentSize.height - self.activeInputView.frame.origin.y - ([self.activeInputView isKindOfClass:[UITextView class]] ? 50 : self.activeInputView.frame.size.height));
    
    [self updateOffset];
}

- (void) keyboardWillHide:(NSNotification *) notification {
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.scrollView setContentOffset: CGPointMake(0, 0) animated:NO];//point was 0,0 or -64
    } completion:^(BOOL finished) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollViewOriginContentHeight);
    }];
}


@end
