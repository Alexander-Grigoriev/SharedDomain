import Foundation

public struct Money: Equatable, Sendable {
    public let amount: Decimal
    public let currencyCode: String
    public init(amount: Decimal, currencyCode: String) {
        self.amount = amount
        self.currencyCode = currencyCode
    }
}

public enum Category: String, CaseIterable, Codable, Sendable {
    case groceries, rent, dining, transport, subscriptions, income, other
}

public struct FinanceTransaction: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let date: Date
    public let money: Money
    public let category: Category
    public let merchant: String

    public init(id: UUID, date: Date, money: Money, category: Category, merchant: String) {
        self.id = id
        self.date = date
        self.money = money
        self.category = category
        self.merchant = merchant
    }
}

public struct TransactionsFilter: Equatable, Sendable {
    public var from: Date?
    public var to: Date?
    public var categories: Set<Category>

    public init(from: Date? = nil, to: Date? = nil, categories: Set<Category> = []) {
        self.from = from
        self.to = to
        self.categories = categories
    }
}

public protocol TransactionsRepository: Sendable {
    func observeTransactions(filter: TransactionsFilter) -> AsyncThrowingStream<[FinanceTransaction], Error>
    func refreshTransactions() async throws
}

