=IFERROR(QUERY(EMPLOYEES,
 "SELECT * 
 WHERE " 
  & IF(I6="All", "1=1",
      SWITCH(I6,
        "Less than", "E < " & J6,
        "Greater than", "E > " & J6,
        "Less than or Equal to", "E <= " & J6,
        "Greater than or Equal to", "E >= " & J6,
        "Between", "E >= " & J6 & " AND E <= " & K6)
    ) & " 
    AND " & IF(L6="All", "1=1", "F = '" & L6 & "'") & " 
    AND " & IF(M6="All", "1=1", "G = '" & M6 &"'")
    ),
  "Data Not Found"
)
