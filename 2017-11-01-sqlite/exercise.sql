sqlite> SELECT AVG(salary) as avg_salary, dept FROM employees GROUP BY dept;

avg_salary        dept
----------------  ----------
41666.6666666667  Accounting
37000.0           Sales

sqlite> SELECT * FROM employees JOIN (SELECT AVG(salary) as avg_salary, dept FROM employees GROUP BY dept);;

name        email              salary      dept        avg_salary        dept
----------  -----------------  ----------  ----------  ----------------  ----------
Alice       alice@company.com  52000.0     Accounting  41666.6666666667  Accounting
Alice       alice@company.com  52000.0     Accounting  37000.0           Sales
Bob         bob@company.com    40000.0     Accounting  41666.6666666667  Accounting
Bob         bob@company.com    40000.0     Accounting  37000.0           Sales
Carol       carol@company.com  30000.0     Sales       41666.6666666667  Accounting
Carol       carol@company.com  30000.0     Sales       37000.0           Sales
Dave        dave@company.com   33000.0     Accounting  41666.6666666667  Accounting
Dave        dave@company.com   33000.0     Accounting  37000.0           Sales
Eve         eve@company.com    44000.0     Sales       41666.6666666667  Accounting
Eve         eve@company.com    44000.0     Sales       37000.0           Sales
Frank       frank@comany.com   37000.0     Sales       41666.6666666667  Accounting
Frank       frank@comany.com   37000.0     Sales       37000.0           Sales

sqlite> SELECT * FROM employees NATURAL LEFT JOIN (SELECT AVG(salary) as avg_salary, dept FROM employees GROUP BY dept);

name        email              salary      dept        avg_salary
----------  -----------------  ----------  ----------  ----------------
Alice       alice@company.com  52000.0     Accounting  41666.6666666667
Bob         bob@company.com    40000.0     Accounting  41666.6666666667
Carol       carol@company.com  30000.0     Sales       37000.0
Dave        dave@company.com   33000.0     Accounting  41666.6666666667Eve         eve@company.com    44000.0     Sales       37000.0
Frank       frank@comany.com   37000.0     Sales       37000.0

sqlite> SELECT *, abv_avg = salary - avg_salary FROM employees NATURAL LEFT JOIN (SELECT AVG(salary) as avg_salary, deptFROM employees GROUP BY dept);
Error: no such column: abv_avg

sqlite> SELECT *, salary - avg_salary AS abv_avg FROM employees NATURAL LEFT JOIN (SELECT AVG(salary) as avg_salary, dept FROM employees GROUP BY dept);

name        email              salary      dept        avg_salary        abv_avg
----------  -----------------  ----------  ----------  ----------------  ----------------
Alice       alice@company.com  52000.0     Accounting  41666.6666666667  10333.3333333333
Bob         bob@company.com    40000.0     Accounting  41666.6666666667  -1666.6666666666
Carol       carol@company.com  30000.0     Sales       37000.0           -7000.0
Dave        dave@company.com   33000.0     Accounting  41666.6666666667  -8666.6666666666
Eve         eve@company.com    44000.0     Sales       37000.0           7000.0
Frank       frank@comany.com   37000.0     Sales       37000.0           0.0
