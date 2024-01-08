// ID
=ArrayFormula(REGEXEXTRACT(A4:A8,"\d-\d{4}-\d{5}-\d{2}-\d"))	

// Gender	
=ArrayFormula(REGEXEXTRACT(A4:A8,"M[a-z]+\."))	

// Firstname	
=ArrayFormula(REGEXEXTRACT(A4:A8,"M[a-z]+\. ([A-Z][a-z]+) [A-Z][a-z]+"))	

// Lastname	
=ArrayFormula(REGEXEXTRACT(A4:A8,"M[a-z]+\. [A-Z][a-z]+ ([A-Z][a-z]+)"))	

// DOB	
=ArrayFormula(REGEXEXTRACT(A4:A8,"Date of Birth (\d{2} [A-Z][a-z]+ \d{4})"))	

// Age	
=ArrayFormula(DATEDIF(F4:F8,TODAY(), ""Y"") & "" Years "" & DATEDIF(F4:F8,TODAY(), ""YM"") & "" Months "" & DATEDIF(F4:F8,TODAY(), ""YD"") & "" Days"")

// Address
=ArrayFormula(REGEXEXTRACT(A4:A8, "Address (\d+ [A-Za-z ]+)"))	

// Zipcode	
=ArrayFormula(REGEXEXTRACT(A4:A8, "Address \d+ [A-Za-z ]+(\d{5})"))

// Expired Date	
=ArrayFormula(REGEXEXTRACT(A4:A8, "Expired Date (\d{2} [A-Za-z]{3} \d{4})"))

// Expired This Year
=ArrayFormula(IF(RIGHT(J4:J8,4)-RIGHT(TODAY(),4)<=0, "EXPIRED", "AVAILABLE"))

// TODAY: Expired Already?	
=ArrayFormula(IFERROR(IF(DATEDIF(TODAY(), J4:J8, "D")>0,"AVAILABLE","Something Wrong"),"EXPIRED"))
