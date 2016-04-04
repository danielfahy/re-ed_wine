# Coding Challange -Daniel Fahy


## Explained Solution

1. Since this is basically a import, list and search app. I've tried imagine how a user would use it if it wasn't just with a small number of records
1. Ordering
    * The products are sorted alphabetically by name (I felt this was the most logical)
    * I'm displaying the names as received but storing them as a lowercase slug (replacing any non ASCII also)
    * Example (d'Arenberg was annoyingly being put at the end of the list)
1. Navigation
    * The image for items added manually is different to that of the others (natural distinction)
    * The user can navigate to a product, CRUD it, and return to the page number, which that product is in, in the overall paginated list. It acts like memory for the user
    * I imagine this would be great if editing a number of similar products
    * I've included a description preview so the user can see if its worth visiting the show page from the index page
1. Search
  * The search is persisted when traversing pages
  * The products are sorted by the same rules as normal list and are also paginated
1. I noticed there were HTML tags in some of the description text so this is removed when importing
1. Testing
    * I've included testing of the WINE service, and done the most important parts of the product model


### Obvious Short Falls
1. The UX leaves a lot to be desired... Styling firstly. but also Hover-able list items to navigate to show page, a little bin for delete etc.
2. I'm not happy with the loading Icon. It should display for a minimum time regardless, also it should be specific to the button clicked.
3. I would add more information to the wine products
4. The Java-script code is not DRY
5. Testing
  * I've written less tests than I'm happy with. I would like to have included test for all functions on the product model & some skimming of the search functionality with Capybara
  * Also the tests are allowed make requests to the server this is really bad practice. should record and replay using VCR