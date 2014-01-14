ARWalkImages
============

A simple excercise to test backgorund functions (based on user position change) on iOS 7 & 6.

##Description
The user is starting the app and presses the start button. After that he
starts walking, every 100m, a picture for his location is requested
from the panoramio api and added to his stream. New pictures are added
on top. So any time he takes the phone out of his pocket, he can scroll
through a stream of pictures which shows him impressions of where he has
been.

The purpose of this project is only to test background function so the photo stream is not persistent (Core Data or simila). If the user presses the stop button and close tha app, when he reopens the application, iOS restart it and the stream is clean.


