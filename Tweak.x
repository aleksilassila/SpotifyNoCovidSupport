#import "Tweak.h"

%hook HUBCollectionViewDataSource
- (void)setComponentModels:(NSArray *)arg1 {
    if ([arg1 count] != 0)
    {
        bool isArtistPageDataSource = false;

        for (HUBComponentModelImplementation *component in arg1) {
            if ([component.identifier isEqualToString:@"artist-entity-view-top-tracks-combined"]) {
                isArtistPageDataSource = true;
                break;
            }
        }

        if (isArtistPageDataSource) {
            NSMutableArray *newArray = [arg1 mutableCopy];

            NSMutableIndexSet *indexes = [NSMutableIndexSet indexSet];

            for (int i = 0; i < [arg1 count]; i++) {
                HUBComponentModelImplementation *component = arg1[i];
                if ([component.identifier isEqualToString:@"fan_funding_header"] || [component.identifier isEqualToString:@"fan_funding_row"]) {
                    [indexes addIndex:i];
                }
            }

            if ([indexes count]) {
                [newArray removeObjectsAtIndexes:indexes];
            }

            %orig(newArray);
            return;
        }

    }
    %orig;

}
%end
