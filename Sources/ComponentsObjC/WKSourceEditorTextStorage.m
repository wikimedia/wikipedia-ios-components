//
//  WKSourceEditorTextStorage.m
//  
//
//  Created by Toni Sevener on 4/5/23.
//

#import "WKSourceEditorTextStorage.h"
#import "WKSourceEditorFormatter.h"
#import "WKSourceEditorFormatterDefault.h"

@interface WKSourceEditorTextStorage ()

@property (nonatomic, strong) NSMutableAttributedString *backingStore;
@property (nonatomic, copy) NSMutableArray *formatters;
@property (nonatomic, assign) BOOL needsSyntaxHighlightRegexCalculation;

@end

@implementation WKSourceEditorTextStorage

- (instancetype)init {
    if (self = [super init]) {
        _backingStore = [[NSMutableAttributedString alloc] init];
        _formatters = [NSMutableArray array];
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

// MARK: Public

- (void)updateColors:(WKSourceEditorTextStorageColors *)colors {
    self.needsSyntaxHighlightRegexCalculation = NO;
    [self beginEditing];
    NSRange allRange = NSMakeRange(0, self.backingStore.length);
    
    for (WKSourceEditorFormatter *formatter in self.formatters) {
        [formatter updateColors:colors inString:self inRange:allRange];
    }
    
    [self endEditing];
    self.needsSyntaxHighlightRegexCalculation = YES;
}

- (void)updateFonts:(WKSourceEditorTextStorageFonts *)fonts {
    self.needsSyntaxHighlightRegexCalculation = NO;
    [self beginEditing];
    NSRange allRange = NSMakeRange(0, self.backingStore.length);
    
    for (WKSourceEditorFormatter *formatter in self.formatters) {
        [formatter updateFonts:fonts inString:self inRange:allRange];
    }
    
    [self endEditing];
    self.needsSyntaxHighlightRegexCalculation = YES;
}

- (void)addFormatter:(WKSourceEditorFormatter *)formatter {
    [self.formatters addObject:formatter];
}

// MARK: - Batch change methods
// Use for performant mass attribute changes

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

// MARK: - Private Helpers

- (void)applySyntaxHighlightRegexToRange:(NSRange)changedRange {
    NSRange extendedRange = NSUnionRange(changedRange, [self.backingStore.string lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [self.backingStore.string lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    [self applySyntaxHighlightRegexToExtendedRange:extendedRange];
}

- (void)applySyntaxHighlightRegexToExtendedRange:(NSRange)extendedRange {
    for (WKSourceEditorFormatter *formatter in self.formatters) {
        [formatter applySyntaxHighlightRegexInString:self toRange:extendedRange];
    }
}



@end
