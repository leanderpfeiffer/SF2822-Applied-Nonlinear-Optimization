$Title Optimization of final satellite Orbit
Parameters
    N
    mu
    r_0
    m_0
    m_dot
    t_f
    T
    c_1
    c_2
    c_3;
    
N = 100;
mu  = 1.327 * 10**20;
r_0 = 1.496*10**11;
m_0 = 4.53*10**3;
m_dot = 6.76 * 10**(-5);
t_f = 1.668*10**7;
T   = 3.77;
c_1 = T*r_0*r_0 / (mu*m_0);
c_2 = m_dot * mu**0.5 / (T * r_0**0.5);
c_3 = t_f * mu**0.5 / r_0**(3/2);
 
    
Set k index   / 0*100 /;
    
Variables
    x1(k) dimensionless radius
    x2(k) dimensionless radial velocity
    x3(k) dimensionless tangental velocity
    u(k)  angle of thrust
    z objective ;
    
Equations
    start_condition_x1
    start_condition_x2
    start_condition_x3
    end_condition_x2
    end_condition_x3

    transition_x1(k)
    transition_x2(k)
    transition_x3(k)
    
    objective;
    
start_condition_x1 .. x1("0") =e= 1;
start_condition_x2 .. x2("0") =e= 0;
start_condition_x3 .. x3("0") =e= 1;

end_condition_x2 .. x2("100") =e= 0;
end_condition_x3 .. x1("100")*x3("100")**2 =e= 1;

transition_x1(k) .. x1(k+1) =e= x1(k) + c_3**2/N * x2(k);
transition_x2(k) .. x2(k+1) =e= x2(k) + x3(k)**2/(N*x1(k)) - 1/(N*x1(k)**2) + sin(u(k))/(N/c_1-c_1*c_2*ord(k));
transition_x3(k) .. x3(k+1) =e= x3(k) + c_3**2*x2(k)*x3(k)/(N*x1(k)) + c_3*cos(u(k))/(N/c_1-c_1*c_2*ord(k));

objective .. z =e= x1("100");

Model orbit_optimization /all/ ;

Solve orbit_optimization using nlp max z ;

