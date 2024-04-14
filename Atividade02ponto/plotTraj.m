function plotTraj(fignum,poseR_list,color)

x = poseR_list.Data(:,1);
y = poseR_list.Data(:,2);
phi = poseR_list.Data(:,3);

persistent ax;

if isempty(ax) || ~isvalid(ax) || isempty(figure(fignum).CurrentAxes)
    ax = figure(fignum).CurrentAxes;
    if isempty(ax)
        ax = axes(figure(fignum));
    end
    
    axis(ax,'equal'); grid(ax,'on'); hold(ax,'on');
    title(ax,'Trajetória',FontName='Times');
    xlabel(ax,'$x(m)$',Interpreter='latex');
    ylabel(ax,'$y(m)$',Interpreter='latex');
end

plot(ax,x,y,'--',Color=color);
plot(ax,x(end),y(end),'ko',MarkerFaceColor='k');

r = polyshape([-0.05 -0.05 0.1],[-0.05 0.05 0]);
L = length(x);

for i = 1:floor(L/10):L
    if(i < ceil(3*L/5))
        r1 = translate(rotate(r,(180/pi)*phi(i)),[x(i), y(i)]);
        plot(ax,r1,FaceColor=color);
    end
end


