
#import "MainView.h"
#import "global.h"

@implementation MainView

- (id) initWithFrame:(CGRect)frame {
	int i;
	self = [super initWithFrame:frame];

	ary_ = [[NSMutableArray array] retain];
	for( i = 0; i < 20; i++ ) {
		NSString *str = [NSString stringWithFormat:@"%d", i];
		[ary_ addObject:str];
	}
	
 	CGRect rect = [UIHardware fullScreenApplicationContentRect];
    rect.origin.x = rect.origin.y = 0.0f;
	
	id refreshPicker = [[UIPickerView alloc] initWithFrame: CGRectMake(0.0f, rect.size.height - 300.0f, 320.0f, 100.0f)];
	[refreshPicker setDelegate: self];
	[refreshPicker setSoundsEnabled: NO];
	
	UIPickerTable *table = [refreshPicker createTableWithFrame: CGRectMake(100.0f, 0.0f, 100.0f, 100.0f)];
	[table setAllowsMultipleSelection: NO];

	UITableColumn *pickerCol = [[UITableColumn alloc] initWithTitle: @"Refresh" identifier:@"refresh" width: rect.size.width];
	[refreshPicker columnForTable: pickerCol];
	
	[self addSubview:refreshPicker];
	
	[table reloadData];
	
	return self;
}

- (BOOL) table:(UIPickerTable*)table canSelectRow:(int)row {
	return YES;
}

- (int) numberOfColumnsInPickerView:(UIPickerView*)picker {
     return 1;
}

- (int) pickerView:(UIPickerView*)picker numberOfRowsInColumn:(int)column {
	return [ary_ count];
}

- (UIPickerTableCell*) pickerView:(UIPickerView*)picker tableCellForRow:(int)row inColumn:(int)column {
	UIPickerTableCell *cell = [[UIPickerTableCell alloc] initWithFrame: CGRectMake(0.0f, 0.0f, 100.0f, 32.0f)];
	[cell setTitle:[ary_ objectAtIndex:row]];
	return cell;
}


@end
