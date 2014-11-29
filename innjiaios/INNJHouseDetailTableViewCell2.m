//
//  INNJHouseDetailTableViewCell2.m
//  innjiaios
//
//  Created by wl on 14-11-28.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJHouseDetailTableViewCell2.h"
#import "DataManage.h"
#import "Favourites.h"
@implementation INNJHouseDetailTableViewCell2

-(void) awakeFromNib
{
    
    _favbtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_villagetext.frame)+10, CGRectGetMidY(_villagetext.frame)-10, 21, 21)];
    [_favbtn setImage:[UIImage imageNamed:@"favourites-off"] forState:UIControlStateNormal];
    [_favbtn setImage:[UIImage imageNamed:@"favourites-on"] forState:UIControlStateSelected];
    [_favbtn setImage:[UIImage imageNamed:@"favourites-on"] forState:UIControlStateHighlighted];
    [_favbtn setImage:[UIImage imageNamed:@"favourites-on"] forState:UIControlStateSelected];
    [self addSubview:_favbtn];
    [_favbtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}
-(void) bindData:(NSDictionary *)data
{
    self.data = data;
    _villagetext.text = [NSString stringWithFormat:@"%@   %@号楼   %@",data[@"village"],data[@"buildingno"],data[@"lease"]];
    _addresstext.text = [NSString stringWithFormat:@"%@ %@",data[@"city"],data[@"district"]];
    _infotext.text = [NSString stringWithFormat:@"%@ %@ %@",data[@"business"],data[@"floor "],data[@"paytype"]];
    [self isfav];
    [_favbtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) isfav
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:[DataManage instance].managedObjectContext];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"aid=%@", _data[@"id"]];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSError *error = nil;
    NSArray *fetchedObjects = [[DataManage instance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if(fetchedObjects!=nil && [fetchedObjects count]>0)
    {
        _favbtn.selected = YES;
    }
}

-(void) action:(id)sender
{
    _favbtn.selected = !_favbtn.selected;
    if(_favbtn.selected)
    {
        Favourites * fav = [NSEntityDescription insertNewObjectForEntityForName:@"Favourites" inManagedObjectContext:[DataManage instance].managedObjectContext];
        fav.aid = _data[@"id"];
        fav.subject = _data[@"subject"];
        fav.date = [NSDate date];
        fav.image = _data[@"img"];
        fav.price = _data[@"rent"];
        fav.village = _data[@"village"];
        [[DataManage instance] saveContext];
        
    }else
    {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:[DataManage instance].managedObjectContext];
        [fetchRequest setEntity:entity];
        // Specify criteria for filtering which objects to fetch
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"aid=%@", _data[@"id"]];
        [fetchRequest setPredicate:predicate];
        // Specify how the fetched objects should be sorted
        NSError *error = nil;
        NSArray *fetchedObjects = [[DataManage instance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects != nil) {
            for(Favourites* fav in fetchedObjects)
            {
                [[DataManage instance].managedObjectContext deleteObject:fav];
            }
            
            [[DataManage instance] saveContext];
        }
    }
    
}



@end
