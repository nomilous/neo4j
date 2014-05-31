{ipso} = require 'ipso'

describe 'planets', ->

    before ipso (done, request) ->

        #
        # clear the database
        #

        request.post 'http://localhost:7474/db/data/cypher',

            json:

                query: 'MATCH (n) OPTIONAL MATCH (n)-[r]-() DELETE n, r'

            (err, res, body) ->

                # console.log status: res.statusCode
                # console.log body
                done()


    before ipso (done, request) ->

        #
        # create sun
        #

        request.post 'http://localhost:7474/db/data/cypher', 

            json: 

                query: "CREATE (s:Star {name: 'Sun'} ) RETURN s"

                # params: props: name: 'Sun'

            (err, res, body) =>

                # console.log status: res.statusCode
                # console.log body
                done()


    before ipso (done, request) ->

        #
        # create solar system
        #

        request.post 'http://localhost:7474/db/data/cypher', 

            json: 

                # query: "CREATE (p:Planet {props} ) RETURN p"

                # params:

                #     props: [

                #         { name: "Mercury" }
                #         { name: "Venus" }
                #         { name: "Earth" }
                #         { name: "Mars" }
                #         { name: "Jupiter" }
                #         { name: "Saturn" }
                #         { name: "Uranus" }
                #         { name: "Neptune" }

                #     ]

                query: """

                MATCH (star:Star)
                WHERE star.name = 'Sun'

                CREATE (mercury :Planet {name: 'Mercury'})
                CREATE (venus :Planet {name: 'Venus'})
                CREATE (earth :Planet {name: 'Earth'})
                CREATE (mars :Planet {name: 'Mars'})
                CREATE (jupiter :Planet {name: 'Jupiter'})
                CREATE (saturn :Planet {name: 'Saturn'})
                CREATE (uranus :Planet {name: 'Uranus'})
                CREATE (neptune :Planet {name: 'Neptune'})

                CREATE (mercury)-[:SATELITE_OF]->(star)
                CREATE (venus)-[:SATELITE_OF]->(star)
                CREATE (earth)-[:SATELITE_OF]->(star)
                CREATE (mars)-[:SATELITE_OF]->(star)
                CREATE (jupiter)-[:SATELITE_OF]->(star)
                CREATE (saturn)-[:SATELITE_OF]->(star)
                CREATE (uranus)-[:SATELITE_OF]->(star)
                CREATE (neptune)-[:SATELITE_OF]->(star)

                CREATE (moon :Moon {name: 'Moon'})
                CREATE (moon)-[:SATELITE_OF]->(earth)

                CREATE (phobos :Moon {name: 'Phobos'})
                CREATE (deimos :Moon {name: 'Deimos'})
                CREATE (phobos)-[:SATELITE_OF]->(mars)
                CREATE (deimos)-[:SATELITE_OF]->(mars)

                CREATE (io :Moon {name: 'Io'})
                CREATE (europa :Moon {name: 'Europa'})
                CREATE (ganymede :Moon {name: 'Ganymede'})
                CREATE (calisto :Moon {name: 'Calisto'})
                CREATE (io)-[:SATELITE_OF]->(jupiter)
                CREATE (europa)-[:SATELITE_OF]->(jupiter)
                CREATE (ganymede)-[:SATELITE_OF]->(jupiter)
                CREATE (calisto)-[:SATELITE_OF]->(jupiter)

                CREATE (mimas :Moon {name: 'Mimas'})
                CREATE (enceladus :Moon {name: 'Enceladus'})
                CREATE (tethys :Moon {name: 'Tethys'})
                CREATE (dione :Moon {name: 'Dione'})
                CREATE (rhea :Moon {name: 'Rhea'})
                CREATE (titan :Moon {name: 'Titan'})
                CREATE (iapetus :Moon {name: 'Iapetus'})
                CREATE (mimas)-[:SATELITE_OF]->(saturn)
                CREATE (enceladus)-[:SATELITE_OF]->(saturn)
                CREATE (tethys)-[:SATELITE_OF]->(saturn)
                CREATE (dione)-[:SATELITE_OF]->(saturn)
                CREATE (rhea)-[:SATELITE_OF]->(saturn)
                CREATE (titan)-[:SATELITE_OF]->(saturn)
                CREATE (iapetus)-[:SATELITE_OF]->(saturn)

                CREATE (miranda :Moon {name: 'Miranda'})
                CREATE (ariel :Moon {name: 'Ariel'})
                CREATE (umbriel :Moon {name: 'Umbriel'})
                CREATE (titania :Moon {name: 'Titania'})
                CREATE (oberon :Moon {name: 'Oberon'})
                CREATE (miranda)-[:SATELITE_OF]->(uranus)
                CREATE (ariel)-[:SATELITE_OF]->(uranus)
                CREATE (umbriel)-[:SATELITE_OF]->(uranus)
                CREATE (titania)-[:SATELITE_OF]->(uranus)
                CREATE (oberon)-[:SATELITE_OF]->(uranus)

                CREATE (triton :Moon {name: 'Triton'})
                CREATE (triton)-[:SATELITE_OF]->(neptune)


                """

            (err, res, body) ->

                # console.log status: res.statusCode
                console.log body
                done()


    it '', ->