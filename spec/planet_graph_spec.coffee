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

                query: """

                    CREATE (s:Star {name: 'Sun'} )
                    RETURN s

                """

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

                CREATE (mercury :Planet {name: 'Mercury', diameter: 3813})
                CREATE (venus :Planet {name: 'Venus', diameter: 12063})
                CREATE (earth :Planet {name: 'Earth', diameter: 12712})
                CREATE (mars :Planet {name: 'Mars', diameter: 6762})
                CREATE (jupiter :Planet {name: 'Jupiter', diameter: 142374})
                CREATE (saturn :Planet {name: 'Saturn', diameter: 120115})
                CREATE (uranus :Planet {name: 'Uranus', diameter: 50848})
                CREATE (neptune :Planet {name: 'Neptune', diameter: 48305})

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
                # console.log body
                done()


    it 'can order planets by diameter', 

        ipso (done, request) ->

            request.post 'http://localhost:7474/db/data/cypher',

                json: 

                    query: """

                        MATCH (p:Planet)
                        RETURN p
                        ORDER BY p.diameter ASC

                    """

                (err, res, body) ->

                    planets = for row in body.data

                        (for column in row

                            column.data.name)[0]

                    planets.should.eql ['Mercury','Mars','Venus','Earth','Neptune','Uranus','Saturn','Jupiter']
                    done()


    it 'can find planets by relationship to sun', 

        ipso (done, request) ->



            request.post 'http://localhost:7474/db/data/cypher',

                json:

                    query: """
                        MATCH (planet)-[:SATELITE_OF]->(star:Star)
                        WHERE star.name = 'Sun'
                        RETURN planet

                    """

                (err, res, body) ->

                    planets = for row in body.data

                        (for column in row

                            column.data.name)[0]

                    planets.should.eql [ 'Mercury','Venus','Earth','Mars','Jupiter','Saturn','Uranus','Neptune' ]
                    done()


