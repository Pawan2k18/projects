//
//  AirportCode.swift
//  AlamofireWithSwiftyJSON
//
//  Created by Pawan Dey on 03/05/19.
//  Copyright © 2019 Kode. All rights reserved.
//

import Foundation

typealias Airportcode = [AirportcodeElement]

struct AirportcodeElement {
    let id, iatAcode, cityCode, cityName: String
    let countryCode, countryName: String
    let stateCode: StateCode
    let stateName, nbrOfAirports, airport, priority: String
}

enum StateCode {
    case ab
    case ac
    case ak
    case al
    case am
    case ap
    case ar
    case az
    case ba
    case bc
    case ca
    case cb
    case cd
    case ce
    case ch
    case co
    case cr
    case ct
    case dc
    case de
    case df
    case empty
    case er
    case es
    case federatedStatesOf
    case fl
    case fo
    case ga
    case go
    case hi
    case ia
    case id
    case il
    case ks
    case ky
    case la
    case lp
    case lr
    case ma
    case mb
    case md
    case me
    case mg
    case mi
    case mn
    case mo
    case ms
    case mt
    case nb
    case nc
    case nd
    case ne
    case nh
    case nj
    case nl
    case nm
    case north
    case ns
    case nt
    case nu
    case nv
    case ny
    case oh
    case ok
    case on
    case or
    case pa
    case pb
    case pe
    case pi
    case pj
    case pr
    case qc
    case ql
    case republicOfThe
    case ri
    case rj
    case rn
    case ro
    case rr
    case rs
    case sa
    case sc
    case sd
    case se
    case sf
    case sj
    case sk
    case sl
    case south
    case sp
    case stateCodeIN
    case tf
    case the
    case tn
    case to
    case ts
    case tu
    case tx
    case ut
    case va
    case vi
    case vt
    case wa
    case wi
    case wv
    case wy
    case yt
}
