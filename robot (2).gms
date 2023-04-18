Set
    i 'directions' / Right, Forward, Left, Backward /
    t 'time'       / 1 * 10 /
    k 'x or y'     / x, y /;


Table lower(k,i) 'Lower jump bounds'
        Right    Forward    Left    Backward
    x     2        -2        -3        -2
    y    -2         3        -2        -4;
    
Table upper(k,i) 'Upper jump bounds'
        Right    Forward    Left    Backward
    x     3         2        -2         2
    y     2         4         2        -3;


Scalar x0   'Start x-position'   / 0 /;
Scalar y0   'Start y-position'   / 0 /;
Scalar xf   'Final x-position'   / 13 /;
Scalar yf   'Final y-position'   / 17 /;
Scalar M    'Big M constraint'   / 10 /;


Variable
    dx(t)  'Jump in x-direction each time step t'
    dy(t)  'Jump in y-direction each time step t'
    a(t)   'Absololute value x-helper'
    b(t)   'Absololute value y-helper'
    d(i,t) 'Direction binary variable'
    Q      'Cost';

Binary Variable d;


Equation
    cost             'define objective function'
    x_walk_sum       'Constraint so we end up at final x coordinate'
    y_walk_sum       'Constraint so we end up at final y coordinate'
    abs_x_pos(t)     'Helper variable constraint'
    abs_x_neg(t)     'Helper variable constraint'
    abs_y_pos(t)     'Helper variable constraint'
    abs_y_neg(t)     'Helper variable constraint'
    dx_lower(i,t)    'x-jump lower bound constraints'
    dx_upper(i,t)    'x-jump upper bound constraints'
    dy_upper(i,t)    'y-jump upper bound constraints'
    dy_lower(i,t)    'y-jump lower bound constraints'
    binary_sum(t)    'Exclusivity constraints for directions';
   
cost..                 Q =e= sum(t, a(t) + b(t));

x_walk_sum..           x0 + sum(t, dx(t)) =e= xf;

y_walk_sum..           y0 + sum(t, dy(t)) =e= yf;

abs_x_pos(t)..         a(t) =g= dx(t);

abs_x_neg(t)..         a(t) =g= -dx(t);

abs_y_pos(t)..         b(t) =g= dy(t);

abs_y_neg(t)..         b(t) =g= -dy(t);

dx_lower(i,t)..        dx(t) =g= lower("x",i) - M * (1 - d(i,t));

dx_upper(i,t)..        dx(t) =l= upper("x",i) + M * (1 - d(i,t));

dy_lower(i,t)..        dy(t) =g= lower("y",i) - M * (1 - d(i,t));

dy_upper(i,t)..        dy(t) =l= upper("y",i) + M * (1 - d(i,t));

binary_sum(t)..        sum(i, d(i,t)) =e= 1;

Model transport / all /;

Solve transport using mip minimize Q;