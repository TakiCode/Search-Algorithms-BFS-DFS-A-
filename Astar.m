function [NbNode,Chemin]=Astar(NodeList,map2d,RootNode,TargetNode)
%open=[];
closed=[];
parent=zeros(1,length(NodeList))
parent(RootNode)=RootNode
[target_x, target_y] = find(map2d==TargetNode)
[act_x, act_y] = find(map2d==RootNode)
%premiere valeur a juste l'heuristique
%open est la matrice (Node cout_total cout_du_chemin)
open =[RootNode norm([target_x-act_x target_y-act_y],2) 0]
closed=[]
while ~isempty(open)
%     if ~isempty(open)
%     chemin=msgbox('can not reach the target!!');
%     break;
%     end
    Node=open(1,:)
    open=open(2:end,:);
    closed(end+1,:) = Node;
    if isequal(Node(1),TargetNode)
        break;
    end
    for i=1:length(NodeList(Node(1)).Neigh)
      if  isempty(find(closed(:,1)==NodeList(Node(1)).Neigh(i)))
        % cout_du_chemin ajoute au cout du noeud parent le cout pour aller au nouveau noeud 
        cout_du_chemin = Node(3)+NodeList(Node(1)).K(i)
	% cout_total (f = cout_du_chemin + heuristique )
        [act_x, act_y] = find(map2d==NodeList(Node(1)).Neigh(i))
        cout_total = cout_du_chemin + norm([target_x-act_x target_y-act_y],2)
	% garder le numero de ligne (noeud) deja dans open 
       x = find(open(:,1)==NodeList(Node(1)).Neigh(i));
        if isempty(x)
          parent(NodeList(Node(1)).Neigh(i))=Node(1);
          open(end+1,:)=[NodeList(Node(1)).Neigh(i) cout_total cout_du_chemin]
        else
          if cout_du_chemin < open(x, 3)
            parent(NodeList(Node(1)).Neigh(i))=Node(1);
            open(x,2:3) = [cout_total cout_du_chemin]
          end
        end
      end
    end

    %trier les elements suivant f (colonne 2 ) et suivant g (colonne 3)
    %MATLAB SYNTAX
  
    open = sortrows(open, [2 -3]) 
end 


%%%%   recuperer le chemin %%%%%

debut=TargetNode;
chemin=[];
while debut~=RootNode
    chemin(end+1)=debut;
    debut=parent(debut)
end
chemin(end+1) = RootNode
Chemin=fliplr(chemin);

NbNode=length(chemin);
% Chemin=zeros(1,NbNode)
% for i=1:NbNode
%     Chemin(i)=closed(end);
%     closed=closed(1:end-1);
% end

end
