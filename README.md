# feed_forward

`feed_forward` is a simple neural network implementation using feed forward and
genetic algorithms.

## Example

In following example we create a network with 1 input layer, 3 hidden layers
and 1 output layer.

```vlang
import feed_forward { network }

fn main() {
	mut network := network([3, 5, 5, 5, 1])
	network.process([0.25, 0.5, 0.75])
	if network.output[0] > 0.5 {
		// trigger action like jump
	}
	// genetic algorithms, used for creating new, better networks
	network.mutate()
	new_network := network.crossover(network([3, 5, 5, 5, 1])) // networks MUST have same layout
}
```
