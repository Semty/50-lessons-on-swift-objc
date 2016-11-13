//
//  FootballClub.swift
//  HW31-32
//
//  Created by Руслан on 13.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

enum Action {
    
    case addingNewClub
    case deleteLeague
    
}

class FootballClub: NSObject {
    
// MARK: - Static private Variables
    
    static private let namesOfCloubs = ["Wolverhampton Wanderers FC", "Wimbledon", "Wigan Athletic FC",
                         "West Ham United", "West Bromwich Albion","Watford", "Wanderers FC",
                         "Tranmere Rovers", "Tottenham Hotspur", "Swindon Town", "Sunderland",
                         "Stoke City FC", "Southampton", "Sheffield Wednesday", "Sheffield United",
                         "Royal Engineers AFC", "Rotherham United", "Rochdale AFC",
                         "Reading FC", "Queens Park Rangers", "Preston North End",
                         "Portsmouth FC", "Oxford University", "Oxford United",
                         "Oldham Athletic", "Old Etonians", "Old Carthusians FC", "Notts County",
                         "Nottingham Forest", "Norwich City", "Newcastle United", "Millwall FC",
                         "Middlesbrough", "Manchester United", "Manchester City FC", "Luton Town",
                         "London XI", "Liverpool FC", "Leicester City", "Leeds United", "Ipswich Town",
                         "Hull City AFC", "Huddersfield Town", "Fulham FC", "Everton", "Derby County",
                         "Crystal Palace", "Coventry City", "Clapham Rovers", "Chelsea FC",
                         "Charlton Athletic", "Carlisle United", "Bury FC", "Burnley FC", "Bristol City",
                         "Brighton and Hove Albion", "Bradford City", "Bolton Wanderers FC", "Blackpool",
                         "Blackburn Rovers", "Blackburn Olympic FC", "Birmingham City",
                         "Barnsley", "Aston Villa", "Arsenal London"]
    
    static private let namesOfLeagues = ["Premier League", "Football League Championship",
                          "Football League One", "Football League Two", "National League",
                          "National League North", "National League South"]
    
    static private let namesOfCloubsCount = (UInt32)(FootballClub.namesOfCloubs.count)
    static private let namesOfLeaguesCount = (UInt32)(FootballClub.namesOfLeagues.count)
    
// MARK: - Public Variables
    
    var name = ""
    var league = ""
    var points = 0
    
// MARK: - Class functions
    
    static func randomFootballClub() -> FootballClub {
        
        let club = FootballClub()
        
        club.name = FootballClub.namesOfCloubs[ (Int)(arc4random() % FootballClub.namesOfCloubsCount) ]
        club.points = (Int)(arc4random() % (UInt32)(115))
        
        return club
    }
    
    static func randomFootballLeague() -> [FootballClub] {
        
        var footballLeague = [FootballClub]()
        let leagueName = FootballClub.namesOfLeagues[ (Int)(arc4random() % FootballClub.namesOfLeaguesCount) ]
        
        let firstCellClub = FootballClub.makeDefaultClub(with: .addingNewClub)
        firstCellClub.league = leagueName
        footballLeague.append(firstCellClub)
        
        while footballLeague.count < 21 {
            
            let randomClub = FootballClub.randomFootballClub()
            randomClub.league = leagueName
            
            if !FootballClub.namesIsEqualBetweenClub(randomClub, and: footballLeague) {
                footballLeague.append(randomClub)
            }
        }
        
        let lastCellClub = FootballClub.makeDefaultClub(with: .deleteLeague)
        lastCellClub.league = leagueName
        footballLeague.append(lastCellClub)
        
        return footballLeague
    }
    
    static func makeEmptyLeague() -> [FootballClub] {
        
        var footballLeague = [FootballClub]()
        let leagueName = FootballClub.namesOfLeagues[ (Int)(arc4random() % FootballClub.namesOfLeaguesCount) ]
        
        let firstCellClub = FootballClub.makeDefaultClub(with: .addingNewClub)
        firstCellClub.league = leagueName
        footballLeague.append(firstCellClub)
        
        let lastCellClub = FootballClub.makeDefaultClub(with: .deleteLeague)
        lastCellClub.league = leagueName
        footballLeague.append(lastCellClub)
        
        return footballLeague
    }
    
    static func makeDefaultClub(with action: Action) -> FootballClub {
        
        let firstCellClub = FootballClub()
        firstCellClub.name = "Default"
        
        switch action {
        case .addingNewClub:
            firstCellClub.points = 116
        case .deleteLeague:
            firstCellClub.points = -1
        }
        return firstCellClub
    }
    
    static private func namesIsEqualBetweenClub(_ club: FootballClub, and league: [FootballClub]) -> Bool {
        
        for anotherClub in league {
            
            if club.name == anotherClub.name {
                return true
            }
            
        }
        return false
    }

}









