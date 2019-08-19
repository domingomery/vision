clt
N = 100;
x = (1:N)';
m = 4;
b = -2;
y = m*x+b+25*(rand(N,1)-0.5);
% outliers
y(10) = 490;
y(20) = 20;
y(50) = 90;
y(75) = N;
y(15) = 440;
y(25) = 120;
y(55) = 70;
y(85) = N/2;
y(5) = 340;
y(15) = 20;
y(60) = 60;
y(99) = N/3;
plot(x,y,'*')
mr = 0;
br = 0;
yr = mr*x+br;
our = Inf;
for k = 1:10000;
    k1 = fix(N*rand)+1;
    k2 = k1;
    while (k2==k1);
        k2 = fix(N*rand)+1;
    end
    x1 = x(k1);x2 = x(k2);
    y1 = y(k1);y2 = y(k2);
    ms = (y2-y1)/(x2-x1);
    bs = y2-ms*x2;
    ys = ms*x+bs;
    clf
    plot(x,y,'*')
    hold on
    plot(x,ys,'k')
    plot([x1 x2],[y1 y2],'ro')
    e = (abs(y-ys));
    ii = find(e>15);
    o  = length(ii);
    plot(x,yr,'r')
    axis([0 N 0 500])
    if (o<our)
        mr = ms;
        br = bs;
        yr = ys;
        our = o;
        fprintf('mr=%7.2f br=%7.2f, m=%7.2f b=%7.2f, e=%7.2f o=%d',mr,br,m,b,mean(e),our)
        enterpause
    else
        drawnow
    end

end
clf
plot(x,y,'*')
hold on
plot(x,yr,'r')
