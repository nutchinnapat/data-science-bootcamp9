pizza_chatbot <- function() {
    print("Welcome to Pizza Nutchin! :)")

    # Ask for customer's name
    name <- readline("What's your name? ")

    # Greeting
    print(paste("Hi", name, "! Nice to meet you, How can I assist you today?"))

    #Ini order
    order <- list()
    total_price <- 0

    # Chat Dialogue
  repeat {
    # Ask for pizza details
    flush.console()
    pizza_type <- readline("What type of pizza would you like? (1. Seafood, 2. Pepperoni, 3. Vegetarian)")

    # Validate pizza type input
    if (!pizza_type %in% c(1, 2, 3)) {
      print("Invalid pizza type. Please select a valid option.")
      next  # Skip the rest of the loop iteration and start a new one
    }

    # Map numeric input to corresponding pizza type and set the price
    pizza_types <- c("Seafood", "Pepperoni", "Vegetarian")
    selected_pizza_type <- pizza_types[as.numeric(pizza_type)]

    pizza_size <- toupper(readline("What size would you like (S, M, L)? "))

    # Ask for payment method
    payment_method <- readline("How would you like to pay (cash, QR code, bank transfer, credit card)? ")

    # Calculate the price based on pizza size (s-80%, l-120%)
    # base from pizza type -> multiplier by size
    size_multiplier <- ifelse(pizza_size == "S", 0.8, ifelse(pizza_size == "M", 1, 1.2))
    price <- switch(selected_pizza_type,
                    Seafood = 12 * size_multiplier,
                    Pepperoni = 10 * size_multiplier,
                    Vegetarian = 9 * size_multiplier)

    # Add credit card charge (5%) if the payment method is credit card
    if (tolower(payment_method) == "credit card") {
      credit_card_charge <- 0.05
      charge_amount <- price * credit_card_charge
      print(paste("A", credit_card_charge * 100, "% charge will be applied for paying with a credit card."))
      price <- price + charge_amount
    }

    # Update the total price
    total_price <- total_price + price

    # Add the order to the list
    order <- c(order, list(list(type = pizza_type, size = pizza_size, price = price)))

    # Ask if the user wants to continue/ buy  -> back to repeat...
    flush.console()
    continue <- tolower(readline("Do you want to add another pizza to your order? (y/n): "))
    if (continue != "y") {
      break
    }
  }

  # Display order summary
  print(paste("Order summary for", name, ":"))
  for (i in seq_along(order)) {
    print(paste("Pizza", i, "- Type:", order[[i]]$type, ", Size:", order[[i]]$size, ", Price: $", order[[i]]$price))
  }

  # Display total price
  print(paste("Total price: $", total_price))

  # Check for coupon code (TOYGPT=5%)
  flush.console()
  coupon_code <- readline("Do you have a coupon code? Enter it here (or press Enter to skip): ")
  if (coupon_code == "TOYGPT" && length(order) >= 2) {
    discount_percentage <- 5
    discount_amount <- total_price * (discount_percentage / 100)
    print(paste("Congratulations! You've got a", discount_percentage, "% discount on your order."))
    print(paste("Discount amount: $", discount_amount))
    total_price <- total_price - discount_amount
    print(paste("Total amount: $", total_price))
  }

  # Ask for delivery address
  flush.console()
  delivery_address <- readline("Enter your delivery address: ")

  # Confirmation step
  flush.console()
  confirm_order <- tolower(readline("Great! Confirm your order? (y/n): "))
  if (confirm_order == "y") {
    print(paste("Thank you, ", name, "! Your order will be delivered to:", delivery_address))
    print("Enjoy your pizza!")
  } else {
    print("Order cancelled. Feel free to reorder when you're ready. :)")
  }
}
