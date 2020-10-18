clear all
close all;
clc

% Initialize the Plan with input values
% Obstacle=-1,Target = 0,Robot=1,Space=1
X_max=10;
Y_max=10;
Plan=CreateScenario(X_max,Y_max);


% Generation of Map_plan2node
n=0;
for j=1:Y_max;
    for i=1:X_max
        n=n+1;
        Map_plan2node(i,j)=n;
    end
end


% Generation of NodeList
[NodeList] =IncidentList(Map_plan2node,Plan,X_max,Y_max);


% Generation of Nodes
[Nodes] = IncidentMatrix(Map_plan2node,Plan,X_max,Y_max);


% Identification of TargetNode and RootNode
[target_x,target_y]=find(Plan==-2);
TargetNode=Map_plan2node(target_x,target_y);

[root_x,root_y]=find(Plan==0);
RootNode=Map_plan2node(root_x,root_y);

%%%%%%%%%%%%  BreadthFirst Search & Depth First Search %%%%%%%%%%%%%%%%%%%%%%%%ù
Open=0;

% [Open,Nparcourus,Chemin]=RechercheEnProfondeur(NodeList, RootNode, TargetNode);
% AnimatePath(Chemin,Map_plan2node,'g');
% Open=0;
% [Open,Nparcourus,Chemin]=RechercheEnLArgeur(NodeList, RootNode, TargetNode);
% AnimatePath(Chemin,Map_plan2node,'r');
% Open=0;

%%%%%%%%%%%%%%%%%%%%%%%%% AStarEuc et AstarMan %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


CoutVariable; 

[exploredNodes,Chemin] = Astar(NodeList,Map_plan2node,RootNode,TargetNode);
AnimatePath(Chemin,Map_plan2node,'b');

[exploredNodes,Chemin] = AstarMan(NodeList,Map_plan2node,RootNode,TargetNode);
AnimatePath(Chemin,Map_plan2node,'m');

%%%%%%%%%%%%%%%%%%%%%%%%% Complexité en temps %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
tic;[Open,Nparcourus,Chemin]=RechercheEnLArgeur(NodeList, RootNode, TargetNode);T_Breadth=toc;
tic;[Open,Nparcourus,Chemin]=RechercheEnProfondeur(NodeList, RootNode, TargetNode);T_Depth=toc;
tic;[exploredNodes,Chemin] = Astar(NodeList,Map_plan2node,RootNode,TargetNode);T_Astar_Euc=toc;
tic;[exploredNodes,Chemin] = AstarMan(NodeList,Map_plan2node,RootNode,TargetNode);T_Astar_Man=toc;

%%%%%%%%%%%QUESTION09 : Complexité en espace%%%%%%%%%%%%%%%%%
load('tree1.mat');
load('tree2.mat');
Tree1=Matrix2List(tree1);
Tree2=Matrix2List(tree2); 
RootNode=1; 
TargetNode=36; 
T1paroourusB=0;
T1paroourusD=0;
T2paroourusB=0;
T2paroourusD=0;
tic;[Open,T1paroourusD,Chemin]=RechercheEnProfondeur(Tree1, RootNode, TargetNode);T1tempsDepth=toc;
tic;[Open,T2paroourusD,Chemin]=RechercheEnProfondeur(Tree2, RootNode, TargetNode);T2tempsDepth=toc;
tic;[Open,T1paroourusB,Chemin]=RechercheEnLArgeur(Tree1,RootNode,TargetNode);T1tempsBreadth=toc;
tic;[Open,T2paroourusB,Chemin]=RechercheEnLArgeur(Tree2,RootNode,TargetNode);T2tempsBreadth=toc;


