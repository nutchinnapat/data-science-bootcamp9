// split from date data to year, month, day
= SPLIT(D4," ")

// convert month by xlookup
= ArrayFormula(XLOOKUP(F4:F9,A4:A15,B4:B15,"MISSING"))

// convert TH year to EN year
= ArrayFormula(G4:G9-I2)

// merge year, month, day to EN date (format: YYYY-MM-DD)
= ArrayFormula(DATE(I4:I9,H4:H9,E4:E9))
