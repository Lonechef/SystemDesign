-> So basically throughput means in how many secs our request will be  handled 
-> (1) So whenever sender sends the data then write operation takes place
-> (2) Is whenever status of the message chnages then also status changes (Then Update operation)
-> Read operations
-> Reciever reads the sent message
-> EVerytime Message state changes 
-> Sent -> Delievered -> Read 

Hence there are total 3 read and write operations 
Total Messages in a day = DAU * 10 Messages/day * 3 Write operations * 1 billion active users
-> Similarly toatal read requests can be 
Total Read Request = DAU * (10 Messages/day) * (3 Reads/message)
= 30 Billion Messages /day 
