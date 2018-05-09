//
//  DBManager.swift
//  NightSpree
//
//  Created by AppsCreationTech on 2/21/18.
//  Copyright © 2018 AppsCreationTech. All rights reserved.
//

import Foundation

func documentsPath() -> String {
    return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
}

struct Cart {
    let id : Int?    
    var userEmail : String
    var barObjectId : String
    var barName : String
    var barTime : Int
    var drinkObjectId : String
    var drinkName : String
    var drinkImage : String
    var drinkDesc : String
    var drinkUnitPrice : String
    var drinkUnit : String
    var drinkTaxes : String
    var nbDrinks : Int
    var hasGlass : Bool
    var glassObjectId : String
    var glassName : String
    var glassImage : String
    var glassUnitPrice : String
    var glassUnit : String
    var nbGlasses : Int
}

extension Cart : Sqlable {
    static let id = Column("id", .integer, PrimaryKey(autoincrement: true))
    static let userEmail = Column("userEmail", .text)
    static let barObjectId = Column("barObjectId", .text)
    static let barName = Column("barName", .text)
    static let barTime = Column("barTime", .integer)
    static let drinkObjectId = Column("drinkObjectId", .text)
    static let drinkName = Column("drinkName", .text)
    static let drinkImage = Column("drinkImage", .text)
    static let drinkDesc = Column("drinkDesc", .text)
    static let drinkUnitPrice = Column("drinkUnitPrice", .text)
    static let drinkUnit = Column("drinkUnit", .text)
    static let drinkTaxes = Column("drinkTaxes", .text)
    static let nbDrinks = Column("nbDrinks", .integer)
    static let hasGlass = Column("hasGlass", .boolean)
    static let glassObjectId = Column("glassObjectId", .text)
    static let glassName = Column("glassName", .text)
    static let glassImage = Column("glassImage", .text)
    static let glassUnitPrice = Column("glassUnitPrice", .text)
    static let glassUnit = Column("glassUnit", .text)
    static let nbGlasses = Column("nbGlasses", .integer)
    static let tableLayout = [id, userEmail, barObjectId, barName, barTime,
                              drinkObjectId, drinkName, drinkImage, drinkDesc, drinkUnitPrice, drinkUnit, drinkTaxes, nbDrinks,
                              hasGlass, glassObjectId, glassName, glassImage, glassUnitPrice, glassUnit, nbGlasses]
    
    func valueForColumn(_ column : Column) -> SqlValue? {
        switch column {
        case Cart.id: return id
        case Cart.userEmail: return userEmail
        case Cart.barObjectId: return barObjectId
        case Cart.barName: return barName
        case Cart.barTime: return barTime
        case Cart.drinkObjectId: return drinkObjectId
        case Cart.drinkName: return drinkName
        case Cart.drinkImage: return drinkImage
        case Cart.drinkDesc: return drinkDesc
        case Cart.drinkUnitPrice: return drinkUnitPrice
        case Cart.drinkUnit: return drinkUnit
        case Cart.drinkTaxes: return drinkTaxes
        case Cart.nbDrinks: return nbDrinks
        case Cart.hasGlass: return hasGlass
        case Cart.glassObjectId: return glassObjectId
        case Cart.glassName: return glassName
        case Cart.glassImage: return glassImage
        case Cart.glassUnitPrice: return glassUnitPrice
        case Cart.glassUnit: return glassUnit
        case Cart.nbGlasses: return nbGlasses
        case _: return nil
        }
    }
    
    init(row : ReadRow) throws {
        id = try row.get(Cart.id)
        userEmail = try row.get(Cart.userEmail)
        barObjectId = try row.get(Cart.barObjectId)
        barName = try row.get(Cart.barName)
        barTime = try row.get(Cart.barTime)
        drinkObjectId = try row.get(Cart.drinkObjectId)
        drinkName = try row.get(Cart.drinkName)
        drinkImage = try row.get(Cart.drinkImage)
        drinkDesc = try row.get(Cart.drinkDesc)
        drinkUnitPrice = try row.get(Cart.drinkUnitPrice)
        drinkUnit = try row.get(Cart.drinkUnit)
        drinkTaxes = try row.get(Cart.drinkTaxes)
        nbDrinks = try row.get(Cart.nbDrinks)
        hasGlass = try row.get(Cart.hasGlass)
        glassObjectId = try row.get(Cart.glassObjectId)
        glassName = try row.get(Cart.glassName)
        glassImage = try row.get(Cart.glassImage)
        glassUnitPrice = try row.get(Cart.glassUnitPrice)
        glassUnit = try row.get(Cart.glassUnit)
        nbGlasses = try row.get(Cart.nbGlasses)
    }
}

struct DBManager {
    
    static public let path = documentsPath() + "/nig=========="
    static public var db : SqliteDatabase!
    
    static public func setUp() {
//        _ = try? SqliteDatabase.deleteDatabase(at: path)
        db = try! SqliteDatabase(filepath: path)
    }
    
    static public func createCartTable() {
        try! db.createTable(Cart.self)
    }
    
    static public func existCart(cart: Cart) -> Bool {
        let carts = try! Cart.read().filter(Cart.userEmail == cart.userEmail && Cart.drinkName == cart.drinkName && Cart.barObjectId != cart.barObjectId).run(db)
        
        if carts.count > 0 {
            return true
        } else {
            return false
        }
    }
    
    static public func insertCart(cart: Cart) {
        let carts1 = try! Cart.read().filter(Cart.userEmail == cart.userEmail && Cart.drinkName == cart.drinkName && Cart.barObjectId != cart.barObjectId).run(db)
        var carts2 = try! Cart.read().filter(Cart.userEmail == cart.userEmail && Cart.drinkObjectId == cart.drinkObjectId && Cart.barObjectId == cart.barObjectId).run(db)
        
        if carts1.count > 0 {
            try! Cart.delete(Cart.userEmail == cart.userEmail && Cart.drinkName == cart.drinkName).run(db)
            try! cart.insert().run(db)
            return
        } else if carts2.count > 0 {
            carts2[0].nbDrinks = carts2[0].nbDrinks + 1
            try! carts2[0].update().run(db)
        } else {
            try! cart.insert().run(db)
            return
        }
    }
    
    static public func deleteCart(email: String, barObjectId: String, drinkObjectId: String) {
        try! Cart.delete(Cart.userEmail == email && Cart.barObjectId == barObjectId && Cart.drinkObjectId == drinkObjectId).run(db)
    }
    
    static public func deleteAllCart(email: String) {
        try! Cart.delete(Cart.userEmail == email).run(db)
    }
    
    static public func countCart(email: String) -> Int {
        let count = try! Cart.count().filter(Cart.userEmail == email).run(db)
        return count
    }
    
    static public func readCart(email: String) -> [Cart] {
        let carts = try! Cart.read().orderBy(Cart.barObjectId).filter(Cart.userEmail == email).run(db)
        return carts
    }
    
    static public func updateCart(email: String, barObjectId: String, drinkObjectId: String, nbDrinks: Int) {
        var carts = try! Cart.read().filter(Cart.userEmail == email && Cart.barObjectId == barObjectId && Cart.drinkObjectId == drinkObjectId).limit(1).run(db)

        carts[0].nbDrinks = nbDrinks
        try! carts[0].update().run(db)
    }
    
}
