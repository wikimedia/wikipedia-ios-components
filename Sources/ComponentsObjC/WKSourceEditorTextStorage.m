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

@end

@implementation WKSourceEditorTextStorage

- (instancetype)init {
    if (self = [super init]) {
        _backingStore = [[NSMutableAttributedString alloc] init];
        _formatters = [NSMutableArray array];
    }
    return self;
}

// MARK: - Standard Implementations

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

// MARK: - Custom Implementations

- (void)processEditing {
    [self applySyntaxHighlightingToRange:self.editedRange];
    [super processEditing];
}

- (void)applySyntaxHighlightingToRange:(NSRange)changedRange {
    NSRange extendedRange = NSUnionRange(changedRange, [self.backingStore.string lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    extendedRange = NSUnionRange(changedRange, [self.backingStore.string lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    [self applyStylesToExtendedRange:extendedRange];
}

- (void)applyStylesToExtendedRange:(NSRange)extendedRange {
    for (WKSourceEditorFormatter *formatter in self.formatters) {
        [formatter applySyntaxHighlightingInString:self toRange:extendedRange];
    }
}

- (void)addFormatter:(WKSourceEditorFormatter *)formatter {
    [_formatters addObject:formatter];
}

@end
