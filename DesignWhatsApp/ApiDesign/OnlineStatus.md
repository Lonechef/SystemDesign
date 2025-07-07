-> So the message status goes to three phases whihc is basically message has left the user 1 basically sent from the user 1 and then jmessage recived by user 2
and further more user 2 reads the message 
-> So in this basically whren you send the mesagge so at that time only web sockete request notify the user back by sending a single tick to tell the usera A that the message has been delievered 

-> Online Status in Wp shows wehn the user is Last active 
-> So what haoppens is basically when a users is using the WP then the device will contunusly send the activity statys to the server by  sending the current timestamp to the whatsapp server the so lets say emily opens wp at 4 pm then it will send the updates to wp server informing about the user application is currently open now again  every minute whaapp server will receive about the activity of the user and once the user closes wp then the prev timestamp will becvome the last seen 

->  While max will send the request query to wo server to know the laste seen of the emily also this will happen over web socket commnication and max will get to know abut online activity of the emily  