sets
    t dimension     / 0*50 /;
    

scalar r0   ''   / 149600000000 /;
scalar c1   ''   / /;
scalar c2   ''   / /;
scalar c3   ''   / 3.3207 /;
scalar h    ''   / 0.02 /;
scalar p    ''   / /;
scalar Tmax ''   / 3.77 /;
scalar m0   ''   / 4530 /;
scalar m    ''   //;
scalar tf   ''   /16680000/;
scalar mdot ''   /0.0000676/;
scalar mu   ''   /1.327e20/;
scalar mfuel   ''   //;


mfuel = 0.2*m0;
c1 = r0**2/mu/m0;
c2 = sqrt(mu)/sqrt(r0);
p = mdot/Tmax;


variables
    z    objective function value
    y(t)    decision variables
    dx1(t)    delta1
    dx2(t)    delta2
    dx3(t)    delta3
    x1(t)     variable1
    x2(t)     variable2
    x3(t)     variable3
    u(t)      variable4
    dm(t)     variable5
    Thrust(t) variable6
    mf(t)  fuel;
    
x1.lo(t) = 1;
u.lo(t) = -pi/2;
u.up(t) = pi/2;
dm.lo(t) = p*Tmax/2;
dm.up(t) = Tmax*p;
mf.lo(t) = 0;



equations
    objfun     objective function
    massfuel(t)            mass
    consfuel(t)
    thrusteq(t)        thrust
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
    initial3           initial value
    initial4           initial value;
    
massfuel(t+1) .. mf(t+1) =e= mf(t) - dm(t)*tf*h;
consfuel(t) .. mf(t) =g= 0;

thrusteq(t) .. Thrust(t) * p =e= dm(t);

objfun  .. z =e= x1("50");
cons1(t) .. dx1(t) =e= c3**2*x2(t)*h;
cons2(t) .. dx2(t) =e= ((x3(t)**2)/x1(t) - (1/x1(t)**2) + r0**2/mu * Thrust(t)/(m0-mfuel+mf(t))*sin(u(t)))*h;
cons3(t) .. dx3(t) =e= (-mu*tf**2/r0**3 * x2(t)*x3(t)/x1(t)+ tf*sqrt(r0)/sqrt(mu)*Thrust(t)/(m0-mfuel+mf(t))*cos(u(t)))*h;
cons4(t+1)  ..  x1(t+1) =e= dx1(t) + x1(t);
cons5(t+1)  ..  x2(t+1) =e= dx2(t) + x2(t);
cons6(t+1)   .. x3(t+1) =e= dx3(t) + x3(t);

cons7   .. x2("50") =e= 0;
cons8   .. x3("50") =e= 1/sqrt(x1("50"));
initial1   .. x1("0") =e= 1;
initial2   .. x2("0") =e= 0;
initial3   .. x3("0") =e= 1;
initial4   .. mf("0") =e= mfuel;

model project1 / all /;

solve project1 using nlp maximizing z;

display u.l z.l mf.l Thrust.l mfuel;