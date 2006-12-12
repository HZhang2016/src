eq1=(x-x2)^2+(z-z2)^2==R2^2;
eq2=(x2-x)(x3-x1)+(z2-z)(z3-z1)==R2 (R3-R1);

!definitions for various graphical objects
!circle with disk
c[x_,z_,r_,a_]:= Graphics[{Circle[{x,z},r], Disk[{x,z},0.2], \
Text[a,{x+0.5,z+0.5}]}];
!point
p[x_,z_,a_]:= Graphics[{Disk[{x,z},0.2], Text[a,{x+0.5,z+0.5}]}]; 
q[x_,z_,a_]:= Graphics[{Disk[{x,z},0.2], Text[a,{x-0.5,z-0.5}]}];

$TextStyle = {FontFamily->"Helvetica", FontWeight->Bold, FontSize->14};
!line
ln[x_,x1_,z1_,x2_,z2_]:=x (z1-z2)/(x1-x2) + (z2 x1 - z1 x2)/(x1-x2);

!line connecting A with C
cline = Plot[ln[x,1, 1, 6, 0],{x,1,6}, PlotStyle->Dashing[{0.05,0.05}]];

!solve for z=f(x) - draw eq2
Solve[eq2,z];
sline = z/.%[[1]];
sline/.{R1->1,R2->2,R3->3,x1->1,x2->3,x3->6,z1->1,z2->-1,z3->0};
eline = Plot[%,{x,1,3.5}, PlotStyle->AbsoluteThickness[1]];

!solve system
Solve[{eq1,eq2},{x,z}];
sol = FullSimplify[%];
spoint = sol/.{R1->1,R2->2,R3->3,x1->1,x2->3,x3->6,z1->1,z2->-1,z3->0};

!plot D and E - solutions of the system
dpoint=q[x,z,"D"]/.spoint[[1]];
epoint=q[x,z,"E"]/.spoint[[2]];

!plot OD and OE
odline = Plot[ln[x1, 5, 4, x, z],{x1,5,x}, \
PlotStyle->AbsoluteThickness[2]]/.spoint[[1]];
oeline = Plot[ln[x1, 5, 4, x, z],{x1,5,x}, \
PlotStyle->AbsoluteThickness[2]]/.spoint[[2]];

!tangents
{z1 == a x1 + b, 
 z2 == a x2 + b, 
(z1 - cz1)^2 == r1^2 - (x1-cx1)^2,
(z2 - cz2)^2 == r2^2 - (x2-cx2)^2,
(x1 - cx1) (x1-x2) + (z1 - cz1) (z1 - z2) == 0,
(x2 - cx2) (x1-x2) + (z2 - cz2) (z1 - z2) == 0
};
%/.{cx1->1,cx2->6,cz1->1,cz2->0,r1->1,r2->3};
stang = NSolve[%];
ctang = Plot[(a x + b)/.stang[[2]], {x,-1,8}, \
PlotStyle->Dashing[{0.05,0.05}]];
a x+c == z/.stang[[2]];
%/.spoint[[1]];
Solve[%,c];
tang = Plot[(a x + c)/.stang[[2]]/.%[[1]], {x,-1,8}];

opoint=p[5,4,"O"];
apoint=c[1,1,1,"A"];
bpoint=c[3,-1,2,"B"];
cpoint=c[6,0,3,"C"];

Show[ opoint, apoint, bpoint, cpoint, dpoint, epoint, 
cline, eline, 
odline, oeline,
ctang, tang, AspectRatio->Automatic];

Display["junk_ma.eps",%,"EPS"];
