import sys
import os
import re

def validate_script_argument():
    if len(sys.argv) != 2:
        print("Program očekuje jedan argument; putanju do kazala.")
        sys.exit(0)
    directory = sys.argv[1]
    if os.access(directory, os.F_OK) == False:
        print("'{}' putanja ne postoji.".format(directory))
        sys.exit(0)
    if os.path.isdir(directory) == False:
        print("'{}' je datoteka, a program očekuje kazalo.".format(directory))
        sys.exit(0)
    return directory

# main program
directory = validate_script_argument()
list_of_files = os.listdir(directory)
students_file = "studenti.txt"

try:
    list_of_files.remove(students_file)
except ValueError:
    print("'{}' datoteka ne postoji u '{}' kazalu.".format(students_file, directory))
    sys.exit(0)
    
with open(os.path.join(directory, students_file), encoding="utf-8") as students_file_in:
    # prepare all students jmbag -> surname, name
    students = {}
    for line in students_file_in:
        jmbag, surname, name = line.split( )
        if jmbag in students:
            print("Jmbag {} već je naveden u '{}' datoteci.".format(jmbag, students_file))
            sys.exit(0)
        students[jmbag] = ", ".join([surname, name])
    # make statistics about all labs
    all_labs_results = {}
    pattern = re.compile("^(Lab[0-9]+_g[0-9]+\.txt)$")
    for file in list_of_files:
        # skip if file does not match
        if pattern.match(file) == None: continue
        lab_number_full = file.split("_")[0]
        lab_number = lab_number_full[re.search("\d", lab_number_full).start():]
        lab_results = all_labs_results.get(lab_number, {})
        with open(os.path.join(directory, file), encoding="utf-8") as file_in:
            for line in file_in:
                jmbag, points = line.split( )
                if jmbag in lab_results:
                    raise RuntimeWarning("Student s jmbagom {} je već pristupio labosu {}.".format(jmbag, lab_number))
                lab_results[jmbag] = float(points)
        all_labs_results[lab_number] = lab_results       
    # print results
    lab_numbers_string = sorted(i for i in list(all_labs_results.keys()))
    lab_numbers_int = (int(i) for i in lab_numbers_string)
    longest_surname_name = len(max(students.values(), key=len)) + 2
    number_of_spaces = longest_surname_name - len("Prezime, Ime")
    print("JMBAG\t\tPrezime, Ime{}L{}".format(" " * number_of_spaces, "\tL".join(str(i) for i in lab_numbers_int)))
    for jmbag in sorted(students.keys()):
        surname_name = students[jmbag]
        results = []
        for lab_num in lab_numbers_string:
            results.append(all_labs_results[lab_num].get(jmbag, 0.0))
        number_of_spaces = longest_surname_name - len(surname_name)
        print("{}\t{}{}{}".format(jmbag, surname_name, " " * number_of_spaces, "\t".join(str(r) for r in results)))
