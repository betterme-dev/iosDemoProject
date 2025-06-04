//
//  RequestManagerImpl.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import Foundation


final class RequestManagerImpl: RequestManager {
    func v5EmailSingInPost(email: String, password: String) -> Request<EmailSignInResponse> {
        return Request<EmailSignInResponse> { completion in
            let task = Task { [weak self] in
                try await Task.sleep(nanoseconds: UInt64(3 * 1_000_000_000))
                
                guard let self = self else { return }
                
                completion(.success(self.v5EmailSingInSuccessResponse()))
            }
            
            return Command {
                task.cancel()
            }
        }
    }
    
    func v5SingOutPost() -> Request<Void> {
        return Request<Void> { completion in
            let task = Task {
                try await Task.sleep(nanoseconds: UInt64(1 * 1_000_000_000))
                
                completion(.success(Void()))
            }
            
            return Command {
                task.cancel()
            }
        }
    }
    
    func v5FastingsGet() -> Request<[Fasting]> {
        return Request<[Fasting]> { completion in
            let task = Task {
                try await Task.sleep(nanoseconds: UInt64(1 * 1_000_000_000))
                
                completion(.success([
                    .init(id: UUID().uuidString, name: "Circadian Rhythm TRF", fastingHours: 4, eatingHours: 4, description: ""),
                    .init(id: UUID().uuidString, name: "16:8 TRF", fastingHours: 16, eatingHours: 8, description: ""),
                    .init(id: UUID().uuidString, name: "20:4 TRF", fastingHours: 20, eatingHours: 4, description: ""),
                ]))
            }
            
            return Command {
                task.cancel()
            }
        }
    }
}

private extension RequestManagerImpl {
    func v5EmailSingInSuccessResponse() -> EmailSignInResponse {
        EmailSignInResponse(
            userProperties: UserPropertiesResponse(
                fullName: "Shawn Howard",
                avatarUrl: nil,
                dateOfBirth: DateComponents(year: 2000, month: 1, day: 1),
                about: "One answer is that Truth pertains to the possibility that an event will occur. If true – it must occur and if false, it cannot occur. This is a binary world of extreme existential."
            ),
            emailAccount: EmailAccountResponse(
                email: "qwerty@g.com",
                confirmed: true
            ),
            auth: AuthTokenInfoResponse(
                accessToken: "qwerty",
                expiresInTimestamp: 123456789,
                tokenType: "qwerty",
                refreshToken: "qwertyqwerty"
            )
        )
    }
}

enum RequestManagerFactory {
    static func `default`() -> RequestManager {
        RequestManagerImpl()
    }
}

enum RequestManagerLocator {
    private static var instance: RequestManager?

    static func populate(with instance: RequestManager) {
        self.instance = instance
    }

    static var shared: RequestManager {
        if let instance = instance {
            return instance
        }

        fatalError("RequestManager instance not populated in locator")
    }
}
