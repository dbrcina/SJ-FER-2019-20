import sys
import re
import urllib.request
import urllib.parse

if len(sys.argv) != 2:
    print("Program očekuje jedan argument; URL web stranice.")
    sys.exit(0)

web_page = urllib.request.urlopen(sys.argv[1])
web_page_string = web_page.read().decode("utf-8")
print("WEB STRANICA")
print(web_page_string)
print("-----------------------------------")

print("LINKOVI NA DRUGE STRANICE")
links = [link.replace('"', '') for link in re.findall('href=("[^"]+")', web_page_string)]
hosts = {}
for link in links:
    if "//" not in link: continue
    print(re.search("(http.*://)([^/]+)(.*)", link).group(2))
    host = urllib.parse.urlparse(link).netloc
    hosts[host] = hosts.get(host, 0) + 1
print("\n".join(links))
print("-----------------------------------")

print("HOSTOVI")
host_names = hosts.keys()
longest_name = len(max(host_names, key=len))
print("Host{}Broj pristupa".format(" " * longest_name))
for host, visited in sorted(hosts.items(), key=lambda tup: tup[1], reverse=True):
    add_spaces = longest_name - len(host) + 4
    print("{}{}{}".format(host, " " * add_spaces, visited))
print("-----------------------------------")
