# Chess

##Engine Implementation Details
The AI implements a minimax tree to evaluate its position and find the best move. The premise is that it looks X moves ahead evaluates every resulting position and then follows the moves that lead to the best position it can force, and reevaluates after each response move. However, because the number of possible positions grows so fast (after just 3 moves by each color there are 9 million possible positions, after 4 there are over 288 billion) it would be impossible to evaluate more than 1 move ahead using a simple min-max algorithm. To overcome this the AI also implements alpha-beta pruning into its minimax algorithm. Alpha-beta pruning allows the AI to stop evaluating branches as soon as it recognizes that it would never have gotten to them because there would have been a better option for either player somewhere higher up the tree. Below is code from the test_move function which tries out an individual move by creating a child node to further evaluate the candidate move: