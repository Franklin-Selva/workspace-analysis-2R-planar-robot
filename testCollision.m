function testCollision(l1, l2, th1, th2, x0, y0, radius)
    
    % Evaluation of collision for link 1 and link 2
    
    x1 = l1*cos(th1);
    y1 = l1*sin(th1);
    
    x2 = l1*cos(th1) + l2*cos(th1 + th2);
    y2 = l1*sin(th1) + l2*sin(th1 + th2);
    
    %Check for collision with link 1 and link 2
    
    % Shortest distance between circle to a point
    if (sqrt(x0^2 + y0^2) - radius) < 0
       disp("ERROR: Always in collision with link 1");
       
   % Shortest distance between circle to a point
    elseif l1 + l2 < sqrt(x0^2 + y0^2) - radius
        disp("SUCCESS: Both link 1 and 2 will never be collided")
     
    %Check collisions for individual links
    elseif sqrt((x1 - x0)^2 + (y1 - y0)^2) - radius <= 0
        disp("ERROR: Both Link 1 and link 2 will be collided")
        [thMin, thMax] = testJoint(x0, y0, th1);
    
    else
        col = 0;
        thMin = 0.;
        thMax= 0.;
        %Check for collision with link 1
%         dCP1 = sqrt((x1 - x0)^2 + (y1 - y0)^2);
        %Perpendicular distance to circle and line
        x12 = x1 - 0; y12 = y1 - 0; % Since one point is origin
        Nx = x12 / norm(x12); Ny = y12 / norm(y12);
        xc1 = x0 - 0; yc1 = y0 - 0;
        v = abs(Nx * xc1 - Ny * yc1);
        if v  > radius
            disp("SUCCESS: Link 1 will not be collided")
            
        else
            % disp("ERROR: Link 1 will be collided")
            [thMin, thMax] = testJoint(x0, y0, th1);
            col = 1;
        end 
        
        %Check for collision with link 2       
%         dCP2 = sqrt((x2 - x0)^2 + (y2 - y0)^2);
        %Perpendicular distance to circle and line
        x21 = x2 - x1; y21 = y2 - y1;
        Nx = x21 / norm(x21); Ny = y21 / norm(y21);
        xc1 = x0 - x1; yc1 = y0 - y1;
        v = abs(Nx * xc1 - Ny * yc1);
        
        % Shortest distance between circle to a point
        if v > radius
            disp("SUCCESS: Link 2 will not be collided")
            
        else
            % disp("ERROR: Link 2 will be collided")
            col = col + 2;
        end
        
        if col  == 3
            disp("ERROR: Both Link 1 and Link 2 will be collided")
            [thMin, thMax] = testJoint(x0, y0, th1);
        elseif col == 2
            disp("ERROR: Link 2 will be collided")
        elseif col == 1
            disp("ERROR: Link 1 will be collided")
        end
        
        if thMin ~= 0. && thMax ~= 0.
            str = ["The joint limits for link 1: (", num2str(thMin), ",", num2str(thMax), ")"];
            disp(str);
        end
    end
end

function [thMin, thMax] = testJoint(x0, y0, th1)
    % Returns joint limits for link 1 if there is a collision
    beta = atan2(y0, x0);
    delta = 2*abs(alpha - th1);
    
    if beta == min(beta, th1)
	thMin = beta - (delta/2)
	thMax = th1
    else
	thMin = th1
	thMax = (delta/2) + beta
end
