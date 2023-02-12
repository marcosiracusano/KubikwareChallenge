# Instructions

Just hit `cmd + r` and you should be good to go. The project uses just one external library (_Kingfisher_) which was integrated with _Swift Package Manager_, so there's no need for any special setup to compile it.

# Developer notes

 - **Architecture**: I decided to for an MVVM architecture, as I wanted to create a scalable and testable app that wouldn't present problems in the future. This approach required a solution for the bindings management to handle state, so I decided to use the Combine framework for that. The only external library that I decided to integrate is `Kingfisher` for images fetching and handling, not because it was extremely necessary, but because it was handy, neat and reliable library.
 
 - **UX/UI**: I wanted to show a simple yet complete list of rows that displayed most of the available information of each restaurant, without making it too "noisy". With that in mind, and also checking out the **thefork** website as a reference, I decided to use badges with colors to display the ratings discount info and cuisine type. Then, to show the address and price info I used the provided assets to indicate the meaning of the corresponding information to avoid extra text such as _"Address: ..."_, or _"Average price: ..."_ that would've used unnecesary space in the row. Finally, regarding the restaurants main picture, I decided to make it the main character of each row by adding a custom shadow and a border color to make it stand out.
 
 - **Testing**: I wrote unit tests for most of the components of the app, reaching a total coverage of **82.7%**. I used the XCTest framework, as there wasn't any specific scenario that required the inclusion of another testing library.
 

# iOS Technical Test

The main goal of this test is to write a single screen application.

## User Story

### Restaurant list

As a user, I would like to be a able to see a list of restaurants:
- I can scroll through the list of restaurants
- I can see the main picture of each restaurant
- I can find the main information of each restaurant: name, rating, address
- I can see a heart icon for each restaurant indicating whether the restaurant is a favorite or not

### Favorites

As a user:
- I can tap the heart to add or remove the restaurant from my favorites
- If I kill the app, then restart it, I can still see which restaurants are my favorites

## Technical instruction

- You should write your application in **Swift**
- Your code should run starting **iOS 13**
- Your views must be defined programmatically with UIKit (no **xib** nor **storyboard** for cells)
- Restaurants data is accessible on this [JSON file](https://alanflament.github.io/TFTest/test.json) and must be fetched through a network call (Do not add the JSON file to your project)
- Some assets can be found in the archive (images) to help you, however feel free to use any other of your choice

## Work delivery

You should provide the following elements:
- Access to your git repository
- Instructions to build your project
- A brief explanation of the technical choices and potential difficulties

## Evaluation criteria

- Your test compiles and run
- Your implementation can easily be understood by the reviewer
- Your code is well structured and your architecture makes it testable 
- The UI design does not matter, you won't be evaluated on your design skills, but if you want to demonstrate your skills on this topic, go ahead of course :)
- Feel free to add any feature you can imagine, it's your project, the expression of what you want to show us :)

## Deadline

The test is doable in 2 hours, but feel free to spend whatever amount of time you need on it.
The only constraint would be to receive your final project in one week from the moment you received it.
