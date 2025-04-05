extends Node2D

@onready var red_dice = $red_dice
@onready var white_dice = $white_dice
@onready var label = $Label

func check_winner_if_ready():
	if red_dice.result != -1 and white_dice.result != -1:
		var red = red_dice.result + 1
		var white = white_dice.result + 1
		
		if red > white:
			label.text = "🔴 Red Wins! " + str(red) + " vs " + str(white)
		elif white > red:
			label.text = "⚪ White Wins! " + str(white) + " vs " + str(red)
		else:
			label.text = "🤝 It's a tie! " + str(red) + " vs " + str(white)
		
		# Reset results after displaying winner
		red_dice.result = -1
		white_dice.result = -1
