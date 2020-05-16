import sys

# terminate if number of args is != 3
if len(sys.argv) != 3:
    print('Program očekuje putanju ulazne i izlazne datotke.')
    sys.exit(0)

# creates matrix based on provided definition
def create_matrix(definition):
    matrix = {}
    data = definition.split('\n')
    rows, columns = (int(d) for d in data[0].split( ))
    for d in data[1:]:
        row, column, value = d.split( )
        matrix[int(row), int(column)] = float(value)
    return rows, columns, matrix

# performs multiplication based on provided dictionaries
def multiply(m1, m2):
    result = {}
    for row in range(1, rows_1 + 1):
        for column in range(1, columns_2 + 1):
            sum = 0.0
            for (c1, r2) in zip(range(1, columns_1 + 1), range(1, rows_2 + 1)):
                sum += m1.get((row, c1), 0) * m2.get((r2, column), 0)
            result[row, column] = sum
    return result

def print_result(m):
    for row in range(1, rows_1 + 1):
        for column in range(1, columns_2 + 1):
            print('{:10.5f}'.format(m[row, column]), end=' ')
        print()

def write_result(m):
    with open(sys.argv[2], 'w', encoding='utf-8') as dest:
        keys_list = list(m.keys())
        keys_list.sort()
        dest.write('{} {}\n'.format(rows_1, columns_2))
        for key in keys_list:
            value = m[key]
            if value != 0.0:
                dest.write('{} {} {}\n'.format(key[0], key[1], value))
    
# main program
with open(sys.argv[1], encoding='utf-8') as source:
    definitions = source.read().split('\n\n')
    
    try :
        # first matrix
        rows_1, columns_1, matrix_1 = create_matrix(definitions[0])
        # second matrix
        rows_2, columns_2, matrix_2 = create_matrix(definitions[1])
    except :
        print('Definicija matrica nije dobra')
        sys.exit(0)
        
    # validate multiplication
    if columns_1 != rows_2:
        print('Prva matrica:    {} x {}'.format(rows_1, columns_1))
        print('Druga matrica:   {} x {}'.format(rows_2, columns_2))
        print('Množenje nije moguće!')
        sys.exit(0)
        
    # perform multiplication
    result = multiply(matrix_1, matrix_2)
    
    # print results to STDOUT
    print_result(result)
    
    # write result to destination file
    write_result(result)    
