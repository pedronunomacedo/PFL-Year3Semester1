. foldr (/) 7 [1,2,3]: This function takes the operator to be executed, a number and a list.
	1 - Go to the last element of the list and make the operation between the last element and the previous element (in this case, 3/2 = 1.5). 
	2 - Next, to the same thing to the "last" element (in this case, it will be 1) and make the operation between this number and the result of the previous operation (1.5/1 = 1.5). 
	3 - When we iterate through all the list, we make the operation between the last result and the number given as the 2nd argument (1.5/7 = 0.2142857...).