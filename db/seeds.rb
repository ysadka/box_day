p 'event creation'

Event.create( name: 'box dev day',
              date: Date.today
            )

p 'prize creation'

Prize.create( name: 'uber credits',
              event_id: 1
            )

p 'tweet creation'

Tweet.create!( body: "Lorem Ipsom @yaronsadka #what!",
              username: "yaronsadka"
            )

p 'winner creation'

Winner.create(
              prize_id: 1,
              tweet_id: 1
             )
