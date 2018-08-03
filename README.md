# segment the cheetah image
This is a first part of series of computer problems given in course ECE 271A at UCSD.

The goal of the program is to segment the "cheetah" image into two components, Cheetah and grass.

To create a observation space we will use 8X8 image block. A discrete cosine transform of each block is then 
calculated and it will be transformed to a 1X64 vector to be used as a observation vector.
Using the file TraingSampleDCT_8.mat containes a training set of vectors from simular imagefor each class.
To make a task of estimation easier, each vector is going to be reduced to a scalar by choosing the second largest energy value(absolute value) and used as the feature X.( the reason the largest coefficient is not used is that it is contains the mean of the block and it 
is called "DC" coefficient. By creating a histogram of these indexed we obtain the class-conditional for the two classes. The priors 
for each class is estimated from training set as well.


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Feel free to use the code but if you are taking the course do not submit it as your own work professor Vasconcelos is well respected
instructor and it will result in your failure.
problem is taken from http://www.svcl.ucsd.edu/courses/ece271A/handouts/hw1.pdf
