
#Using particle swarm optimization to lower the gate count of combinational circuits.

Particle swarm optimization:

Particle Swarm Optimization (PSO) is a computation technique which is used for optimization in several applications. It solves a problem by having a population of possible solutions, here dubbed particles, and moving these particles around in the search-space according to simple mathematical formula over the particle's position and velocity. Each particle's movement is influenced by its local best position, and is guided toward the best known global positions in the search-space, both of which are updated as better positions are found by the collection of particles. This is moves the swarm toward the best possible solution.
In this project, PSO is used for the optimization of digital combinational circuits. The result obtained after the implementation of the optimization algorithm is shown to have lesser number of gates as compared to other methods such as K-Map and Quine Mccluskey. For the purpose of this project MATLAB code has been used to implement all the requisite parts of the algorithm.






## Fitness value of particles-
Fitness value of the particles- Fitness value helps us to achieve the desired circuit. A desired circuit is the one whose output matches with the output of the desired circuit, for all possible input combinations. It is calculated by comparing the output of each circuit obtained in every iteration with the outputs of the actual circuit for all input combinations. For example, if 4 output values are matched with the desired circuit, then the fitness achieved is 4. Desired circuit is obtained if fitness value of 8(23 for 3 input combinational circuits) is obtained. Hence, the maximum fitness achieved in every iteration helps in finding the optimal solution.

## Implementation of 7x3 matrix to develop circuits-
In our optimization application, we have taken the different combination of gates as the particles. Such circuits are developed with the help of a 7x3 matrix. In our circuits, we have taken A, B and C as the primary inputs from the truth table of the combinational circuit. R0, R1 and R2 are the outputs obtained from the gates in the first column. Similarly, S0, S1 and S2 are the outputs obtained from the gates in the second column. F is the final output of the circuit obtained from PSO algorithm. This output is calculated for all the possible input combinations of A, B and C and then compared with the corresponding outputs of digital circuit to calculate the fitness value.


![7x3matrix](https://github.com/SatyajitMondal27/pso_combinational_circuits/assets/124804860/2a990f47-1c52-4cc1-bb82-00575e6250ac)

 

In the 7 x 3 matrix, the values in the first and third column represent the inputs to the gates. For example, 1 is used to represent A, 2 is used to represent A’, 4 is used to represent R0 etc. Similarly second column represents the type of gate. For example 1 is used to represent AND, 2 for OR etc.
The complete encoding is described in the figure below

![table](https://github.com/SatyajitMondal27/pso_combinational_circuits/assets/124804860/0d882070-56e8-49fb-bb4f-d5ca2ab246d7)

						

## Algorithm Used
•	A Population of particles i.e. in our optimization application, 5 random matrices are being used. They represent 5 initial position matrices. Similarly 5 Random velocity matrices have been taken.  

•	 The fitness of each particle is used to obtain pbest and gbest.  

•	 In each iteration, comparison of each particle’s fitness with previous fitness is done. If the current value is better, then set the pbest equal to the current position of the particle. Else pbest remains the same as in previous iteration.  

•	 Fitness of all particles is compared with each other. The gbest i.e global best of all the particles is updated with the pbest of the particle having highest fitness value.  
•	 Change velocity and position of the particle according to the equations below.  
•	 Repeat the above steps until the optimal solution is reached. Example, in 3 input combinational circuits, the target is to achieve the maximum fitness value of 8.
The equations for updating particle’s velocity and position are:  
•	 Vi+1 = W* Vi + C1* rand1 * (pbest – X1) + C2 * rand2 * (gbest – X1)  
•	 Xi+1 = Vi+1 + Xi  
Where Vi and Xi represent the particle’s velocity and position of previous iteration; Vi+1 and Xi+1 represent the particle’s velocity and position of current iteration. W is the weight that controls the exploration and exploitation of search space and i is the iteration number pbest and gbest have been explained before. C1 and C2 are acceleration constants that change the velocity of particle towards pbest and gbest. rand1 and rand2 are the two uniformly distributed random functions whose value lies in {0,1}  . Experimentally the value of W has been taken as 0.9. Values of acceleration constants C1 and C2 have been taken as 2. 
