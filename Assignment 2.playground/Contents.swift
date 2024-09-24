import Foundation

//MARK: - ORDER ITEMS
protocol OrderItem {
    var name: String { get }
    var portion: Double { get }
    var price: Double { get }
}

enum Appetizer: OrderItem {
    case greek(portion: Double)
    case caesar(portion: Double)
    case green(portion: Double)
    
    var name: String {
        switch self {
        case .greek:
            return "Greek Salad 🥗"
        case .caesar: 
            return "Caesar Salad 🥗"
        case .green: 
            return "Green Salad 🥗"
        }
    }
    
    var portion: Double {
        switch self {
        case .greek(let portion), .caesar(let portion), .green(let portion):
            return portion
        }
    }
    
    var price: Double {
        switch self {
        case .greek(portion), .green(portion):
            return 4.0
        default:
            return 5.0
        }
    }
}

enum MainCourse: OrderItem {
    case pizza(portion: Double)
    case pasta(portion: Double)
    case chicken(portion: Double)
    case fries(portion: Double)
    
    var name: String {
        switch self {
        case .pizza: 
            return "Pizza 🍕"
        case .pasta: return 
            "Pasta 🍝"
        case .chicken: return 
            "Chicken 🍗"
        case .fries: return 
            "Fries 🍟"
        }
    }
    
    var portion: Double {
        switch self {
        case .pizza(let portion), .pasta(let portion), .chicken(let portion), .fries(let portion):
            return portion
        }
    }
    
    var price: Double {
        switch self {
        case .pizza: 
            return 10.0
        case .pasta: 
            return 8.0
        case .chicken: 
            return 15.0
        case .fries: 
            return 5.0
        }
    }
}

enum Dessert: OrderItem {
    case iceCream(portion: Double)
    case brownie
    case lavaCake
    
    var name: String {
        switch self {
        case .iceCream: 
            return "Ice Cream 🍦"
        case .brownie: 
            return "Brownie 🥮"
        case .lavaCake: 
            return "Lava Cake 🍥"
        }
    }
    
    var portion: Double {
        switch self {
        case .brownie, .lavaCake:
            return 1
        case .iceCream(let portion):
            return portion
        }
    }
    
    var price: Double {
        return 5.0
    }
}

enum Beverage: OrderItem {
    case coffee(portion: Double)
    case tea(portion: Double)
    case juice(portion: Double)
    case soda(portion: Double)
    case water(portion: Double)
    case wine(portion: Double)
    
    var name: String {
        switch self {
        case .coffee: 
            return "Coffee ☕️"
        case .tea: 
            return "Tea 🫖"
        case .juice: 
            return "Juice 🍹"
        case .soda: 
            return "Soda 🥃"
        case .water: 
            return "Water 🥛"
        case .wine: 
            return "Wine 🍷"
        }
    }
    
    var portion: Double {
        switch self {
        case .coffee(let portion), .tea(let portion), .juice(let portion), .soda(let portion), .water(let portion), .wine(let portion):
            return portion
        }
    }
    
    var price: Double {
        switch self {
        case .coffee: return 3.0
        case .tea: return 2.0
        case .juice: return 4.0
        case .soda: return 2.5
        case .water: return 1.0
        case .wine: return 7.0
        }
    }
}
//MARK: - Restaurants Models

class Customer {
    var id: UUID
    private(set) var waiter: Waiter?
    private(set) var order: Order?
    
    init(waiter: Waiter? = nil, order: Order? = nil) {
        self.id = UUID()
        self.waiter = waiter
        self.order = order
    }
    
    func assignWaiter(_ waiter: Waiter) {
        if self.waiter == nil {
            self.waiter = waiter
        } else {
            print("Customer \(id) already has a waiter and cannot be reassigned.")
        }
    }
    
    func placeOrder(_ order: Order) {
        self.order = order
    }
}

class Waiter {
    var id: UUID
    var name: String
    private(set) var customers: [Customer]
    
    init(name: String, customers: [Customer] = []) {
        self.id = UUID()
        self.name = name
        self.customers = customers
    }
    
    func addCustomer(customer: Customer){
        if customer.waiter == nil {
            customers.append(customer)
            customer.assignWaiter(self)
            print("Customer \(customer.id) assigned to Waiter \(self.name).")
        } else {
            print("Customer \(customer.id) already has a waiter and cannot be reassigned.")
        }
    }
}

struct Order {
    var id: UUID = UUID()
    var items: [OrderItem]
    
    func totalPrice() -> Double {
        return items.reduce(0) { $0 + ($1.price * $1.portion) }
    }
}

func information(customer: Customer){
    guard let order = customer.order, let waiter = customer.waiter else {
            print("Customer \(customer.id) either has no order or no assigned waiter.")
            return
        }
    let orderDetails = order.items.map { item in
           "\(item.name) - Portion: \(item.portion), Price: \(item.price)"
       }.joined(separator: "\n")
    
    print("""
            Customer with ID: \(customer.id) gives order:
            \(orderDetails)
            to the waiter Name: \(waiter.name), ID: \(waiter.id)
            with total price: \(order.totalPrice())
        """)
}

// Create waiter
let waiterJohn = Waiter(name: "John")
let waiterSona = Waiter(name: "Sona")
let waiterAni = Waiter(name: "Ani")

// Create customer
let customerAlice = Customer()
waiterJohn.addCustomer(customer: customerAlice)
waiterSona.addCustomer(customer: customerAlice)

let customerOne = Customer()
//waiterJohn.addCustomer(customer: customerOne)
waiterSona.addCustomer(customer: customerOne)

customerAlice.placeOrder(Order(items: [MainCourse.pasta(portion: 1), MainCourse.fries(portion: 2), Beverage.juice(portion: 1)]))
customerOne.placeOrder(Order(items: [Dessert.brownie, Beverage.coffee(portion: 1)]))


information(customer: customerAlice)

information(customer: customerOne)

