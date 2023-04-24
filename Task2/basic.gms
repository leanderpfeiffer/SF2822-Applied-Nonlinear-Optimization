sets
    t dimension     / 0*100 /;
    
scalar r0   ''   / 1.496e11 /;
scalar c1   ''   / /;
scalar c2   ''   / /;
scalar c3   ''   / /;
scalar h    ''   /  /;
scalar p    ''   / /;
scalar Tmax ''   / 3.77 /;
scalar m0   ''   / 4.53e3 /;
scalar tf   ''   /1.668e7/;
scalar mdot ''   /6.76e-5/;
scalar mu   ''   /1.327e20/;
scalar mfuel   ''   //;

c1 = Tmax*r0**2/mu/m0;
c2 = mdot*sqrt(mu)/Tmax/sqrt(r0);
c3 = tf*sqrt(mu)/sqrt(r0**3);
h = 1/100;


variables
    z    objective function value
    y(t)    decision variables
    dx1(t)    delta1
    dx2(t)    delta2
    dx3(t)    delta3
    x1(t)     variable1
    x2(t)     variable2
    x3(t)     variable3
    u(t)      variable4;
    
x1.lo(t) = 1;
u.lo(t) = -pi/2;
u.up(t) = pi/2;



equations
    objfun     objective function
    cons1(t)           dx1
    cons2(t)           dx2
    cons3(t)           dx3
    cons4(t)           x1
    cons5(t)           x2
    cons6(t)           x3
    cons7           vr -> zero
    cons8              final condition
    initial1           initial value
    initial2           initial value
    initial3           initial value;

objfun  .. z =e= x1("100");
cons1(t) .. dx1(t) =e= c3**2*x2(t)*h;
cons2(t) .. dx2(t) =e= ((x3(t)**2)/x1(t) - (1/x1(t)**2) + sin(u(t))/(1/c1 - c2*c3*(ord(t)-1)*h))*h;
cons3(t) .. dx3(t) =e= (-c3**2*x2(t)*x3(t)/x1(t) + c3*cos(u(t))/(1/c1 - c2*c3*(ord(t)-1)*h))*h;
cons4(t+1)  ..  x1(t+1) =e= dx1(t) + x1(t);
cons5(t+1)  ..  x2(t+1) =e= dx2(t) + x2(t);
cons6(t+1)   .. x3(t+1) =e= dx3(t) + x3(t);

cons7   .. x2("100") =e= 0;
cons8   .. x3("100") =e= 1/sqrt(x1("100"));
initial1   .. x1("0") =e= 1;
initial2   .. x2("0") =e= 0;
initial3   .. x3("0") =e= 1;


model basic / all /;

solve basic using nlp maximizing z;

display u.l z.l x1.l 