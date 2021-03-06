/// Configuration options for sessions.
public struct SessionsConfig {
    /// Creates a new `HTTPCookieValue` for the supplied value `String`.
    public let cookieFactory: (SessionID) -> HTTPCookieValue

    /// Name of HTTP cookie, used as a key for the cookie value.
    public let cookieName: String

    /// Create a new `SessionsConfig` with the supplied cookie factory.
    ///
    ///     let sessionsConfig = SessionsConfig(cookieName: "vapor-session") { value in
    ///         return HTTPCookieValue(string: value, isSecure: true)
    ///     }
    ///
    /// - parameters:
    ///     - cookieName: Name of HTTP cookie, used as a key for the cookie value.
    ///     - cookieFactory: Creates a new `HTTPCookieValue` for the supplied value `String`.
    public init(cookieName: String, cookieFactory: @escaping (SessionID) -> HTTPCookieValue) {
        self.cookieName = cookieName
        self.cookieFactory = cookieFactory
    }

    /// `SessionsConfig` with basic cookie factory.
    public static func `default`() -> SessionsConfig {
        return .init(cookieName: "vapor-session") { sessionID in
            return HTTPCookieValue(
                string: sessionID.string,
                expires: Date(
                    timeIntervalSinceNow: 60 * 60 * 24 * 7 // one week
                ),
                maxAge: nil,
                domain: nil,
                path: "/",
                isSecure: false,
                isHTTPOnly: false,
                sameSite: nil
            )
        }
    }
}
