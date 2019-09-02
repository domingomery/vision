close all
clear all

a = 4;


sa=sprintf('PanAzucar%d.bmp',a);
Ioa = imread(sa);

ag = mean(Ioa(:));
for b=[5 3 6 2 7 1]
    sb=sprintf('PanAzucar%d.bmp',b);
    Iob = imread(sb);
    bg = mean(Iob(:));
    
    figure(1)
    clf
    imshow(Ioa)
    hold on
    figure(2)
    clf
    imshow(Iob)
    hold on
    drawnow
    disp('searching SIFT points...');
    Ia = single(Ioa) ;
    Ib = single(Iob) ;
    [fa, da] = vl_sift(Ia) ;
    [fb, db] = vl_sift(Ib) ;
    
    disp('searching macthing points...');
    [matches, scores] = vl_ubcmatch(da, db) ;
    [ii,jj] = sort(scores);
    matches = matches(:,jj);
    scores = scores(:,jj);
    
    figure(1)
    n = min([80 size(matches,2)]);
    fprintf('%d puntos mas semejantes\n',n')
    for i=1:n
        plot(fa(1,matches(1,i)),fa(2,matches(1,i)),'*')
        text(fa(1,matches(1,i)),fa(2,matches(1,i)),num2str(i))
    end
    figure(2)
    for i=1:n
        plot(fb(1,matches(2,i)),fb(2,matches(2,i)),'*')
        text(fb(1,matches(2,i)),fb(2,matches(2,i)),num2str(i))
    end
    
    
    disp('computing homography...');
    
    x   = fa(2,matches(1,1:n))';
    y   = fa(1,matches(1,1:n))';
    
    x_p = fb(2,matches(2,1:n))';
    y_p = fb(1,matches(2,1:n))';
    
    np = 8;
    A = zeros(2*np,8);
    bb = zeros(2*np,1);
    
    disp('computing RANSAC...');
    
    our = n;
    for k=1:20000
        qq = rand(n,1);
        [ii,jj] = sort(qq);
        
        for p=1:np
            i = jj(p);
            j = p*2-1;
            A(j:j+1,:) = [x(i) y(i) 1 0 0 0 -x(i)*x_p(i) -y(i)*x_p(i); 0 0 0 x(i) y(i) 1 -x(i)*y_p(i) -y(i)*y_p(i)];
            bb(j:j+1,:) = [x_p(i);y_p(i)];
            
        end
        
        %h = A\bb;
        %H =[h(1) h(2) h(3); h(4) h(5)  h(6);h(7) h(8) 1];
        [U,S,V] = svd([A -bb]);
        h = V(:,end);
        H =[h(1) h(2) h(3); h(4) h(5)  h(6);h(7) h(8) h(9)];
        
        m_p = [x_p';y_p';ones(1,n)];
        m   = [x'  ;y'  ;ones(1,n)];
        
        m_ps = H*m; m_ps = m_ps./(ones(3,1)*m_ps(3,:));
        ms = H\m_p; ms = ms./(ones(3,1)*ms(3,:));
        
        d1 = m_ps(1:2,:)'-m_p(1:2,:)';
        d2 = ms(1:2,:)'-m(1:2,:)';
        dm = sqrt(sum(d1.*d1,2))+sqrt(sum(d2.*d2,2));
        ii = find(dm>2);
        o = length(ii);
        if (o<our)
            our=o;
            Hmin = H;
        end
        
    end
    
    [Nb,Mb] = size(Ib);
    [Na,Ma] = size(Ia);
    
    mb = [1 Nb 1 Nb
          1 1 Mb Mb
          1 1 1 1];
    
    mp = H\mb; mp = mp./(ones(3,1)*mp(3,:));
    
    
    ma = [1 Na 1 Na
          1 1 Ma Ma
          1 1 1 1];
    
    mc = [mp ma];
    
    Mc = round(max(mc(2,:))-min(mc(2,:)));
    Nc = round(max(mc(1,:))-min(mc(1,:)));
    
    t = min(mc(2,:));
    q = min(mc(1,:));
    Ht = [1 0 q;0 1 t; 0 0 1];
    Hn = H*Ht;
    
    Ja = projective2D(Iob+(ag-bg),Hn,[Nc Mc],0);
    Jb = projective2D(Ioa,Ht,[Nc Mc],0);
    J = Ja+Jb;
    Ka = Ja>0;
    Kb = Jb>0;
    Da = bwdist(not(Ka));
    Db = bwdist(not(Kb));
    Dc = Da+Db;
    ii = find(and(Ka,Kb)==1);
    J(ii) = (Ja(ii).*Da(ii)+Jb(ii).*Db(ii))./Dc(ii);
    ag = mean(J(or(Ka,Kb)));
    Ioa = uint8(round(J));
    
    figure(3)
    imshow(Ioa)
    enterpause
end



