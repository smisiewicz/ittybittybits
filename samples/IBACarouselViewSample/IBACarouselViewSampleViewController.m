//
//  IBACarouselViewSampleViewController.m
//  IBACarouselViewSample
//
//  Created by Oliver Jones on 1/09/11.
//  Copyright 2011 Deeper Design. All rights reserved.
//

#import "IBACarouselViewSampleViewController.h"
#import "IBACarouselView.h"

// Easing code generated by: http://www.timotheegroleau.com/Flash/experiments/easing_function_generator.htm
static CGFloat MyCustomEasingFunction(NSTimeInterval t, CGFloat b, CGFloat c, NSTimeInterval d)
{
    CGFloat ts = (CGFloat)((t /= d) * t);
    CGFloat tc = ts * (CGFloat)t;
    return b + c * (4 * tc + -9 * ts + 6 * (CGFloat)t);
}

@implementation IBACarouselViewSampleViewController
{
    NSCache *imageCache;
    UIImageView *imageView1;
    UIImageView *imageView2;
}

IBA_SYNTHESIZE(carousel1, carousel2);

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        imageCache = [[NSCache alloc] init];
        imageView1 = [[UIImageView alloc] init];
        imageView2 = [[UIImageView alloc] init];
    }
    
    return self;
}

- (void)dealloc
{
    IBA_RELEASE_PROPERTY(carousel1);
    IBA_RELEASE_PROPERTY(carousel2);
    
    IBA_RELEASE(imageCache);
    IBA_RELEASE(imageView1);
    IBA_RELEASE(imageView2);
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.carousel1.easingFunction = &MyCustomEasingFunction;
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    IBA_RELEASE_PROPERTY(carousel1);
    IBA_RELEASE_PROPERTY(carousel2);

    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)numberOfItemsInCarouselView:(IBACarouselView *)carouselView
{
#pragma unused(carouselView)
    return 72u;
}

/*!
 \brief     Asks the data source for a view to display for the the specified item \a index.
 \param     carouselView    The carousel-view object requesting the view.
 \param     index           The index of the item to get the view for.
 \return    An object inheriting from UIView that the Carousel view can use for the specified index. An assertion is raised if you return nil.
 */
- (UIView *)carouselView:(IBACarouselView *)carouselView viewForItemAtIndex:(NSUInteger)index
{
    UIImageView *imageView = carouselView.tag == 1 ? imageView1 : imageView2;

    NSNumber *key = IBAIntToNumber((NSInteger)index);
    UIImage *image = [imageCache objectForKey:key];
    if (image == nil)
    { 
        NSString *filename = [NSString stringWithFormat:@"Seq_v04_640x378_%02d", index + 1];
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"jpg"];
        IBAAssertNotNil(path);
        
        NSData *data = [NSData dataWithContentsOfMappedFile:path];
        IBAAssertNotNil(data);
        
        image = [UIImage imageWithData:data];
        IBAAssertNotNil(image);
        
        [imageCache setObject:image forKey:key];
    }
    
    imageView.image = image;
    return imageView;
}

@end
