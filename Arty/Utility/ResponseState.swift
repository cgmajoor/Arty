//
//  ResponseState.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

enum ResponseState<T> {
    case loading
    case finished(Outcome)
    enum Outcome {
        case success(T)
        case failure(Error)
    }
}
