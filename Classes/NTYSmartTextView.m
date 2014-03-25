//
//  NTYSmartTextView.m
//  Pods
//
//  Created by naoty on 2014/03/25.
//
//

#import "NTYSmartTextView.h"

@interface NTYSmartTextView ()
@property (nonatomic, readonly) NSString *currentLine;
@end

@implementation NTYSmartTextView

NSString * const kIndentPatternString = @"^(\\t|\\s)+";

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
}

- (void)insertNewline:(id)sender
{
    NSString *currentLine = self.currentLine;
    
    [super insertNewline:sender];
    
    if (self.smartIndentEnabled) {
        NSRegularExpression *pattern = [[NSRegularExpression alloc] initWithPattern:kIndentPatternString options:0 error:nil];
        NSTextCheckingResult *matched = [pattern firstMatchInString:currentLine options:0 range:NSMakeRange(0, currentLine.length)];
        if (matched) {
            NSString *indent = [currentLine substringWithRange:matched.range];
            [self insertText:indent];
        }
    }
}

#pragma mark - Private methods

- (void)setup
{
    self.smartIndentEnabled = YES;
}

- (NSString *)currentLine
{
    NSRange currentLineRange = [self.string lineRangeForRange:self.selectedRange];
    return [self.string substringWithRange:currentLineRange];
}

@end
