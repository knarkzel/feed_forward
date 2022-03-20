module feed_forward

import rand

fn relu(x f64) f64 {
	return if x < 0 { 0.01 * x } else { 1 }
}

struct Node {
pub mut:
	data    f64
	bias    f64
	weights []f64
}

fn (nx Node) average(ny Node) Node {
	mut weights := []f64{}
	for i in 0 .. nx.weights.len {
		weights << (nx.weights[i] + ny.weights[i]) / 2
	}
	return Node{
		bias: (nx.bias + ny.bias) / 2
		weights: weights
	}
}

pub struct Network {
pub mut:
	nodes [][]Node
}

pub fn network(structure []int) Network {
	mut network := Network{}
	for i in 0 .. structure.len - 1 {
		mut nodes := []Node{}
		for _ in 0 .. structure[i] {
			mut weights := []f64{}
			for _ in 0 .. structure[i + 1] {
				weights << rand.f64_in_range(-1, 1) or { 0 }
			}
			nodes << Node{
				bias: rand.f64_in_range(-1, 1) or { 0 }
				weights: weights
			}
		}
		network.nodes << nodes
	}
	network.nodes << [Node{}].repeat(structure.last())
	return network
}

pub fn (mut n Network) feed(input []f64) {
	for i, mut node in n.nodes[0] {
		node.data = input[i]
	}
	for i in 1 .. n.nodes.len {
		for j in 0 .. n.nodes[i].len {
			mut sum := f64(0)
			for node in n.nodes[i - 1] {
				sum += node.data * node.weights[j] + node.bias
			}
			n.nodes[i][j].data = relu(sum)
		}
	}
}

pub fn (n Network) output() []f64 {
	return n.nodes.last().map(it.data)
}

pub fn (mut n Network) mutate() {
	for mut layer in n.nodes {
		for mut node in layer {
			if rand.f64() < 0.2 {
				node.bias *= rand.f64_in_range(0.5, 1) or { 0.75 }
				for mut weight in node.weights {
					weight *= rand.f64_in_range(0.5, 1) or { 0.75 }
				}
			}
		}
	}
}

pub fn (nx Network) crossover(ny Network) Network {
	mut layers := [][]Node{}
	for i, layer in nx.nodes {
		mut nodes := []Node{}
		for j, node in layer {
			nodes << node.average(ny.nodes[i][j])
		}
		layers << nodes
	}
	return Network{
		nodes: layers
	}
}
