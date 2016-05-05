%[handles, market, optSoil, dataS, rotaionalPosition, region, district]= VarietySelection1();

loops = 5;

%site specific
resultVotes = cell(810*loops*2,21); %810 results each loop times number of selected winners varieties = 2
cont = 1;
for time=1:loops
    for market=1:5 %loop market
        for optSoil=1:3 %loop soil
            for dataS=1:3%data sown
                for rotaionalPosition=1:2 %rotational Position
                    for district=1:9 %district and region
                        if district == 1
                            dist = 'EastEngland';%east england
                            region = 'E';
                        elseif district == 2
                            dist = 'Midlands';%midlands
                            region = 'W';
                        elseif district == 3
                            dist = 'NorthEastEngland'; %northeast england
                            region = 'N';
                        elseif district == 4
                            dist = 'NorthWestEngland';%Nortwest england
                            region = 'N';
                        elseif district == 5
                            dist = 'SouthEngland'; %South england
                            region = 'E';
                        elseif district == 6
                            dist = 'SouthWestEngland';%South west england
                            region = 'W';
                        elseif district == 7
                            dist = 'NorthernIreland'; %northern ireland
                            region = 'N';
                        elseif district == 8
                            dist = 'EastScotland'; %east scotland
                            region = 'N';
                        elseif district == 9
                            dist = 'Wales'; %Wales
                            region = 'W';
                        end
                        
%                         if district == 2 %midlands %east and west regions are possible to be assigned
%                             for r=1:2
%                                 if r==1
%                                     region = 'E';
%                                 else                             
%                                     region = 'W';
%                                 end
%                             end
                        %else
                            %generate ag factors
                            if time == 10 %maximum 
                                resLodNoPgr =5;
                                resLodYesPgr =5;
                                yelRust =5;
                                septTric=5;
                                septNod=5;
                                oraWBlMi=5;
                                mildew=5;
                                fusEaBli=5;
                                eyespot=5;
                                broRust=5;
                                ripDays=5;
                                height=5;                              
                                                                
                            elseif time ==20 %minimum
                                resLodNoPgr =1;
                                resLodYesPgr =1;
                                yelRust =1;
                                septTric=1;
                                septNod=1;
                                oraWBlMi=1;
                                mildew=1;
                                fusEaBli=1;
                                eyespot=1;
                                broRust=1;
                                ripDays=1;
                                height=1;
                                
                            elseif time ==30 %avg 
                                resLodNoPgr =3;
                                resLodYesPgr =3;
                                yelRust =3;
                                septTric=3;
                                septNod=3;
                                oraWBlMi=3;
                                mildew=3;
                                fusEaBli=3;
                                eyespot=3;
                                broRust=3;
                                ripDays=3;
                                height=3;
                                                               
                            else
                                %random ag number generation 
                                r = randi([1 5],1,12);  
                                resLodNoPgr =r(1);
                                resLodYesPgr =r(2);
                                yelRust =r(3);
                                septTric=r(4);
                                septNod=r(5);
                                oraWBlMi=r(6);
                                mildew=r(7);
                                fusEaBli=r(8);
                                eyespot=r(9);
                                broRust=r(10);
                                ripDays=r(11);
                                height=r(12);
                                
                            end
                            
                            clear a;
                            
                            a = main2(market, optSoil, dataS, rotaionalPosition, region, dist, resLodNoPgr, resLodYesPgr, yelRust, septTric, septNod, oraWBlMi, mildew, fusEaBli, eyespot, broRust, ripDays, height);
                            
                            for c=1:2
                                
                                    resultVotes{cont,1} = market;
                                    resultVotes{cont,2} = optSoil;
                                    resultVotes{cont,3} = dataS;
                                    resultVotes{cont,4} = rotaionalPosition;
                                    resultVotes{cont,5} = region;
                                    resultVotes{cont,6} = dist;
                                    resultVotes{cont,7} = resLodNoPgr;
                                    resultVotes{cont,8} = resLodYesPgr;
                                    resultVotes{cont,9} = yelRust;
                                    resultVotes{cont,10} = septTric;
                                    resultVotes{cont,11} = septNod;
                                    resultVotes{cont,12} = oraWBlMi;
                                    resultVotes{cont,13} = mildew;
                                    resultVotes{cont,14} = fusEaBli;
                                    resultVotes{cont,15} = eyespot;
                                    resultVotes{cont,16} = broRust;
                                    resultVotes{cont,17} = ripDays;
                                    resultVotes{cont,18} = height;
                                    resultVotes{cont,19} = a{c,1};
                                    resultVotes{cont,20} = a{c,2};
                                    resultVotes{cont,21} = a{c,3};
                                    cont = cont +1;
                                                             
                            end                           
                                                
                    end
                end
            end
        end
    end
end



%%%%%%%%%%%%%% Ag factors


%[handles2, resLodNoPgr, resLodYesPgr, yelRust, septTric, septNod, oraWBlMi, mildew, fusEaBli, eyespot, broRust, ripDays, height] = VarietySelection2();




















