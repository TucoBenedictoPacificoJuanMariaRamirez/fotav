----------------------------------------------
--- Level properties for storing map attributes (pipe-->houses)
--@module levelProperties
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
                goal = 60, --goal temperature
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
        time = 15,
        pipes = {
            p1 = {
                temp = 70,
                houses = {
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
            },
            p2 ={
                temp = 40,
                houses = {
                    "h1"
                },
				tempLabelPos = {
					x = 140,
					y = 395
				},
				btnPos = {
					x = 167,
					y = 455
				}
            }
        },
        houses = {
            h1 = {
                goal = 60,
				tempLabelPos = {
					x = 165,
					y = 25
				}
            },
        },
		levelImage = "assets/levels/level2.png",
		levelTimePos = {
			x = 200,
			y = -20
		},

    },

	l3 = {
        envTemp = 20,
        limit = 4,
        decrease = 2,
        time = 30,
        pipes = {
            p1 = {
                temp = 70,
                houses = {
                    "h1"
                },
				tempLabelPos = {
					x = 215,
					y = 435
				},
				btnPos = {
					x = 245,
					y = 355
				}
            },
            p2 ={
                temp = 40,
                houses = {
                    "h2"
                },
				tempLabelPos = {
					x = 70,
					y = 190
				},
				btnPos = {
					x = 47,
					y = 317
				}
            },
			p3 ={
                temp = 95,
                houses = {
                    "h3"
                },
				tempLabelPos = {
					x = 215,
					y = 192
				},
				btnPos = {
					x = 130,
					y = 370
				}
            }
        },
        houses = {
            h1 = {
                goal = 60,
				tempLabelPos = {
					x = 150,
					y = 0
				}
            },
            h2 = {
                goal = 25,
				tempLabelPos = {
					x = 225,
					y = -10
				}
            },
			h3 = {
                goal = 25,
				tempLabelPos = {
					x = 292,
					y = 17
				}
            }
        },
		levelImage = "assets/levels/level3.png",
		levelTimePos = {
			x = 30,
			y = -20
		},
    }

}
