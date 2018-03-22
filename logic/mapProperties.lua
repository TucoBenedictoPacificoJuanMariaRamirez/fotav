----------------------------------------------
-- For storing map attributes (pipe-->houses)
----------------------------------------------

maps =
{
    l1 = { --level 1
        decrease = 1,
        time = 180, --level gametime
        pipes = { --table of pipes
            p1 = {
                temp = 70, --water temperature
                houses = { --houses connected to pipe 'p1'
                    "h1"
                }
            }
        },
        houses = {
            h1 = {
                temp = 50
            }
        }
    },

    l2 = {
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
                temp = 60
            },
            h2 = {
                temp = 25
            }
        }
    }

}