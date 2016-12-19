#!/usr/bin/octave


# S: set
# k: k clusters
function [R,C] = kmeans(S, k)
	R = [];
	[S_rows, S_cols] = size(S);
	ITERATIONS = 10;
	COUNTER = 0;
	
	# Random Partition initialization
	C = randi([min(S(:))*2 max(S(:))/2], S_rows, k);
	
	while COUNTER < ITERATIONS
	
		# distance vector
		D = zeros(1,S_cols);
		
		# Assignment step
		index1 = 1;
		for i = S
			
			tmp = zeros(1,k);
			index2 = 1;
			
			# Calculate distances
			for j = C;
				tmp(1,index2++) = norm(i - j);
			end
			
			[_,I] = min(tmp(:));
			
			D(1, index1++) = I;
			clear tmp;
			
		end
		
		# Update step		
		for i = 1:S_rows
			
			for j = 1:k
				try
					C(i,j)  = mean(S(i,D==j));
				catch ME
					printf("No cluster.");
				end
			end
			
		end
		COUNTER ++;
		
	end

	R = [D];
	
end

# ==TEST== #

# row: feature
# col: observation
#S = [1,2,3,110,120; 1,2,3,110,120];

S = randi([1 100], 2, 60);
k = 3;
[R, C] = kmeans(S, k)


# ==PLOT== #

plot(S(1,R==1),S(2,R==1),'r.','MarkerSize',12)
hold on
plot(S(1,R==2),S(2,R==2),'b.','MarkerSize',12)
hold on
plot(S(1,R==3),S(2,R==3),'g.','MarkerSize',12)
hold on

plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)
print("MyPNG.png", "-dpng")




