# import socket
# import urllib.request
# import lxml.html as html


# hostname = socket.gethostname()
# local_ip = socket.gethostbyname(hostname)

# print(local_ip)
# '''
# #set up so it looks up layer number from VAMP site
# open VAMP
# 	look for layer number
# 	send number to this file

# 	x = number
# 	number = thenumber


# 192.168.10.145 (subject to change)
# 192.168.10.145/Job/Status   (have it scan from top to bottom to find layer number)
# itll be e.g. layer 1 of 200


# ip = socket.gethostbyname('google.com')
# print(ip)

#from bs4 import BeautifulSoup
#import requests
"""
page = requests.get("https://www.dataquest.io/blog/web-scraping-python-using-beautiful-soup/")
soup = BeautifulSoup(page.content, 'html.parser')

print(page.content)
"""
#print(soup.find_all(id="post-28252")) #find the ID of the layer in the printer html code

#url = 'https://www.google.com/'


# resp = urllib.request.urlopen(url)

# fragment = html.fromstring(resp.read())

# for info in fragment.find_class('info'):
#     print('"episodeNumber" = ', info.find('div').attrib['id'])
#     #print('"airdate" =', info.find_class('airdate')[0].text_content().strip())

numberiton = 99 #thenumber #the layer number that will be outputed to PRNTR.py