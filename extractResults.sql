--Attribute,LHS gender,RHS gender,LHS value,RHS value,#LHS_LHS2RHS,#RHS_LHS2RHS,LHS2RHS,#LHS_LHS2RHS_T,#RHS_LHS2RHS_T,LHS2RHS_T,#LHS_LHS2Q,#Q_LHS2Q,LHS2Q,#LHS_LHS2Q_T,#Q_LHS2Q_T,LHS2Q_T,#P_P2RHS,#RHS_P2RHS,P2RHS,#P_P2RHS_T,#RHS_P2RHS_T,P2RHS_T,#LHS_POOL,#RHS_POOL
select * from category order by id;
select description from age order by age;
select * from results where category = ? order by g, gender1, gender2, feature1, feature2;
select * from resultsAge where category = ? and age1 = ? and age1 = age2 order by g, gender1, gender2, feature1, feature2;
