Scott Wiersdorf created this http://www.fakecall.net/.

I created FCLibrary. FCLibrary is a library for fakecall.net. You don't need the entire project, you can just download libFCLibrary.a and and .h file and add it to your project.

Hoping others will take the library where it ultimately needs to go. Very barebones right now.

Know issues:

Unit Testing framework isn't working because the registration code requires user interaction to create a real account. Haven't figured out how to get this to work in the test harness yet, so if you know how, let's get it down.
UI is virtually non-existent. Just hacking on library at the moment.
old style memory-management (init/release)
doesn't use StoryBoards, but will when I get a few seconds.
