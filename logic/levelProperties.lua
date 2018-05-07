----------------------------------------------
-- For storing map attributes (pipe-->houses)
----------------------------------------------

maps =
{
    l1 = { --level 1
        envTemp = 20, --environment temperature
        limit = 4, --error limit
        decrease = 1, --decrease of house temperature per second
        time = 10, --level gametime
        pipes = { --table of pipes
            p1 = {
                temp = 70, --water temperature
                houses = { --houses connected to pipe 'p1'
                    "h1"
                },
				tempLabelPos = {
					x = 145,
					y = 185
				},
				btnPos = {
					x = 170,
					y = 265
				}
            }
        },
        houses = {
            h1 = {
                goal = 70, --goal temperature
				tempLabelPos = {
					x = 165,
					y = 25
				}
            }
        },
		levelImage = "assets/levels/level1.png",
		levelTimePos = {
			x = 200,
			y = -20
		},
		
    },

    l2 = {
        envTemp = 20,
        limit = 4,
        decrease = 2,
        time = 180, 
        pipes = { 
            p1 = {
                temp = 70,
                houses = { 
                    "h1", "h2"
                }
            },
            p2 ={
                temp = 60,
                houses = {
                    "h1", "h2"
                }
            }
        },
        houses = {
            h1 = {
                goal = 60
            },
            h2 = {
                goal = 25
            }
        }
    }

}
