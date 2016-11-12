//
//  RTFootballClub.m
//  HW31-32
//
//  Created by Руслан on 12.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTFootballClub.h"

@implementation RTFootballClub

static NSString *namesOfCloubs[] = {
    
    @"Wolverhampton Wanderers FC", @"Wimbledon", @"Wigan Athletic FC", @"West Ham United", @"West Bromwich Albion",
    @"Watford", @"Wanderers FC", @"Tranmere Rovers", @"Tottenham Hotspur", @"Swindon Town", @"Sunderland", @"Stoke City FC",
    @"Southampton", @"Sheffield Wednesday", @"Sheffield United", @"Royal Engineers AFC", @"Rotherham United", @"Rochdale AFC",
    @"Reading FC", @"Queens Park Rangers", @"Preston North End", @"Portsmouth FC", @"Oxford University", @"Oxford United",
    @"Oldham Athletic", @"Old Etonians", @"Old Carthusians FC", @"Notts County", @"Nottingham Forest", @"Norwich City",
    @"Newcastle United", @"Millwall FC", @"Middlesbrough", @"Manchester United", @"Manchester City FC", @"Luton Town",
    @"London XI", @"Liverpool FC", @"Leicester City", @"Leeds United", @"Ipswich Town", @"Hull City AFC", @"Huddersfield Town",
    @"Fulham FC", @"Everton", @"Derby County", @"Crystal Palace", @"Coventry City", @"Clapham Rovers", @"Chelsea FC",
    @"Charlton Athletic", @"Carlisle United", @"Bury FC", @"Burnley FC", @"Bristol City", @"Brighton and Hove Albion",
    @"Bradford City", @"Bolton Wanderers FC", @"Blackpool", @"Blackburn Rovers", @"Blackburn Olympic FC", @"Birmingham City",
    @"Barnsley", @"Aston Villa", @"Arsenal London"
    
};

static NSString *namesOfLeagues[] = {
  
    @"Premier League", @"Football League Championship", @"Football League One",
    @"Football League Two", @"National League",
    @"National League North", @"National League South"
    
};

static NSInteger namesOfCloubsCount = 65;
static NSInteger namesOfLeaguesCount = 7;

+ (RTFootballClub *) randomFootballClub {
    
    RTFootballClub *club = [[RTFootballClub alloc] init];
    
    club.name = namesOfCloubs   [   arc4random() % namesOfCloubsCount     ];
    club.points = arc4random() % 115000 / 1000;
    
    return club;
}

+ (NSArray *) randomFootballLeague {
    
    NSMutableArray *footballLeague = [[NSMutableArray alloc] init];
    NSString *leagueName = namesOfLeagues[ arc4random() %  namesOfLeaguesCount];
    
    RTFootballClub *defaultClub = [RTFootballClub makeDefaultClubWithAction:AddingNewClub];
    defaultClub.league = leagueName;
    [footballLeague addObject:defaultClub];
    
    while ([footballLeague count] < 21) {
        RTFootballClub *randomClub = [RTFootballClub randomFootballClub];
        randomClub.league = leagueName;
        
        if (![RTFootballClub namesIsEqualClub:randomClub andLeague:footballLeague]) {
            [footballLeague addObject:randomClub];
        }
    }
    
    RTFootballClub *anotherDefaultClub = [RTFootballClub makeDefaultClubWithAction:DeleteLeague];
    anotherDefaultClub.league = leagueName;
    [footballLeague addObject:anotherDefaultClub];
    
    return footballLeague;
}

+ (NSArray *) makeEmptyLeague {
    
    NSMutableArray *footballLeague = [[NSMutableArray alloc] init];
    RTFootballClub *defaultClub = [RTFootballClub makeDefaultClubWithAction:AddingNewClub];
    
    NSString *leagueName = namesOfLeagues[ arc4random() %  namesOfLeaguesCount];
    defaultClub.league = leagueName;
    [footballLeague addObject:defaultClub];
    
    RTFootballClub *anotherDefaultClub = [RTFootballClub makeDefaultClubWithAction:DeleteLeague];
    anotherDefaultClub.league = leagueName;
    [footballLeague addObject:anotherDefaultClub];
    
    return footballLeague;
}

+ (RTFootballClub *) makeDefaultClubWithAction:(RTAction)action {
    
    RTFootballClub *defaultClub = [[RTFootballClub alloc] init];
    defaultClub.name = @"Default";
    switch (action) {
        case AddingNewClub:
            defaultClub.points = 116; // max points + 1
            break;
        case DeleteLeague:
            defaultClub.points = -1; // min points - 1
            break;
    }
    
    return defaultClub;
}

+ (BOOL) namesIsEqualClub:(RTFootballClub *)club andLeague:(NSMutableArray *)league  {
    
    for (RTFootballClub *anotherClub in league) {
        
        if ([anotherClub.name isEqualToString:club.name]) {
            return YES;
        }
        
    }
    
    return NO;
}

@end
