clc 
clear all
close all
x1=[1,1,3;3,2,5;0,0,0;7,3,8;0,0,0;0,0,0;10,4,0;];%initial random position matrices
x2=[1 1 5;3 1 5;0 0 0;7 2 8;0 0 0;0 0 0;10 4 0;];
x3=[1,3,3;1,3,5;0,0,0;7,1,8;0,0,0;0,0,0;10,4,0;];
x4=[1,1,5;1,2,3;1,3,5;0,0,0;8,1,9;0,0,0;7,3,11;];
x5=[1,2,3;1,1,5;3,3,3;7,3,8;0,0,0;0,0,0;9,3,10;];
v1=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;];%initial random velocity matrices  
v2=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;];
v3=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;];
v4=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;];
v5=[0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;0,0,0;];

currentfitness_1=0;%present fitness value
currentfitness_2=0;
currentfitness_3=0;
currentfitness_4=0;
currentfitness_5=0;

pbest1=0;
pbest2=0;
pbest3=0;
pbest4=0;
pbest5=0;
iteration=0;




while(currentfitness_1~=8&&currentfitness_2~=8&&currentfitness_3~=8&&currentfitness_4~=8&&currentfitness_5~=8)
iteration=iteration+1;

next_fitness_1=fitness_calculation(x1);% calculation of fitness value obtained from matrices
next_fitness_2=fitness_calculation(x2);
next_fitness_3=fitness_calculation(x3);
next_fitness_4=fitness_calculation(x4);
next_fitness_5=fitness_calculation(x5);


if(next_fitness_1>=currentfitness_1)  %update pbest and current fitness values
    pbest1=x1;
    currentfitness_1=next_fitness_1; 
end

if(next_fitness_2>=currentfitness_2)
    pbest2=x2;
    currentfitness_2=next_fitness_2;
end

if(next_fitness_3>=currentfitness_3)
    pbest3=x3;
    currentfitness_3=next_fitness_3;
end

if(next_fitness_4>=currentfitness_4)
    pbest4=x4;
    currentfitness_4=next_fitness_4;
end

if(next_fitness_5>=currentfitness_5)
    pbest5=x5;
    currentfitness_5=next_fitness_5;
end


fitness_array=[currentfitness_1,currentfitness_2,currentfitness_3,currentfitness_4,currentfitness_5]
max_element=0;
max_position=0;
for i=1:5
    if(fitness_array(i)>max_element)
        max_element=fitness_array(i);
        max_position=i;
    end   
end

particle_array(:,:,1)=x1;%gbest calculation
particle_array(:,:,2)=x2;
particle_array(:,:,3)=x3;
particle_array(:,:,4)=x4;
particle_array(:,:,5)=x5;
gbest=particle_array(:,:,max_position)

% Vi+1 = W* Vi + C1* rand1 * (pbest – X1) + C2 * rand2 * (gbest – X1)
% Xi+1 = Vi+1 + Xi
w=0.9;c1=2;c2=2;
v1= double(w*v1) + double(c1*rand*(double(pbest1)-double(x1))) + double(c2*rand*(double(gbest)-double(x1)));
x1=uint8(v1+double(x1));

v2= double(w*v2) + double(c1*rand*(double(pbest2)-double(x2))) + double(c2*rand*(double(gbest)-double(x2)));
x2=uint8(v2+double(x2));

v3= double(w*v3) + double(c1*rand*(double(pbest3)-double(x3))) + double(c2*rand*(double(gbest)-double(x3)));
x3=uint8(v3+double(x3));

v4= double(w*v4) + double(c1*rand*(double(pbest4)-double(x4))) + double(c2*rand*(double(gbest)-double(x4)));
x4=uint8(v4+double(x4));

v5= double(w*v5) + double(c1*rand*(double(pbest5)-double(x5))) + double(c2*rand*(double(gbest)-double(x5)));
x5=uint8(v5+double(x5));

end



function fitness_1=fitness_calculation(x1)
actual_output=[0;1;1;0;1;0;0;1];
matrix_output=[0;0;0;0;0;0;0;0];
fitness_1=0;

a=0;b=0;c=0;
matrix_output(1)=circuit(a,b,c,x1);
a=0;b=0;c=1;
matrix_output(2)=circuit(a,b,c,x1);
a=0;b=1;c=0;
matrix_output(3)=circuit(a,b,c,x1);
a=0;b=1;c=1;
matrix_output(4)=circuit(a,b,c,x1);
a=1;b=0;c=0;
matrix_output(5)=circuit(a,b,c,x1);
a=1;b=0;c=1;
matrix_output(6)=circuit(a,b,c,x1);
a=1;b=1;c=0;
matrix_output(7)=circuit(a,b,c,x1);
a=1;b=1;c=1;
matrix_output(8)=circuit(a,b,c,x1);

for i=1:8
    if(matrix_output(i)==actual_output(i))
        fitness_1=fitness_1+1;
    end
end
end





function output=circuit(a,b,c,x1)
w1=r0(a,b,c,x1);
w2=r1(a,b,c,x1);
w3=r2(a,b,c,x1);
w4=s0(a,b,c,w1,w2,w3,x1);
w5=s1(a,b,c,w1,w2,w3,x1);
w6=s2(a,b,c,w1,w2,w3,x1);
output=f1(a,b,c,w1,w2,w3,w4,w5,w6,x1);


function p1=r0(a,b,c,x1)
       if(x1(1,1)==1)
           op1=a;
       elseif(x1(1,1)==2)
           op1=bitcmp(a);
       elseif(x1(1,1)==3)
           op1=b;
       elseif(x1(1,1)==4)
           op1=bitcmp(b);
       elseif(x1(1,1)==5)
           op1=c;
       elseif(x1(1,1)==6)
           op1=bitcmp(c);           
       else
           op1=0; 
       end
       
       
       if(x1(1,3)==1)
           op2=a;
       elseif(x1(1,3)==2)
           op2=bitcmp(a);
       elseif(x1(1,3)==3)
           op2=b;
       elseif(x1(1,3)==4)
           op2=bitcmp(b);
       elseif(x1(1,3)==5)
           op2=c;
       elseif(x1(1,3)==6)
           op2=bitcmp(c);           
       else
           op2=0; 
       end
       
       if(x1(1,2)==1)
           p1=bitand(uint8(op1),uint8(op2));
       elseif(x1(1,2)==2)
           p1=bitor(uint8(op1),uint8(op2));
       elseif(x1(1,2)==3)
           p1=bitxor(uint8(op1),uint8(op2));
       elseif(x1(1,2)==4)
           if(op1==0 && op2==0)
               p1=1;
           else
               p1=0;
           end
       elseif(x1(1,2)==5)
           if(op1==0 && op2==0)
               p1=0;
           else
               p1=1;
           end    
       else 
           p1=0;
       end         
end


function p2=r1(a,b,c,x1)
       if(x1(2,1)==1)
           op1=a;
       elseif(x1(2,1)==2)
           op1=bitcmp(a);
       elseif(x1(2,1)==3)
           op1=b;
       elseif(x1(2,1)==4)
           op1=bitcmp(b);
       elseif(x1(2,1)==5)
           op1=c;
       elseif(x1(2,1)==6)
           op1=bitcmp(c);           
       else
           op1=0; 
       end
       
       
       if(x1(2,3)==1)
           op2=a;
       elseif(x1(2,3)==2)
           op2=bitcmp(a);
       elseif(x1(2,3)==3)
           op2=b;
       elseif(x1(2,3)==4)
           op2=bitcmp(b);
       elseif(x1(2,3)==5)
           op2=c;
       elseif(x1(2,3)==6)
           op2=bitcmp(c);           
       else
           op2=0; 
       end
       
       if(x1(2,2)==1)
           p2=bitand(uint8(op1),uint8(op2));
       elseif(x1(2,2)==2)
           p2=bitor(uint8(op1),uint8(op2));
       elseif(x1(2,2)==3)
           p2=bitxor(uint8(op1),uint8(op2));
       elseif(x1(2,2)==4)
           if(op1==0 && op2==0)
               p2=1;
           else
               p2=0;
           end
       elseif(x1(2,2)==5)
           if(op1==0 && op2==0)
               p2=0;
           else
               p2=1;
           end    
       else 
           p2=0;
       end   
end

function p3=r2(a,b,c,x1)
       if(x1(3,1)==1)
           op1=a;
       elseif(x1(3,1)==2)
           op1=bitcmp(a);
       elseif(x1(3,1)==3)
           op1=b;
       elseif(x1(3,1)==4)
           op1=bitcmp(b);
       elseif(x1(3,1)==5)
           op1=c;
       elseif(x1(3,1)==6)
           op1=bitcmp(c);           
       else
           op1=0; 
       end
       
       
       if(x1(3,3)==1)
           op2=a;
       elseif(x1(3,3)==2)
           op2=bitcmp(a);
       elseif(x1(3,3)==3)
           op2=b;
       elseif(x1(3,3)==4)
           op2=bitcmp(b);
       elseif(x1(3,3)==5)
           op2=c;
       elseif(x1(3,3)==6)
           op2=bitcmp(c);           
       else
           op2=0; 
       end
       
       if(x1(3,2)==1)
           p3=bitand(uint8(op1),uint8(op2));
       elseif(x1(3,2)==2)
           p3=bitor(uint8(op1),uint8(op2));
       elseif(x1(3,2)==3)
           p3=bitxor(uint8(op1),uint8(op2));
       elseif(x1(3,2)==4)
           if(op1==0 && op2==0)
               p3=1;
           else
               p3=0;
           end
       elseif(x1(3,2)==5)
           if(op1==0 && op2==0)
               p3=0;
           else
               p3=1;
           end    
       else 
           p3=0;
       end         
end


function p4=s0(a,b,c,w1,w2,w3,x1)
    if(x1(4,1)==1)
           op1=a;
    elseif(x1(4,1)==2)
          op1=bitcmp(a);
    elseif(x1(4,1)==3)
           op1=b;
    elseif(x1(4,1)==4)
          op1=bitcmp(b);
    elseif(x1(4,1)==5)
           op1=c;
    elseif(x1(4,1)==6)
           op1=bitcmp(c); 
    elseif(x1(4,1)==7)
        op1=w1;
    elseif(x1(4,1)==8)
        op1=w2;
    elseif(x1(4,1)==9)
        op1=w3;
    else
           op1=0; 
    end
       
       
       if(x1(4,3)==1)
           op2=a;
       elseif(x1(4,3)==2)
           op2=bitcmp(a);
       elseif(x1(4,3)==3)
           op2=b;
       elseif(x1(4,3)==4)
           op2=bitcmp(b);
       elseif(x1(4,3)==5)
           op2=c;
       elseif(x1(4,3)==6)
           op2=bitcmp(c);
       elseif(x1(4,3)==7)
           op2=w1;
       elseif(x1(4,3)==8)
           op2=w2;
       elseif(x1(4,3)==9)
           op2=w3;
       else
           op2=0; 
       end
       
       if(x1(4,2)==1)
           p4=bitand(uint8(op1),uint8(op2));
       elseif(x1(4,2)==2)
           p4=bitor(uint8(op1),uint8(op2));
       elseif(x1(4,2)==3)
           p4=bitxor(uint8(op1),uint8(op2));
       elseif(x1(4,2)==4)
           if(op1==0 && op2==0)
               p4=1;
           else
               p4=0;
           end
       elseif(x1(4,2)==5)
           if(op1==0 && op2==0)
               p4=0;
           else
               p4=1;
           end    
       else 
           p4=0;
       end   
       

end



function p5=s1(a,b,c,w1,w2,w3,x1)
    if(x1(5,1)==1)
           op1=a;
    elseif(x1(5,1)==2)
          op1=bitcmp(a);
    elseif(x1(5,1)==3)
           op1=b;
    elseif(x1(5,1)==4)
          op1=bitcmp(b);
    elseif(x1(5,1)==5)
           op1=c;
    elseif(x1(5,1)==6)
           op1=bitcmp(c); 
    elseif(x1(5,1)==7)
        op1=w1;
    elseif(x1(5,1)==8)
        op1=w2;
    elseif(x1(5,1)==9)
        op1=w3;
    else
           op1=0; 
    end
       
       
       if(x1(5,3)==1)
           op2=a;
       elseif(x1(5,3)==2)
           op2=bitcmp(a);
       elseif(x1(5,3)==3)
           op2=b;
       elseif(x1(5,3)==4)
           op2=bitcmp(b);
       elseif(x1(5,3)==5)
           op2=c;
       elseif(x1(5,3)==6)
           op2=bitcmp(c);
       elseif(x1(5,3)==7)
           op2=w1;
       elseif(x1(5,3)==8)
           op2=w2;
       elseif(x1(5,3)==9)
           op2=w3;
       else
           op2=0; 
       end
       
       if(x1(5,2)==1)
           p5=bitand(uint8(op1),uint8(op2));
       elseif(x1(5,2)==2)
           p5=bitor(uint8(op1),uint8(op2));
       elseif(x1(5,2)==3)
           p5=bitxor(uint8(op1),uint8(op2));
       elseif(x1(5,2)==4)
           if(op1==0 && op2==0)
               p5=1;
           else
               p5=0;
           end
       elseif(x1(5,2)==5)
           if(op1==0 && op2==0)
               p5=0;
           else
               p5=1;
           end    
       else 
           p5=0;
       end  
end

function p6=s2(a,b,c,w1,w2,w3,x1)
    if(x1(6,1)==1)
           op1=a;
    elseif(x1(6,1)==2)
          op1=bitcmp(a);
    elseif(x1(6,1)==3)
           op1=b;
    elseif(x1(6,1)==4)
          op1=bitcmp(b);
    elseif(x1(6,1)==5)
           op1=c;
    elseif(x1(6,1)==6)
           op1=bitcmp(c); 
    elseif(x1(6,1)==7)
        op1=w1;
    elseif(x1(6,1)==8)
        op1=w2;
    elseif(x1(6,1)==9)
        op1=w3;
    else
           op1=0; 
    end
       
       
       if(x1(6,3)==1)
           op2=a;
       elseif(x1(6,3)==2)
           op2=bitcmp(a);
       elseif(x1(6,3)==3)
           op2=b;
       elseif(x1(6,3)==4)
           op2=bitcmp(b);
       elseif(x1(6,3)==5)
           op2=c;
       elseif(x1(6,3)==6)
           op2=bitcmp(c);
       elseif(x1(6,3)==7)
           op2=w1;
       elseif(x1(6,3)==8)
           op2=w2;
       elseif(x1(6,3)==9)
           op2=w3;
       else
           op2=0; 
       end
       
       if(x1(6,2)==1)
           p6=bitand(uint8(op1),uint8(op2));
       elseif(x1(6,2)==2)
           p6=bitor(uint8(op1),uint8(op2));
       elseif(x1(6,2)==3)
           p6=bitxor(uint8(op1),uint8(op2));
       elseif(x1(6,2)==4)
           if(op1==0 && op2==0)
               p6=1;
           else
               p6=0;
           end
       elseif(x1(6,2)==5)
           if(op1==0 && op2==0)
               p6=0;
           else
               p6=1;
           end    
       else 
           p6=0;
       end  
          
end

function p7=f1(a,b,c,w1,w2,w3,w4,w5,w6,x1)
    if(x1(7,1)==1)
           op1=a;
    elseif(x1(7,1)==2)
          op1=bitcmp(a);
    elseif(x1(7,1)==3)
           op1=b;
    elseif(x1(7,1)==4)
          op1=bitcmp(b);
    elseif(x1(7,1)==5)
           op1=c;
    elseif(x1(7,1)==6)
           op1=bitcmp(c); 
    elseif(x1(7,1)==7)
        op1=w1;
    elseif(x1(7,1)==8)
        op1=w2;
    elseif(x1(7,1)==9)
        op1=w3;
    elseif(x1(7,1)==10)
        op1=w4;
    elseif(x1(7,1)==11)
        op1=w5;
    elseif(x1(7,1)==12)
        op1=w6;
    else
        op1=0; 
    end
       
       
       if(x1(7,3)==1)
           op2=a;
       elseif(x1(7,3)==2)
           op2=bitcmp(a);
       elseif(x1(7,3)==3)
           op2=b;
       elseif(x1(7,3)==4)
           op2=bitcmp(b);
       elseif(x1(7,3)==5)
           op2=c;
       elseif(x1(7,3)==6)
           op2=bitcmp(c);
       elseif(x1(7,3)==7)
           op2=w1;
       elseif(x1(7,3)==8)
           op2=w2;
       elseif(x1(7,3)==9)
           op2=w3;
       elseif(x1(7,3)==10)
           op2=w4;
       elseif(x1(7,3)==11)
           op2=w5;
       elseif(x1(7,3)==12)
           op2=w6;
       else
           op2=0; 
       end
       
       if(x1(7,2)==1)
           p7=bitand(uint8(op1),uint8(op2));
       elseif(x1(7,2)==2)
           p7=bitor(uint8(op1),uint8(op2));
       elseif(x1(7,2)==3)
           p7=bitxor(uint8(op1),uint8(op2));
       elseif(x1(7,2)==4)
           if(op1==0 && op2==0)
               p7=1;
           else
               p7=0;
           end
       elseif(x1(7,2)==5)
           if(op1==0 && op2==0)
               p7=0;
           else
               p7=1;
           end    
       else 
           p7=0;
       end      
end
end
