Message-ID: <423593E6.5060403@Karthaus.nl>
Date: Mon, 14 Mar 2005 14:38:46 +0100
From: Marius Karthaus <Marius@Karthaus.nl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------090102000403070306060502"
Subject: [Bridge] help setting up a linux bridge with spanning tree to allow
 multiple vlans accross multiple uplinks
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

--------------090102000403070306060502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

For easy reading: http://www.karthaus.nl/r/

Hi,

We used to have 1 single ip range (1.1.1.0/24) that had one uplink to a 
switch of the colocation provider.
Recently we got a second range 2.2.2.0/24 and a redundant uplink 
directly on two routers. But our switch does not have spanning tree 
protocol support so we cannot use them redundantly.
We have set up the switch to have a vlan for both networks like in this 
picture:

http://www.karthaus.nl/r/r1.gif

this way all hosts on the switch can use ips from either network.
However if one of the routers fails, one of the ranges fails. This 
happens quite a lot but this whould not be a problem if we had spanning 
tree that whould allow us to use both uplinks for both networks.
I would like to use a linux box to do this until we can get a switch 
that is capable of stp. I was thinking of something like this:
http://www.karthaus.nl/r/r2.gif

After reading the documentation on linux bridging and stp i'm convinced 
it's possible but i'm not at all sure exactly how to do this. The box 
that i want to use should probably have three NIC's, one for each 
routeruplink and one that connects to our switch. (see the picture). I'm 
guessing that i need to set up multiple bridges each containing a subset 
of the NIC eth0,eth1 and eth2. But this is where i'm confused.
Can anyone show me how to set this up please?

Regards,
M.Karthaus

--------------090102000403070306060502
Content-Type: multipart/related; boundary="----------=_1110807523-20674-648"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1110807523-20674-648
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
For easy reading: <a href="http://www.karthaus.nl/r/">http://www.karthaus.nl/r/</a><br>
<br>
Hi,<br>
<br>
We used to have 1 single ip range (1.1.1.0/24) that had one uplink to a
switch of the colocation provider.<br>
Recently we got a second range 2.2.2.0/24 and a redundant uplink
directly on two routers. But our switch does not have spanning tree
protocol support so we cannot use them redundantly. <br>
We have set up the switch to have a vlan for both networks like in this
picture:<br>
<br>
<img alt="http://www.karthaus.nl/r/r1.gif"
 DEFANGED_src="cid:part1.02040805.07060308@Karthaus.nl" height="327" width="420"><br>
<br>
this way all hosts on the switch can use ips from either network. <br>
However if one of the routers fails, one of the ranges fails. This
happens quite a lot but this whould not be a problem if we had spanning
tree that whould allow us to use both uplinks for both networks.
<br>
I would like to use a linux box to do this until we can get a
switch that is capable of stp. I was thinking of something like this:<br>
<img alt="http://www.karthaus.nl/r/r2.gif"
 DEFANGED_src="cid:part2.05080808.06060705@Karthaus.nl" height="396" width="428"><br>
<br>
After reading the documentation on linux bridging and stp i'm convinced
it's possible but i'm not at all sure exactly how to do this.
The box that i want to use should probably have three NIC's, one for
each routeruplink and one that connects to our switch. (see the
picture). I'm guessing that i need to set up multiple bridges each
containing a subset of the NIC eth0,eth1 and eth2. But this is where
i'm confused. <br>
Can anyone show me how to set this up please?<br>
<br>
Regards,<br>
M.Karthaus<br>
</body>
</html>

------------=_1110807523-20674-648
Content-Type: image/gif;
 name="r1.gif"
Content-Transfer-Encoding: base64
Content-ID: <part1.02040805.07060308@Karthaus.nl>
Content-Disposition: inline; filename="r1.gif"

R0lGODlhpAFHAcQAADw8PMzMzCUlJYWFhVFRUZSUlL+/v2NjY9nZ2aOjo3R0
dPPz8+bm5rGxsRAQEDAwMN/f3/f391hYWO/v76enpwgICFBQUJ+fn6+vr2Bg
YMfHx2hoaAAAAP///wAAAAAAACH5BAAAAAAALAAAAACkAUcBAAX/YCeOZGme
aKqubOu+cCzPdG3feK7vfO//wKBwSCwaj8ikcslsOp/QqHRKrVqv2Kx2y+16
v+CweEwum8/otHrNbrvf8Lh8Tq/b7/i8fs/v+/+AgYKDhIWGh4iJiouMjY6P
kJGSk1sPHJeYmZqbnJ2en6ChHA+UpSaWoqmqq6yYpDIcb7GmtB2zbbcwuWu7
tZK9acAswmfEvo3GZckoy2PNx4jPYdIk1F/W0IPYXdvbXN7Zf+Ba3bLhv+aw
6eeP41nlbu7sefJX8Ljz7eu6+/mK9VbusQHobw5BKgJ5FWR0cEpCNQ0Xxuvn
ImIUixIVTlS3MeMhjE8eBvMYjWILkE5Q/5JUZnJYy5V+VDIRiUYmzGkvVdhU
svOml55IaBbzqS1nCqBHpBk4oGJAARUHEKAYAABAAxIFBnRAQKDq1RIEpMqh
CoDpiQNVtZrg6vUEW7MjBIggC3dEAAI4kBoRauZZAAEAUiTgoPYshwAnFAAI
kEDA1w6LGQgYwNgxiQOH5Sg2EACtibIBDABQUEIy5caPRUgu0DmwiACBN7cu
AUDuDb1F+LJkMQCwaxMHBEx2W1UAYhMCxFKN22G5CMUjGtQ+DkeAgbjUO/wd
YcD2COcdoJNQgFeE8edPrWMfodh7DdxEdJNpRoABeBIISAMojDV99tfebdeB
AeWJFZ5rkv31X/8bBnZwHgnUdbcWe7+JsN8IF0ImVYMPSifhbUYxE+J3FX7G
H3ILFvCbgAokUMJfLnZAgH92eJZCWSnAWIJ6FqpVYgc2LpCcgDbAN4R8KwSg
ZBXS3GeiCg+SAJ6AADAAoQBmDVBelHIEtyCGP9qFJYoYapVAXUA+SIBWRL53
g5JfpjTDOAFwUBUBApDWAgMxAtFkmGVCuWBjYnbAQIXdmSVZA0oKkMACc3iJ
wqGADjgmck/1COR1I0jaQWNKggpiDXXemacLfAqBZI7eCelCACf28KcKGaLA
JYDcyVWAnp9y0CcCVVVlZ6ZwVAXpCX+hScJgfdJWGADpkWDsCCoGa2f/gxzR
QKSrLcCq6pw2bCuAlQkA0JWVBCB2l4yOHogjZFWN2sJ9/9W6wH9RIiAWtCIc
wBQBnCIgALFkxoHWsSPoa6GyAUAqMMGviVAugAwA2ykACL/oHg10tjrup+ZW
KaO6eOHpomLvBisvP6TaGSxph4pQAF6LaReYtwmUdwCNK68wZWaBzrVxlPF2
0ACWXUHqHQEcCCdceevBgUDTTp8XbwFUO22eVkxXjVedx1WlwHADqDV11Vy2
yXG4LottqGszQ6buzWbqzHOR4JJqHGx6nslczbBpp1VvxeG18douLNDgfwgg
fO+L+BnIQAExLkAsAnAqiW2ca2S+5FZS3ev5/2sOey5WdgYMIFYCVr42OuQ9
x6Ag3xLDJRfgdDfnmwCG57AqCkRaNSDUt88teHMKwCnV4XkTBUjHGF5F4N/G
eztA8po76HvzMxB59AIJhvfvU9B1NiDGQEabl/OBQC/C9+ErMP6B2jElGqQ7
a79+tjNwNZ5WBCKAWYA1I6YsQICf6opaoIa3FESAAhLQAPvIAAELXGACOrGB
/9gDQAIgcCvmKoABEZizDDHQTfzTSAkeKIEKXIJTEwwDBDBhQQyawEjfSiFE
SMBCF2YChjH8wgw1UcNqjOiG5uhhJ4AYxC4MkRNFxGEQfgcGDmzAh61gxSua
qAJUZJEVEpCin7inEP8MZMABnmAi4rh4lBw8cRMVkAAFIiDGH1DRBgVQ4xRJ
YEY0akKPOmSjEXHwxkvEcY4jkEnZKNO6+JAxCLxLygn6iAlAxqCOjqjHG+UY
ASQOYTLX49GRHvmDXYksNyrooyVZJsgTaJIDRRTRJ78TKzuS0gdV2tVeWmDD
2LVSBPWIQC/bOMt+NWuPgeyBxSSzy2b+sgQ9kQnvupIcVCaTB8HxYLsc6cxn
JlKSxTRapXhwxxkI4FgT46Y1vfnNbgLBO8xUJyuBkDMSVHOU7vRmNIkASqrw
KoeXHEIDgJhHeeKTncAEpxAWOYBVkvOWQ8nnM/fZkXmq0KD6VOhAINoXjbL/
k6L4uGZHJfpLkG5UpLtZJ0JNetEXYFJWHs0oSSMa0IoedKUxHQlK55PTkvaU
phbd4UwFyVKh1jSkKv3oT0d61JMmVaZP1WlTWwpQnA41pUGVKkYnulSsuvSI
20NoQq/K0506o6tcLKpWv2rTqiqVrGc1qxjU6lO4zpWjXnUrVLdaE7yWNap1
BSxQ2YpUvraSroOtCFj3J1bEMjWrfbVrDB2b15Ms1peBNexjCetUzbKRsn+F
bGKR2Vi0xnWqRvVsWk17V7niRLITBO1pRbtZvXIVttfw62xv+lbB1rYFfvyi
cIebCgewdrJHCC5xl8vcTBgXJi9liFgNEd1FVHe6/1C4biK0i90mcPcj3S3K
dL8b3iSQtxDnLS9unZde9aq2ie11r20zK189xLd99e3DfZ+XXz7sVxz93cN/
YxJg+2J3wAXG7GETjAcE+5fBd3CwgCFsBwkbmMJ0sDA9MJzhA3PYIB7+cBw0
3GARjzjEJm7rbVNc2N6ymKorfnFqXSzjyJa2xjPeK45/S98dh5bGPt6tjoPc
2hsT+cdDPnJux6tkJMe4yUs2MpSjbNUpUxnIViYHirP8jS1zWctM/nKXwyxm
MEu5zPbwMpqZpOY1O6TNbr4InOMckjnT2bt2vvMSSBxhPSMkz34OCqADvV6i
8HnHh65Domu8aBATOruDfv80b5MsaUGTudJ7jgEClJWRRr/YGoG7iadZnAwD
cMrUoc6KWgyAgKxgCxqjTnGpywOwwM0oAORpjlUKwDxfgPqEmEYhrRgQs8Ad
Z2Jls9A8QD3OYHN2KgXIis10LcDAJFtGy15BAjJFucBxpSuIoVxXjulsV7KA
UlYK3DnP15wFZlsFMYMMAwIHgOsgG2NqK7cnV+DB1wRmNFqSy7WBfYxlAEBf
N3MNAgwAnWs3u9zNWADCTqeuDkhcBK8uOAsSoIAWTduDA0C2u/VNzDOjoGjq
lpi1R05yc186Bf56TcnMNbZ2i4DgLbdFpHPO2CrzfL4L/vmknyx0H8T6skVH
LdH/k76Do6uY6WE1OdSj7vNge7G5WM+61rfO9a57fYscdrrUGSz2qlO47Fgm
+9QzKGK0UzrBbl+62tcuyw/HvccQvnvQ7U73uoe97y7nO+ChaWK9E7Xwgyd8
2+nQOCBaLgYFyFgMTJ2Cx4/AcgXt8OLnQBr+hPoFNaNBtLFtgs9vRYC1fDrc
6TAj22BONBiP/Va0k+6wcebV8xaL7i8v8QWEft7prlIArMSAFmVc9QW+O1XI
Mm25OWhNWFo+vPxJAtEM4ACksU27WlS27phpP1ZJ1tgaWWHE32Hd0ml+zdbN
L3pfhVtzGeDI7kIzm2+J+AkI9QE4BwfDb/j8I/A1rrF+/xZiPFATejcHGFfB
cQNwNDGTbFsCIa5xbX22eXZgG8U2gIhhG7jjfPoje0djISWjAE8BgeZBLaFG
geVngXUgP7gWGIsiKhxoPKAhP8uSLukHLx3Aa1aSbPzigtiXgql3YixYB1lh
ADHSAE5hAJCiFpFncU+Rf05hAglQNq1jAO+XKZSXOpCSFU9heZRXYkU4eP4n
hok3VoJ3hjo3hoBXhhWohm64gnBofnPIhn0Xh4qmhmj4d3qIh5pXh2l4hn7o
aIDIh4WIYYPIXnQoiCamXF73iJAYiZI4icP1XFw2apioh8LWWTCmiZaFfJXl
iS4Bik4miiuQiaRoiorXYjmmiv9sx4pr5YqvyImtKIuBR4uxaIu32ImjpYur
iIs25ot+x4s8Jox7SIyhaIxrCIvBqIyDxIy9qIyoCI3GOI3AKI1Ixw3OuIu1
GI3VmI1jto3PeI3F+I2pWGTieIzdWI7CaI3I6IvuuI7tCI5bkIjhFY+56Iz4
2IziuI/eOI/n+FrpqI75+I/wSI9mNpD+yI4HGZBVNJDtRI3JaI4SWYrY6JBX
1o8I+Q4QSZD8WJBrd3WQCHZDIJKPSJJCYJJfR3KypQMtSXVDJ2kv2XMxaUuF
VmYzqWBGd1w0iWk52UC+BVM3KWY/uYk1uZND+WVFuUbv5ZI86WZLqVtOmZRK
J5NPCZT/TQmTQEdoUelaPUlaWRlnXVmVNhmUD6VvY0lbQmmWTceSV2mUW7mW
YQmVb8mURymXd+lnaflscXmWbHlny2AAxGJ578OXYIkCgnl5xJIArKNYZJWY
IkCYCeBQ4xhsyzAlv/Ehn2iWmGkeCkAV5FdyqtWZDtJxD+eRj3aZK+Ia7WGY
Y+Qzq7mDeqKCopmXndkAeoKAs2iZvLEYoeIa19Fr3HiYJ0AVcJJOnUJuw/ma
TeGbjIEop7mMznaZvqEyzOGYnFmdRaNy2Dma2vkb5YJz+zadvWkXFSKc42mb
sfkc0Smd6mmeJfCZm0mesAmf1zmf7+lv/cJptdmXt5kptDmM/z5Znvp5n6PI
mbHZGItEme7pn7G5KEfDoPZYC4E5mAQzhOnZl5AJhZ/CUBKKVhsKhh3HoA1a
aXvZnXnZllSZZSeKn32pon9JZy16oHOJlSkKmHUplVpJnDxqlSvqmmVZo3Bp
ojnqlTqJly+Koz+Kokm6o8xJnzH6lU96o06amkVKlkgZpUeql1eqln4ppHY5
oEvqoj0apFQqll0KpFkKpjqKpmNKo2e6pTAKpWxqpDbapFJqpW96imnKpGXK
lX1KplOKp3J6Z474iJZIBIfqdYk6BIvadY3akZI6qZRaqZZ6qZiaqZq6qZza
qZ76qaAaqqI6qqRaqqZ6qqiaqqq6qh6s2qqu+qqwGquyOqu0Wqu2equ4mqu6
uqu82qvhEAIAOw==

------------=_1110807523-20674-648
Content-Type: image/gif;
 name="r2.gif"
Content-Transfer-Encoding: base64
Content-ID: <part2.05080808.06060705@Karthaus.nl>
Content-Disposition: inline; filename="r2.gif"

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
HdESPdEUXdEWfdEYndEavdEcLdAhAAA7

------------=_1110807523-20674-648--

--------------090102000403070306060502--
