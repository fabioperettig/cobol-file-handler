       IDENTIFICATION                  DIVISION.
       PROGRAM-ID.                     CLIENTS.
       ENVIRONMENT                     DIVISION.
       CONFIGURATION                   SECTION.
       
       DATA                            DIVISION.
       
       WORKING-STORAGE                 SECTION.

       01 INPUTMENU                    PICTURE 9(01).

       01 REGISTER.
           03 REG-AGENCY               PICTURE X(04).
           03 REG-ACCOUNT             PICTURE X(05).
           03 REG-NAME                PICTURE X(30).
           03 REG-MANAGER             PICTURE X(03).
           03 REG-ACCTYPE              PICTURE 9(01).
           03 REG-BALANCE             PICTURE 9(10)V99.
       
       PROCEDURE                       DIVISION.

       0100-MAIN-PROCEDURE             SECTION.

       PERFORM 0200-INPUT-PROCEDURE UNTIL INPUTMENU EQUAL 9.
       PERFORM 0300-PROCESS-PROCEDURE.

       STOP RUN.
       0100-END.                       EXIT.

       0200-INPUT-PROCEDURE            SECTION.
           DISPLAY "SELECT YOUR SERVICE TYPE OR PRESS '9' TO EXIT".
           ACCEPT INPUTMENU.

           DISPLAY "---------------------------------------------".

       0200-END.                       EXIT.
       
       0300-PROCESS-PROCEDURE          SECTION.

       0300-END.                       EXIT.