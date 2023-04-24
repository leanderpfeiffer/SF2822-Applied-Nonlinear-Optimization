sets
    t dimension     / 0*100 /;
    

scalar r0   ''   / 1.496e11 /;
scalar d1   ''   / /;
scalar d2   ''   / /;
scalar d3   ''   / /;
scalar h    ''   / /;
scalar p    ''   / /;
scalar Tmax ''   / 3.77 /;
scalar m0   ''   / 4.53e3 /;
scalar tf   ''   /1.668e7/;
scalar mdot ''   /6.76e-5/;
scalar mu   ''   /1.327e20/;
scalar mfuel   ''   //;


mfuel = 1*m0;
p = mdot/Tmax;
d1 = r0**2/mu;
d2 = tf*sqrt(r0)/sqrt(mu);
d3 = tf*sqrt(mu)/sqrt(r0**3);
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
    u(t)      variable4
    Thrust(t) variable6
    dm(t)   mass
    m(t)    ;
    

    
x1.lo(t) = 1;
u.lo(t) = -pi/2;
u.up(t) = pi/2;
dm.up(t) = mdot;
dm.lo(t) = 0;
m.lo(t) = 1;


equations
    objfun     objective function
    massfuel(t)       h
    mass(t)            mass
    thrusteq(t)        thrust
    cons1(t)           dx1
    cons2(t)           dx2
    cons3(t)           dx3
    cons4(t)           x1
    cons5(t)           x2
    cons6(t)           x3
    cons7              vr -> zero
    cons8              final condition
    initial1           initial value
    initial2           initial value
    initial3           initial value
    initial5           initial value;
    


objfun  .. z =e= x1("100");
massfuel(t)..    m(t) =g= m0 - mfuel;
mass(t+1) ..  m(t+1) =e= m(t) - dm(t)*tf*h;

thrusteq(t) .. Thrust(t) * p =e= dm(t);
cons4(t+1)  ..  x1(t+1) =e= dx1(t) + x1(t);
cons5(t+1)  ..  x2(t+1) =e= dx2(t) + x2(t);
cons6(t+1)   .. x3(t+1) =e= dx3(t) + x3(t);

cons1(t) .. dx1(t) =e= d3**2*x2(t)*h;
cons2(t) .. dx2(t) =e= ((x3(t)**2)/x1(t) - (1/x1(t)**2) + d1*Thrust(t)*sin(u(t))/(m(t)))*h;
cons3(t) .. dx3(t) =e= (-d3**2*x2(t)*x3(t)/x1(t) + d2*Thrust(t)*cos(u(t))/(m(t)))*h;


cons7   .. x2("100") =e= 0;
cons8   .. x3("100") =e= 1/sqrt(x1("100"));
initial1   .. x1("0") =e= 1;
initial2   .. x2("0") =e= 0;
initial3   .. x3("0") =e= 1;

initial5   .. m("0") =e= m0;


model advanced3 / all /;

solve advanced3 using nlp maximizing z;

display u.l z.l x1.l