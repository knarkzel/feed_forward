# feed_forward

`feed_forward` is a simple neural network implementation using feed forward and
genetic algorithms.

## Install

```bash
v install --git https://github.com/knarkzel/feed_forward
```

## Example

In following example we create a network with 1 input layer (3 nodes),
3 hidden layers (5 nodes each) and 1 output layer (1 node).

```vlang
import feed_forward { network }

fn main() {
	mut network := network([3, 5, 5, 5, 1])
	network.feed([0.25, 0.5, 0.75])
	if network.output()[0] > 0.5 {
		// trigger action like jump
	}
	// genetic algorithms, used for creating new, better networks
	network.mutate()
	new_network := network.crossover(network([3, 5, 5, 5, 1])) // networks MUST have same layout
}
```


