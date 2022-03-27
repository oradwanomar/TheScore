//
//  Leagues.swift
//  TheScore
//
//  Created by Omar Ahmed on 24/02/2022.
//

import Foundation

struct LeagueModel: Codable {
    let countrys: [Country]?
}

// MARK: - Country
struct Country: Codable {
    var idLeague: String?
    let idSoccerXML: String?
    var idAPIfootball, strSport, strLeague, strLeagueAlternate: String?
    let intDivision, idCup, strCurrentSeason, intFormedYear: String?
    let dateFirstEvent, strGender, strCountry, strWebsite: String?
    let strFacebook: String?
    let strInstagram: String?
    var strTwitter, strYoutube, strRSS, strDescriptionEN: String?
    let strDescriptionDE, strDescriptionFR, strDescriptionIT, strDescriptionCN: String?
    let strDescriptionJP, strDescriptionRU, strDescriptionES, strDescriptionPT: String?
    let strDescriptionSE, strDescriptionNL, strDescriptionHU, strDescriptionNO: String?
    let strDescriptionPL, strDescriptionIL, strTvRights, strFanart1: String?
    let strFanart2, strFanart3, strFanart4, strBanner: String?
    var strBadge, strLogo: String?
    let strPoster, strTrophy: String?
    let strNaming: String?
    let strComplete: String?
    let strLocked: String?
}


