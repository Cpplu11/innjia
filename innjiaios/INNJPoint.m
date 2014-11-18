//
//  INNJPoint.m
//  innjiaios
//
//  Created by wl on 14-11-15.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJPoint.h"

@implementation INNJPoint

-(void) setCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    _coordinate = newCoordinate;
}

@end

@implementation INNJPointView

-(id) initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        self.frame = CGRectMake(self.top, self.left, 40, 40);
        UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"point"]];
        [self addSubview:imageview];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        _label.adjustsFontSizeToFitWidth = YES;
        _label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_label];
    }
    
    return self;
}

@end