## Rock-Paper-Scissor
game <- function() {
# Intro
print("Welcome to the Rock-Paper-Scissor game!")

# Ask player's name
name <- readline("Hey, Player! What's your name: ")

# Welcome player
print(paste("Hi", name, "! Let's play Rock-Paper-Scissor together!"))

# Initialize scores for player and computer -> may record after stop game
player_score <- 0
computer_score <-0

#Gameplay
while (TRUE) {
  # Generate computer's choice
  computer_choice <- sample(c("Rock🔨", "Paper📄", "Scrissors🔪"), 1)

  # Ask player's choice
  print("Choose your choice: ")
  print("1. Rock🔨, 2. paper📄, 3. scissors🔪")
  flush.console()
  player_choice <- as.numeric(readline("Enter the no. of your LIFE chice (1, 2, 3): "))

  # Check if player's choice is valid
  if (player_choice %in% c(1, 2, 3)) {
    # Map numeric input to corresponding move -> then prepare with computer
    moves <- c("Rock🔨", "Paper📄", "Scissors🔪")
    player_move <- moves[player_choice]

    # Compare player's choice and computer's choice
    print(paste(name, "'s choice: ", player_move))
    print(paste("Computer's choice: ", computer_choice))


    if (player_move == computer_choice) {
      print("Tie! Come onnn!")
    } else if ((player_move == "Rock🔨" & computer_choice == "Scissors🔪") |
               (player_move == "Scissors🔪" & computer_choice == "Paper📄") |
               (player_move == "Paper📄" & computer_choice == "Rock🔨")) {
      print("You win!")
      player_score <- player_score +1
    } else {
      print("Computer wins!")
      computer_score <- computer_score +1
    }

    print(paste("Player's Score:", player_score, ", Computer's Score:", computer_score))
  } else {
    print("Invalid choice. Please try again.")
  }

  # Ask if player wants to continue
  flush.console()
  continue <- readline("Do you want to continue? (y/n): ")

  # If player does not want to continue, stop/break the loop
  if (tolower(continue) != "y") {
    break
  }
}


# Summary score
print(paste(name, "'s final score is:", player_score))
print(paste("Computer's final score is:", computer_score))
}
