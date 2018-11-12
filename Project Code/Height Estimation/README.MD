The matlab code below is used for measuring the height of the human using parameters obtained using a non-linear regression model.

First, a set of images with their head and foot co-ordinates (both x and y) are supplied to the file. The height of the subject must also be mentioned.
We then use the inbuilt leastsquaresfit function to generate the parameters. Note that these parameters are naturally approximated.

The next step is to use the head and foot coordinates of the other subject to estimate the height. Note that the actual height of the new subject is not at all required for the algorithm.

The algorithm follows mathematical equations described in the report.
