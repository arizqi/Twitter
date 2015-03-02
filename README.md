## Twitter

This is a twitter clone [Twitter API](https://dev.twitter.com/rest/public).

Time spent: `11`

### Features
- [X] User can sign in using OAuth login flow
- [X] User can view last 20 tweets from their home timeline
- [X] The current signed in user will be persisted across restarts
- [X] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp. In other words, design the custom cell with the proper Auto Layout settings. You will also need to augment the model classes.
- [X] User can pull to refresh
- [X] User can compose a new tweet by tapping on a compose button.
- [X] User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [X] Optional: When composing, you should have a countdown in the upper right for the tweet limit.
- [X] Optional: After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [] Optional: Retweeting and favoriting should increment the retweet and favorite count.
- [] Optional: User should be able to unretweet and unfavorite and should decrement the retweet and favorite count.
- [] Optional: Replies should be prefixed with the username and the reply_id should be set when posting the tweet,
- [] Optional: User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.

### Walkthrough
![Video Walkthrough](https://github.com/arizqi/Twitter/blob/master/twitter.gif)

Credits
---------
* [AFNetworking](http://www.yelp.com/developers/documentation/v2/search_api)
* [MBProgressHUD](https://github.com/jdg/MBProgressHUD)
* NSDateMinimal
* AFNetworking
* 


## Twitter Redux

This is a twitter redux

Time spent: `11`

### Features
- [X] Hamburger menu
- [X] Dragging anywhere in the view should reveal the menu.
- [X] The menu should include links to your profile, the home timeline, and the mentions view. The menu can look similar to the LinkedIn menu below or feel free to take liberty with the UI.
- [X] Profile page
- [X] Contains the user header view
- [X]Contains a section with the users basic stats: # tweets, # following, # followers
- [] Optional: Implement the paging view for the user description.
- [] Optional: As the paging view moves, increase the opacity of the background screen. See the actual Twitter app for this effect
- [] Optional: Pulling down the profile page should blur and resize the header image.
- [X] Home Timeline
- [X] Tapping on a user image should bring up that user's profile page
- [] Optional: Account switching
- []Long press on tab bar to bring up Account view with animation
- [] Tap account to switch to
- [] Include a plus button to Add an Account
- [] Swipe to delete an account

### Walkthrough
![Video Walkthrough](https://github.com/arizqi/Twitter/blob/master/twitter_redux.gif)

Credits
---------
* [AFNetworking](http://www.yelp.com/developers/documentation/v2/search_api)
* [MBProgressHUD](https://github.com/jdg/MBProgressHUD)
* NSDateMinimal
* AFNetworking