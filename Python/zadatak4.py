import sys
import re
import urllib.request

if len(sys.argv) != 2:
    print("Program očekuje jedan argument; URL web stranice.")
    sys.exit(0)

web_page = urllib.request.urlopen(sys.argv[1])
web_page_string = web_page.read().decode("utf8")
print("WEB STRANICA")
print(web_page_string)
print("-----------------------------------")

links = [link.replace('"', '') for link in re.findall('href=("[^"]+")', web_page_string)]
print("LINKOVI NA DRUGE STRANICE")
print("\n".join(links))
print("-----------------------------------")

hosts = {}
for link in links:
    search_result = re.search("//([^/]+)/", link)
    if search_result == None: continue
    host = search_result.group(1)
    counter = hosts.get(host, 0) + 1
    hosts[host] = counter

host_names = hosts.keys()
longest_name = len(max(host_names, key=len))
print("HOSTOVI")
print("Host{}Broj pristupa".format(" " * longest_name))
for host, visited in sorted(hosts.items(), key=lambda tup: tup[1], reverse=True):
    add_spaces = longest_name - len(host) + 4
    print("{}{}{}".format(host, " " * add_spaces, visited))
print("-----------------------------------")

emails = re.findall("\w+\.?\w*@\w+\.\w+", web_page_string)
print("EMAIL ADRESE")
if len(emails) == 0: print("Email adrese nisu pronađene")
else: print("\n".join(emails))
print("-----------------------------------")

number_of_img_links = len(re.findall("<img[\s]src=.+", web_page_string))
print("BROJ LINKOVA NA SLIKE")
print(number_of_img_links)
print("-----------------------------------")
