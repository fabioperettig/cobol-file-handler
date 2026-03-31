![COBOL](https://img.shields.io/badge/COBOL-005687?style=for-the-badge&logo=ibm&logoColor=white)
# COBOL Banking System 🏦

A new version of this banking application in COBOL, this time interacting with an external database.

## 📝 Description
The program simulates a bank balance processor. It takes client data from a .txt database, applying specifics financial rules.

````cobol
IF ACCOUNT-TYPE EQUAL 1 OR ACCOUNT-TYPE EQUAL 2
    IF ACCOUNT-TYPE EQUAL 1
        DISPLAY "APPLYING DEBENTURES"
        COMPUTE WRK-BALANCE = WRK-BALANCE * 1,05
        DISPLAY "APPLYING TAX OF 10%"
        COMPUTE WRK-BALANCE = WRK-BALANCE * 0,90
        MOVE WRK-BALANCE TO WRK-BALANCE-EDIT

    ELSE
        DISPLAY "APPLYING DEBENTURES"
        COMPUTE WRK-BALANCE = WRK-BALANCE * 1,10
        DISPLAY "APPLYING TAXES"
        COMPUTE WRK-BALANCE = WRK-BALANCE * 0,925

    END-IF
        MOVE WRK-BALANCE TO WRK-BALANCE-EDIT
    
ELSE
DISPLAY "WRONG INPUT"
END-IF.

DISPLAY "FINAL INFORMATIONS".
DISPLAY WRK-NAME.
DISPLAY "BALANCE: " WRK-BALANCE-EDIT.

PERFORM 0200-INPUT-PROCEDURE.
````
### Features:
- **Input Handling:** Captures names and numeric values using `ACCEPT`.
- **Financial Calculations:** 
  - **Personal Account (1):** Applies a 5% debenture bonus and a 10% tax.
  - **Business Account (2):** Applies a 10% debenture bonus and a 7.5% tax.
- **Data Editing:** Uses `PICTURE` masks to format raw numeric data into a human-readable currency format (e.g., `Z.ZZZ.ZZ9,99`).
- **Looping Logic:** Runs a process loop until the user chooses to exit (Option 9).

````cobol
DISPLAY "SELECT YOUR ACCOUNT TYPE OR PRESS '9' TO EXIT".
DISPLAY "(1-PERSONAL ACC | 2-BUSINESS ACC | 9-EXIT)".
ACCEPT ACCOUNT-TYPE.
DISPLAY "ENTER YOUR NAME:".
ACCEPT WRK-NAME.
DISPLAY "ENTER YOUR PAYMENT:".
ACCEPT WRK-BALANCE.
````


## 🛠️ Technical Details
- **Language:** COBOL
- **Key Verbs used:** `COMPUTE`, `MOVE`, `PERFORM`, `EVALUATE/IF`.
- **Formatting:** Configured to use commas as decimal points (`DECIMAL-POINT IS COMMA`).

## 🚀 How to run
If you have **GnuCOBOL** installed, you can compile and run it using:

```bash
cobc -x CLIENTS.COB
./CLIENTS
```

## 🧠 What I learned
- The importance of COBOL's Divisions **(IDENTIFICATION, ENVIRONMENT, DATA, PROCEDURE)**.

- How to handle strict numeric formatting with PICTURE clauses.

- The behavior of the DECIMAL-POINT IS COMMA clause and how it  affects arithmetic constants.

-----------

### Fabio Peretti Guimarães | APR 2026