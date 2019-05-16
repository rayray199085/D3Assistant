//
//  SCSQLiteManager.swift
//  ReviewDatabase
//
//  Created by Stephen Cao on 13/5/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation
import FMDB

class SCSQLiteManager{
    static let shared = SCSQLiteManager()
    var queue: FMDatabaseQueue?
    
    private init() {
        let dbName = "mydata.db"
        let path = (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString).appendingPathComponent(dbName)
        // create database queue
        queue = FMDatabaseQueue(path: path)
        createTable()
    }
}

// MARK: - Normal execution
extension SCSQLiteManager{
    
    /// insert or edit data
    func update(userId: String, array: [[String: Any]]) {
        let sql = "INSERT OR REPLACE INTO T_Status (statusId, userId, status) VALUES (?,?,?)"
        queue?.inTransaction({ (db, rollback) in
            for dict in array{
                guard let statusId = dict["idstr"] as? String,
                    let data = try? JSONSerialization.data(withJSONObject: dict, options: []) else{
                        continue
                }
                if db.executeUpdate(sql, withArgumentsIn: [statusId,userId,data]) == false{
                    rollback.pointee = true
                    break
                }
            }
        })
    }
    
    func query(sql: String)->[[String: Any]]{
        var dictionaryList = [[String: Any]]()
//        query would not edit data, no need to use transaction
        queue?.inDatabase({ (db) in
            guard let resultSet = db.executeQuery(sql, withArgumentsIn: []) else{
                return
            }
            while resultSet.next(){
                var dict = [String: Any]()
                for i in 0..<resultSet.columnCount{
                    guard let name = resultSet.columnName(for: i),
                        let value = resultSet.object(forColumnIndex: i) else{
                        continue
                    }
                    dict[name] = value
                }
                dictionaryList.append(dict)
            }
        })
        return dictionaryList
    }
    
    
    /// load database data
    ///
    /// - Parameters:
    ///   - userId: user id
    ///   - since_id: load data id is larger than since_id
    ///   - max_id: load data id is smaller than max_id
    /// - Returns: array of dictionary
    func loadData(userId: String, since_id: Int64 = 0, max_id: Int64 = 0)->[[String: Any]]{
        var sql = "SELECT statusid, userid, status FROM T_Status \n"
        sql += "WHERE userid = \(userId) \n"
        if since_id > 0{
            sql += "AND statusid > \(since_id) \n"
        }else if max_id != 0{
            sql += "AND statusid < \(max_id) \n"
        }
        sql += "ORDER BY statusid DESC \n"
        sql += "LIMIT 20;"
        let array = query(sql: sql)
        var res = [[String: Any]]()
        for dict in array{
            guard let data = dict["status"] as? Data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else{
                continue
            }
            res.append(json)
        }
        return res
    }
}

// MARK: - Create table and other private functions
private extension SCSQLiteManager{
    func createTable(){
        guard let sqlFilePath = Bundle.main.path(forResource: "mydata", ofType: "sql"),
              let sql = try? String(contentsOfFile: sqlFilePath, encoding: String.Encoding.utf8) else{
                return
            }
        queue?.inDatabase({ (db) in
            if db.executeStatements(sql) == true{
                
            }
        })
    }
}
