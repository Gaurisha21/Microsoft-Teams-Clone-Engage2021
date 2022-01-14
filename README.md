## Microsoft Teams Clone: Engage 2021
<img src="Read Me Images/Read Me Banner/1.png" alt="Banner" height='340' width='1000'/>

Microsoft Teams Clone is a flutter app developed for Microsoft Engage 2021. As a part of the program, the mentees were assigned the task to develop a clone of the Teams App with the feature of Video Calling and Chatting by implementing the Agile Methodology. The main aim of the project is to develop a professional video calling environment with ease of use and simplicity. 

## Table of contents
- [Technology Stack](#technology-stack)
- [Features of the Application](#features-of-the-application)
- [Installation](#installation)
- [Screenshots of the Project](#screenshots-of-the-project) 
- [Support and Contact](#support-and-contact)

## Technology Stack
<div>
      <p align ="center">
        <img src="Read Me Images/Tech Stack Images/flutter.png" alt="Flutter" width="110px" />
        <img src="Read Me Images/Tech Stack Images/firebase.png" alt="FireBase" width="60px" />
        <img src="Read Me Images/Tech Stack Images/dart.png" alt="Dart" width="80px" />
        <img src="Read Me Images/Tech Stack Images/github.png" alt="GitHub" width="80px"/>
        <img src="Read Me Images/Tech Stack Images/agora.png" alt="Agora" width="80px"/>
      </p>
</div>

- Flutter and Dart were used to develop the app.
- Firebase was used for the database.
- Agora.IO was used to provide real-time communication via video calling.
<br/>[(Back to top)](#table-of-contents)

## Features of the Application
<img src="Read Me Images/App Overview/appOverview.jpeg" alt="App Overview" height='340' width='1000'/>

### <img src="https://img.icons8.com/external-kiranshastry-solid-kiranshastry/64/000000/external-email-cyber-security-kiranshastry-solid-kiranshastry-1.png" width="30px" />&ensp;Register and Login with Email ID and Password
- User information is saved in the FireStore database by FireBase.
- The password is hashed first and then stored.

### <img src="https://img.icons8.com/color/48/000000/gmail--v2.gif" width="30px" />&ensp;Login with Google
- google_sign_in flutter plugin is used to implement the feature.
- User information is saved in the FireStore database by FireBase.

### <img src="https://img.icons8.com/color/48/000000/chat--v3.gif" width="40px" />&ensp;Chat
- Individual chatting channels stored in FireBase database. 
- Chatting Features:
  - <!--<img src="https://img.icons8.com/pastel-glyph/64/000000/chat.png" width="20px" />--> Personal chatting with other users.
  - <!--<img src="https://img.icons8.com/external-justicon-lineal-color-justicon/64/000000/external-emoji-emoji-justicon-lineal-color-justicon-3.png" width="15px" />--> Texting with Emojis.
  - <!--<img src="https://img.icons8.com/stickers/100/000000/deciduous-tree.png" width="20px" />--> Texting with Stickers.
  - <!--<img src="https://img.icons8.com/color/48/000000/clock--v3.png" width="20px" />--> Time stamps for each received text.
  - Image sharing with Zoom in and out feature.

### <img src="https://img.icons8.com/color/48/000000/video-call--v2.gif" width="30px" />&ensp;Video Calling
- Flutter plugin for Agora Video SDK is used to integrate video calling. 
- Agora Video SDK provides real-time voice and video communications.
- All clients connected on a particular channel publish their audio and video tracks to the server.
- The server is then broadcasts the received tracks to the other participants present in the call.
- Video Call in a Group With upto 4 people

### <img src="https://img.icons8.com/office/48/000000/live-video-on.gif" width="30px" />&ensp; Live Streaming
- A video call can be live streamed using Flutter plugin for Agora Video SDK.
- One host can live stream the video call.

### <img src="https://img.icons8.com/color/48/000000/block-microphone--v2.gif" width="30px" />&ensp;Mute/Unmute Audio
- This is done by unpublishing user's audio stream to the server.
- The server relays this information to all other clients.

### <img src="https://img.icons8.com/color/50/000000/name--v2.gif" width="40px" />&ensp;Web Cam Freeze/Unfreeze
- Freeze the web cam feed during the video call.
- This is done by disabling the web came while diplaying the last captured frame.

### <img src="https://img.icons8.com/ios/50/000000/computer-chat--v2.gif" width="30px" />&ensp;Chat rooms while Video Calling (Adapt Feature)
- Chat rooms with all the features of chatting (mentioned above) while video calling.
- Chat rooms preserves the messages from the individual chat channel.

### <img src="https://img.icons8.com/color/48/000000/calendar--v2.gif" width="30px" />&ensp;In-App Calendar
- table_calendar flutter plugin is used to add a calendar.
- Monthly, Bi-weekly and weekly views of the calendar are available.

### <img src="https://img.icons8.com/color/48/000000/appointment-reminders--v3.gif" width="30px" />&ensp;In-App Event Scheduler
- Scheduling event like video calls, meetings etc. in the app.
- The events are stored in the FireStore Database.
- The event can store details like Title, Description, Meeting Channel Starting and Ending Date and Time of the event.

### <img src="https://img.icons8.com/color/48/000000/tear-off-calendar--v2.gif" width="30px" />&ensp;Event Scheduling in Device's Default Calender
- add_2_calendar flutter plugin is used to add events to device's default calendar.
- Reminders for the scheduled event are also provided.

### <img src="https://img.icons8.com/color/48/000000/task--v2.gif" width="30px" />&ensp;Note Taking
- Jote down notes in the app itself.
- All notes for individual user are stored in the user specific databse in FireBase.
- Details like Title, Date and Time of taking note, Note are stored.
<br/>[(Back to top)](#table-of-contents)

## Installation
To use this project, follow the steps below:
#### 1. Clone this repository.
Initialise git on your terminal.

```bash
git init
git clone https://github.com/Gaurisha21/Microsoft-Teams-Clone-Engage2021.git
```

Change the directory. 

```bash
cd "MS Teams"/msteams
```
#### 2. Generate the Token for the App <br/>
Go to the [Agora Console](https://dashboard.agora.io/signin/) and follow the following steps<br/>
<img align="left" src="Read Me Images/Token Generation Steps/StepsToAddTheToken.png" alt="Steps to Generate Token" height='1500' width='1000' />

Use the Channel Name to enter the video room in the app.<br/>

#### 3. Add the Token to the App <br/>
Open the settings.dart file in the MS Teams->msteams->lib->utils folder and add the app ID and the Token.
```dart
  const APP_ID = "";
  String Token = 'YOUR_TOKEN';
```
Open the chatVideoCall.dart file in the MS Teams->msteams->lib->Chat folder and add the app ID and the Token.

```dart
  const APP_ID = "";
  const Token = 'YOUR_TOKEN';
```
Run the `packages get` command in your project directory:

```bash
  # install dependencies
  flutter pub get
```
Once the build is complete, run the `run` command to start the app.

```bash
  # start app
  flutter run
```
<br/>[(Back to top)](#table-of-contents)

## Screenshots of the Project
- <h3>Launch 
<p align="left">
    <kbd><img src="Read Me Images/App Screenshot/1.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
</p>
<p align="left">
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Launch Page</h5>
</p>
<hr>

- <h3>Register and Login
<p align="left">
    <kbd><img src="Read Me Images/App Screenshot/2.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <kbd><img src="Read Me Images/App Screenshot/3.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<p align="left">
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sign Up Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Register with Email Id Page</h5>
</p>
<p align="left">
    <kbd><img src="Read Me Images/App Screenshot/4.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <kbd><img src="Read Me Images/App Screenshot/5.png" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
 </p>
<p align="left">
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Login with Email Id Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Login with Google Page</h5>
</p>
<hr>

- <h3>Home Page and Slide Menu
<p align="left">
    <kbd><img src="Read Me Images/App Screenshot/6.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <kbd><img src="Read Me Images/App Screenshot/7.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<p align="left">
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Home Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Slide Menu</h5>
</p>
<hr>

- <h3>Video Calling and Live Streaming
<p align="left">
    <kbd><img src="Read Me Images/App Screenshot/8.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <kbd><img src="Read Me Images/App Screenshot/9.jpeg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <kbd><img src="Read Me Images/App Screenshot/10.jpeg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
 </p>
<p align="left">
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Video Call/Live Stream Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Video Call Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Live Stream Page</h5>
</p>
<hr>

- <h3>Chatting
<p align="left">
    <kbd><img src="Read Me Images/App Screenshot/11.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <kbd><img src="Read Me Images/App Screenshot/12.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<p align="left">
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chat Log Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Personal Window</h5>
</p>
<hr>

- <h3>Calender
<p align="left">
    <kbd><img src="Read Me Images/App Screenshot/13.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <kbd><img src="Read Me Images/App Screenshot/20.jpeg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <kbd><img src="Read Me Images/App Screenshot/19.jpeg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
 </p>
<p align="left">
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Monthly View Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Bi-weekly View Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Weekly Page</h5>
</p>
<hr>

- <h3>Event Scheduler
<p align="left">
    <kbd><img src="Read Me Images/App Screenshot/14.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <kbd><img src="Read Me Images/App Screenshot/15.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
    <kbd><img src="Read Me Images/App Screenshot/16.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
 </p>
<p align="left">
<h5>&nbsp;&nbsp;In-App/Default Scheduler Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In-App Scheduler Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Default Calendar Scheduler</h5>
</p>
<hr>

- <h3>Note Taking
<p align="left">
    <kbd><img src="Read Me Images/App Screenshot/17.jpg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <kbd><img src="Read Me Images/App Screenshot/18.jpeg" height='400' width='200'></kbd>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<p align="left">
<h5>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Note List Page&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Note Creation Page</h5>
</p>
<hr>

[(Back to top)](#table-of-contents)

## Support and Contact
Email To: gaurisharsrivastava@gmail.com
<br/>[(Back to top)](#table-of-contents)
