For this application, I have developed a user-based application that supports user registration, login, checking of current location, displaying the weather, and showing past check-in records. The fundamental truth of the project was to couple the location-based service with getting the weather into one application coupled with user authentication and persistence. The application uses Flutter as the front-end interface, Spring boot for backend and third-party APIs, such as Map and WeatherAPI, which would provide an interactive map together with current weather to enhance user experience. Location and weather information for the history will be kept in the local database, so any previous check-ins are at the user's view.    

1. Run Docker

```docker run --name my-postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres:15```

2. Run backend
 - go to ```src/main/java/org/puxuan/checkinapp/CheckinAppApplication.java```
 - <img width="1386" alt="Screenshot 2024-09-10 at 11 45 35 PM" src="https://github.com/user-attachments/assets/49d851b9-2eef-4d41-9f55-ca73c7826e4f">
3. Run Frontend
 - go to ```frontend1/my_game/lib/main.dart```
 - ```flutter run```

https://gtvault-my.sharepoint.com/:v:/g/personal/ysun613_gatech_edu/EQd_8_p2sYFItErxuZ50zZkB6ljhHNeOhVz0IgauZagxxw?e=g3mbeY
