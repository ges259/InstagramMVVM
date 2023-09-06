//
//  DBString.swift
//  InstagramMVVM
//
//  Created by 계은성 on 2023/09/06.
//

import FirebaseDatabase

let DB_REF: DatabaseReference = Database.database().reference()

let USER_REF: DatabaseReference = DB_REF.child("users")
