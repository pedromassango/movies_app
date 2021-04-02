# Challenge - Movie App

A movie app challenge. The data comes from The Movie Database.


## Notes before running

1. This project uses code generation, it may be necessary to run `flutter pub run build_runner build` first.

## Considerations

1. All the requirements are met.
2. It is possible to remove items from favorites by swiping from
   right-to-left in the favorites tab.
3. It is possible to open the action menu in movie details page
   by scrolling the content. Note: Animation is not perfect yet.
3. I've done so many things to demonstrate the DDD architecture
   since the time is limited, I was not able to meet all the requirements.

3. There is a known bug: when you navigate to detail page from  movies
   list, and go to favorites list then go to the details page again
   with the same movie, Flutter will complain that 
   there is two Hero widgets using the same tag.
   
## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
