return {
	setup = function()

		-- Status:children_remove(1, Status.LEFT) -- MODE
		-- Status:children_remove(2, Status.LEFT) -- size
		Status:children_remove(3, Status.LEFT) -- Desktop

  	Status:children_remove(4, Status.RIGHT) -- OWNERSHIP
		-- Status:children_remove(5, Status.RIGHT) -- percentage
		-- Status:children_remove(6, Status.RIGHT) -- file counter

	end,
}
