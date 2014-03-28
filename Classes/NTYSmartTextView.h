//
//  NTYSmartTextView.h
//  Pods
//
//  Created by naoty on 2014/03/25.
//
//

#import <Cocoa/Cocoa.h>

@interface NTYSmartTextView : NSTextView

// Smart Indent
@property (nonatomic) BOOL smartIndentEnabled;

// Soft Tab
@property (nonatomic) BOOL softTabEnabled;
@property (nonatomic) NSUInteger tabWidth;

// Auto Pair Completion
@property (nonatomic) BOOL autoPairCompletionEnabled;

@end
