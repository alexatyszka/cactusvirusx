import sys
import re

class NewickString:
	def __init__(self):
		self.string = ""
		self.pos = 0

#A class to create and manipulate hierarchichal structures
class Node:
	def __init__(self):
		self.label = ""
		self.length = ""
		self.parent = None
		self.children = []
		self.istip = False
		self.counter = 0
		self.newick = ""
		self.bipart = []
		
	
	def add_child(self,child):
		
		assert child not in self.children
		self.children.append(child)
		child.parent = self
	
	def remove_child(self, child):

		assert child in self.children
		self.children.remove(child)
		child.parent = None
		
	#gets the clade names
	def get_nms(self,nms):
		if self.istip == True:
			nms.append(self.label)
		for child in self.children:
			child.get_nms(nms)		
	
	
	def post_order_bips(self,bips):
		if self.istip != True:
			array = []
			self.get_nms(array)
			bips.append(array)
		for child in self.children:
			child.post_order_bips(bips)
	
	def get_newick_repr(self, showbl=False):
		ret = ""
		for i in range(len(self.children)):
			if i == 0:
				ret += "("
			ret += self.children[i].get_newick_repr(showbl)
			if i == len(self.children)-1:
				ret += ")"
			else:
				ret += ","
		if self.label != None:
			ret += str(self.label)
		if showbl == True:
			ret += ":" + str(self.length)
		return ret
	
	#Part of recurse tree
	def child_props(self, newick):
		
		while re.match(r"^[A-Za-z0-9\.@_-]*$", newick.string[newick.pos]):
			self.label += newick.string[newick.pos]
			newick.pos += 1
		if newick.string[newick.pos] == ":":
			newick.pos += 1
			while re.match(r"^[0-9e\.-]*$", newick.string[newick.pos]):
				self.length += str(newick.string[newick.pos])
				newick.pos += 1
		if newick.string[newick.pos] == ")":
			newick.pos += 1
		return newick.pos
	
	#Recursively make a tree structure
	def recurse_tree(self, newick):

		#check opening bracket and if this is true then that
		#means an opening
		if newick.string[newick.pos] == "(":
			newick.pos += 1
			if newick.string[newick.pos] == "(":
				nd = Node()
				nd.recurse_tree(newick)
				self.add_child(nd)
			#Its a tip node
			if re.match(r"^[A-Za-z0-9\.:@_-]*$", newick.string[newick.pos]):
				nd = Node()
				nd.istip = True
				newick.pos = nd.child_props(newick)
				self.add_child(nd)
		#This means it is either a sister or this is a situation where there are no
		#branch lengths or support/clade labels
		if newick.string[newick.pos] == ",":
			newick.pos += 1
			if re.match(r"^[A-Za-z0-9\.:@_-]*$", newick.string[newick.pos]):
				nd = Node()
				nd.istip = True
				newick.pos = nd.child_props(newick)
				self.add_child(nd)
			if newick.string[newick.pos] == "(":
				nd = Node()
				nd.recurse_tree(newick)
				self.add_child(nd)
			if newick.string[newick.pos] == ",":
				self.recurse_tree(newick)
			
		if re.match(r"^[A-Za-z0-9:\.@_-]*$", newick.string[newick.pos]):
			newick.pos = self.child_props(newick)
		
		if newick.string[newick.pos] == ")":
			newick.pos += 1
		
	#Adds the newick string at every node
	def get_newick(self):

		self.newick = ""
		for child in range(0,len(self.children)):
			if child == 0:
				self.newick += "("
			self.children[child].get_newick()
			self.newick += self.children[child].newick
			if child == (len(self.children)-1):
				self.newick += ")"
			else:
				self.newick += ","
		if self.label != "":
			self.newick += self.label
		if self.length != "":
			self.newick += ":" + self.length

if __name__ == "__main__":

	
	if len(sys.argv) != 2:
		print("To run your own: python3 TreeCode.py Tree")
		sys.exit()
	
	tree = open(sys.argv[1],"r")
	tree_string = tree.readline().strip("\n")
	print(tree_string)
	
	root = Node()
	newick = NewickString()
	newick.string = tree_string
	root.recurse_tree(newick)
	full_array = []
	root.get_nms(full_array)
	bipartitions =[]
	root.post_order_bips(bipartitions)
	for x in bipartitions:
		print(x)

