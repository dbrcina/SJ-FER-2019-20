import sys
import os

def validate_script_argument():
    if len(sys.argv) != 2:
        print("Program očekuje jedan argument; putanju do datoteke.")
        sys.exit(0)
    file = sys.argv[1]
    if os.access(file, os.F_OK) == False:
        print("'{}' putanja ne postoji.".format(file))
        sys.exit(0)
    if os.path.isdir(file):
        print("'{}' je direktorij, a program očekuje datoteku.".format(file))
        sys.exit(0)
    if os.access(file, os.R_OK) == False:
        print("'{}' nije čitljiva.".format(file))
        sys.exit(0)
    return file

def parse_hypothesis(text):
    return list(float(v) for v in text.split( ))

# main program
file = validate_script_argument()
with open(file, encoding="utf-8") as file_in:
    lines = file_in.readlines()
    max_number_zeroes = len(str(len(lines)))
    print("Hyp#Q10#Q20#Q30#Q40#Q50#Q60#Q70#Q80#Q90")
    counter = 1
    for line in lines:
        data = parse_hypothesis(line)
        sorted_data = sorted(data)
        data_size = len(data)
        results = []
        for q in (0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9):
            results.append(sorted_data[int(q * (data_size) - 1)])
        results = [str(r) for r in results]
        string_counter = str(counter)
        add_zeroes = max_number_zeroes - len(string_counter)
        hypothesis_number = "0" * add_zeroes + string_counter
        print("{}#{}".format(hypothesis_number, "#".join(results)))
        counter += 1
