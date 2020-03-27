﻿unit Neo;

interface
        
    type
        float_func = System.Func<real, real>;
  
    type
        neo_array = class
      
        private
            row_number: integer;
            column_number: integer;
            
        public
            value: array[,] of real;
      
        constructor (existing_arr:array[,] of real);
        // Deklaration einer Matrize durch Massiv:  
        // m := new Matrix(arr[,]);
            begin
             (row_number, column_number) := 
              (existing_arr.RowCount, existing_arr.ColCount);
             value := new Real[row_number, column_number];
             for var i:= 0 to row_number - 1 do
                 for var j:= 0 to column_number - 1 do 
                     value[i, j] := existing_arr[i, j];
            end;
                  
        constructor (existing_arr:array of real);
        // Deklaration einer Matrize durch Massiv:  
        // m := new Matrix(arr[]);
            begin
             (row_number, column_number) := (1, existing_arr.Length);
             value := new Real[row_number, column_number];
             for var i:= 0 to column_number - 1 do
                     value[0, i] := existing_arr[i];
            end;
          
        constructor (rows, columns:integer);
        // Deklaration einer Nullmatrize durch Zeilen- & Spaltenanzahl:  
        // m := new Matrix(7, 31);
            begin
             (row_number, column_number) := (rows, columns);
             value := new Real[row_number, column_number];
            end;  
        
        class function operator + (neo_array_a, neo_array_b:neo_array): neo_array;
        // Matrizenaddition:
        // neo_array_sum := neo_array_a + neo_array_b;
            begin
             if (neo_array_a.row_number, neo_array_a.column_number) <> (neo_array_b.row_number, neo_array_b.column_number) then
                    raise new Exception('Wrong array sizes');
             var return_neo_array := new Real[neo_array_a.row_number, neo_array_a.column_number];
             for var i:= 0 to return_neo_array.RowCount-1 do
                 for var j:= 0 to return_neo_array.ColCount-1 do
                     return_neo_array[i, j] := neo_array_a.value[i, j] + neo_array_b.value[i, j];
             Result := new neo_array(return_neo_array);    
            end;
        
        class function operator - (neo_array_a, neo_array_b:neo_array): neo_array;
        // Matrizensubtraktion:
        // neo_array_difference := neo_array_a - neo_array_b;
            begin
             if (neo_array_a.row_number, neo_array_a.column_number) <> (neo_array_b.row_number, neo_array_b.column_number) then
                    raise new Exception('Wrong array sizes');
             var return_neo_array := new Real[neo_array_a.row_number, neo_array_a.column_number];
             for var i:= 0 to return_neo_array.RowCount-1 do
                 for var j:= 0 to return_neo_array.ColCount-1 do
                     return_neo_array[i, j] := neo_array_a.value[i, j] - neo_array_b.value[i, j];
             Result := new neo_array(return_neo_array);
            end;       
        
        class function operator * (neo_array_a:neo_array; b:Real): neo_array;
        // Matrizenmultiplikation mit Zahlen:
        // neo_array_mult := neo_array_a * b;
            begin
             var return_neo_array := new Real[neo_array_a.row_number, neo_array_a.column_number];
             for var i:= 0 to neo_array_a.value.RowCount - 1 do
                 for var j:= 0 to neo_array_a.value.ColCount - 1 do
                     return_neo_array[i, j] :=  neo_array_a.value[i, j] * b;
             Result := new neo_array(return_neo_array);
            end;
        
        class function operator * (a:Real; neo_array_b:neo_array): neo_array;
        // Matrizenmultiplikation mit Zahlen:
        // neo_array_mult := a * neo_array_b;
            begin
             Result := neo_array_b * a;
            end;
        
        class function operator / (neo_array_a:neo_array; b:Real): neo_array;
        // Matrizendivision mit Zahlen:
        // neo_array_mult := neo_array_a / b;
            begin
             Result := neo_array_a * (1/b);
            end;
              
        class function operator * (neo_array_a, neo_array_b:neo_array): neo_array;
        // Matrizenmultiplikation:
        // neo_array_mult := neo_array_a * neo_array_b;
            begin
             if neo_array_a.column_number = neo_array_b.row_number then
                    raise new Exception('Wrong array sizes');
             var return_neo_array := new neo_array(neo_array_a.row_number, neo_array_b.column_number);
             for var i:= 0 to return_neo_array.row_number - 1 do
                 for var j:= 0 to return_neo_array.column_number - 1 do
                     for var k:= 0 to neo_array_a.column_number - 1 do
                         return_neo_array.value[i,j]+= neo_array_a.value[i, k] * neo_array_b.value[k, j];
             Result := return_neo_array;
            end;
            
        function sum(): real;
            begin
             var s := 0.0;
             for var i:= 0 to row_number - 1 do
                for var j:= 0 to column_number - 1 do
                    begin
                     s += value[i,j];
                    end;
             Result := s;
            end;
            
        function shapes(): array of integer;
          begin
           Result := Arr(row_number, column_number);
          end;
    end;
    
    
    function map(func: float_func; neo_array_a: neo_array): neo_array;
        
        
    function random_neo_array(rows, columns:integer): neo_array;
    function random_neo_array(rows, columns, max:integer): neo_array;
    function random_neo_array(rows, columns, min, max:integer): neo_array;
    
    
implementation

    function map(func: float_func; neo_array_a: neo_array): neo_array;
        begin
         var return_array := new Real[neo_array_a.row_number, neo_array_a.column_number];
         for var i:= 0 to neo_array_a.row_number - 1 do
            for var j:= 0 to neo_array_a.column_number - 1 do
                return_array[i,j] := func(neo_array_a.value[i,j]);
         Result:= new neo_array(return_array);
        end;
        
        
    function random_neo_array(rows, columns:integer): neo_array;
        begin
         var return_array := new Real[rows, columns];
         for var i:= 0 to rows - 1 do
             for var j:= 0 to columns - 1 do
                return_array[i,j] := Random;
         Result := new neo_array(return_array);   
        end;
    
    function random_neo_array(rows, columns, max:integer): neo_array;
        begin
         Result := map(x -> x + Random(max), random_neo_array(rows, columns));   
        end;
    
    function random_neo_array(rows, columns, min, max:integer): neo_array;
        begin
         Result := map(x -> x + Random(min, max), random_neo_array(rows, columns));   
        end;    
end.
