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
@property (nonatomic) NSArray *pairCharacters;
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

- (void)insertTab:(id)sender
{
    if (self.softTabEnabled) {
        NSMutableString *softTab = [NSMutableString new];
        for (NSInteger i = 0; i < self.tabWidth; i++) {
            [softTab appendString:@" "];
        }
        [self insertText:softTab];
    } else {
        [super insertTab:sender];
    }
}

- (void)insertText:(id)aString
{
    [super insertText:aString];
    
    if (!self.autoPairCompletionEnabled) {
        return;
    }
    
    NSString *string = (NSString *)aString;
    
    if ([string isEqualToString:@"("]) {
        [super insertText:@")"];
        [super moveBackward:self];
    }
    
    if ([string isEqualToString:@"["]) {
        [super insertText:@"]"];
        [super moveBackward:self];
    }
    
    if ([string isEqualToString:@"{"]) {
        [super insertText:@"}"];
        [super moveBackward:self];
    }
    
    if ([string isEqualToString:@"\""]) {
        [super insertText:@"\""];
        [super moveBackward:self];
    }
    
    if ([string isEqualToString:@"'"]) {
        [super insertText:@"'"];
        [super moveBackward:self];
    }
    
    if ([string isEqualToString:@"`"]) {
        [super insertText:@"`"];
        [super moveBackward:self];
    }
}

- (void)deleteBackward:(id)sender
{
    if (!self.autoPairCompletionEnabled) {
        [super deleteBackward:sender];
        return;
    }
    
    if ([self isStartOrEndOfLine]) {
        [super deleteBackward:sender];
        return;
    }
    
    NSRange surroundRange = NSMakeRange(self.selectedRange.location - 1, 2);
    NSString *surroundString = [self.string substringWithRange:surroundRange];
    
    if ([self.pairCharacters indexOfObject:surroundString] != NSNotFound) {
        [super deleteForward:sender];
        [super deleteBackward:sender];
    } else {
        [super deleteBackward:sender];
    }
}

#pragma mark - Private methods

- (void)setup
{
    self.smartIndentEnabled = YES;
    self.softTabEnabled = YES;
    self.tabWidth = 4;
    self.autoPairCompletionEnabled = YES;
    
    // Disable to enable auto quotes pair completion.
    self.automaticQuoteSubstitutionEnabled = !self.autoPairCompletionEnabled;
    
    self.pairCharacters = @[@"()", @"[]", @"{}", @"\"\"", @"''", @"``"];
}

- (NSString *)currentLine
{
    NSRange currentLineRange = [self.string lineRangeForRange:self.selectedRange];
    return [self.string substringWithRange:currentLineRange];
}

- (BOOL)isEndOfLine
{
    NSUInteger lineEnd;
    [self.string getLineStart:nil end:&lineEnd contentsEnd:nil forRange:self.selectedRange];
    return self.selectedRange.location == lineEnd;
}

- (BOOL)isStartOrEndOfLine
{
    NSUInteger lineStart, lineEnd;
    [self.string getLineStart:&lineStart end:&lineEnd contentsEnd:nil forRange:self.selectedRange];
    return self.selectedRange.location == lineStart || self.selectedRange.location == lineEnd;
}

@end
