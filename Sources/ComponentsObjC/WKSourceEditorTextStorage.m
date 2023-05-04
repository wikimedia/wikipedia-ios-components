//
//  WKSourceEditorTextStorage.m
//  
//
//  Created by Toni Sevener on 4/5/23.
//

#import "WKSourceEditorTextStorage.h"
#import "WKSourceEditorFormatter.h"
#import "WKSourceEditorFormatterDefault.h"
#import "WKSourceEditorFormatterBoldItalics.h"

@interface WKSourceEditorTextStorage ()

@property (nonatomic, strong) NSMutableAttributedString *backingStore;
@property (nonatomic, assign) BOOL needsSyntaxHighlightRegexCalculation;

@property (nonatomic, strong) WKSourceEditorFormatterDefault *defaultFormatter;
@property (nonatomic, strong, readwrite) WKSourceEditorFormatterBoldItalics *boldItalicsFormatter;

@end

@implementation WKSourceEditorTextStorage

- (nonnull instancetype)initWithColors:(nonnull WKSourceEditorTextStorageColors *)colors fonts:(nonnull WKSourceEditorTextStorageFonts *)fonts {
    if (self = [super init]) {
        _backingStore = [[NSMutableAttributedString alloc] init];
        _defaultFormatter = [[WKSourceEditorFormatterDefault alloc] initWithColors:colors fonts:fonts];
        _boldItalicsFormatter = [[WKSourceEditorFormatterBoldItalics alloc] initWithColors:colors fonts:fonts];
        _needsSyntaxHighlightRegexCalculation = YES;
    }
    return self;
}

// MARK: - Overrides

- (NSString *)string {
    return self.backingStore.string;
}

- (NSDictionary<NSAttributedStringKey, id> *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
    return [self.backingStore attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
    [self beginEditing];
    [self.backingStore replaceCharactersInRange:range withString:str];
    [self edited:NSTextStorageEditedCharacters range:range changeInLength:str.length - range.length];
    [self endEditing];
}

- (void)setAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs range:(NSRange)range {
    [self beginEditing];
    [self.backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

- (void)processEditing {
    if (self.needsSyntaxHighlightRegexCalculation) {
        [self applySyntaxHighlightRegexToRange:self.editedRange];
    }
    
    [super processEditing];
}

// MARK: - Batch change methods
// Use for performant mass attribute changes (will be used for find and replace).

- (void)removeAttribute:(NSAttributedStringKey)name rangeValues:(NSArray<NSValue *> *)rangeValues {
    [self beginEditing];
    for (NSValue *rangeValue in rangeValues) {
        [self.backingStore removeAttribute:name range:rangeValue.rangeValue];
        [self edited:NSTextStorageEditedAttributes range:rangeValue.rangeValue changeInLength:0];
    }
    
    [self endEditing];
}

- (void)addAttributes:(NSDictionary<NSAttributedStringKey, id> *)attrs rangeValues:(NSArray<NSValue *> *)rangeValues {
    [self beginEditing];
    for (NSValue *rangeValue in rangeValues) {
        [self.backingStore addAttributes:attrs range:rangeValue.rangeValue];
        [self edited:NSTextStorageEditedAttributes range:rangeValue.rangeValue changeInLength:0];
    }
    
    [self endEditing];
}

// MARK: Public

- (void)updateColors:(WKSourceEditorTextStorageColors *)colors andFonts:(WKSourceEditorTextStorageFonts *)fonts {
    self.needsSyntaxHighlightRegexCalculation = NO;
    [self beginEditing];
    NSRange allRange = NSMakeRange(0, self.backingStore.length);
    for (WKSourceEditorFormatter *formatter in [self formatters]) {
        [formatter updateColors:colors inAttributedString:self inRange:allRange];
        [formatter updateFonts:fonts inAttributedString:self inRange:allRange];
    }
    
    [self endEditing];
    self.needsSyntaxHighlightRegexCalculation = YES;
}

- (BOOL)isBoldInRange:(NSRange)range {
    return [self.boldItalicsFormatter attributedString:self isBoldInRange:range];
}

- (BOOL)isItalicsInRange:(NSRange)range {
    return [self.boldItalicsFormatter attributedString:self isItalicsInRange:range];
}

// MARK: - Private Helpers

- (NSArray<WKSourceEditorFormatter *> *)formatters {
    return @[self.defaultFormatter, self.boldItalicsFormatter];
}

- (void)applySyntaxHighlightRegexToRange:(NSRange)changedRange {
    NSRange extendedRange = NSUnionRange(changedRange, [self.backingStore.string lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [self.backingStore.string lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    [self applySyntaxHighlightRegexToExtendedRange:extendedRange];
}

- (void)applySyntaxHighlightRegexToExtendedRange:(NSRange)extendedRange {
    
    // reset
    [self removeAttribute:NSFontAttributeName range:extendedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:extendedRange];
    [self removeAttribute:NSForegroundColorAttributeName range:extendedRange];
    
    for (WKSourceEditorFormatter *formatter in self.formatters) {
        [formatter applySyntaxHighlightRegexInAttributedString:self toRange:extendedRange];
    }
}



@end
