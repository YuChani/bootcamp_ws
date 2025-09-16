# bootcamp_ws

# RUN limo gazebo
roslaunch limo_gazebo_sim limo_four_diff.launch

# MAKE map
roslaunch turtlebot3_slam turtlebot3_slam.launch 

# RUN limo navigation
roslaunch turtlebot3_navigation turtlebot3_navigation.launch 
