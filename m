MIME-Version: 1.0
Date: Sun, 31 Oct 2010 00:31:11 +0800
Message-ID: <AANLkTinqo2AXeHMv-p261BJoTGT2Df=zm6uEu+7QYmaH@mail.gmail.com>
From: Kian Yang Liew <liewkianyang@gmail.com>
Content-Type: multipart/alternative; boundary=0016364d26cf6247b90493d81a4d
Subject: [Bridge] DHCP problem on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org
Cc: Liew Kian Yang <kianyang@agroup.com.my>

--0016364d26cf6247b90493d81a4d
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dear All,



I have a network with 500 vlan and I bind all these 500 vlan into 1 bridge
interface. Then I have run a dhcp server on this bridge interface to provid=
e
dhcp to all the computer in the vlan. It look find all the time, but
sometime, some of the computer on vlan will not able to get the ip from dhc=
p
server but after I remove the vlan and add back to the bridge it will work
again. The most serious case is sometime there will be a dhcp problem on
vlan 1 as well, and I need to reboot the server only can make the service
back to normal.



The setting is as below





Vconfig add eth1 2

Vconfig add eth1 3

.

.

.

.

.

.vconfig add eth1 500



Then ifconfig eth1.2 up =85. Ifconfig eth1.500 up

Then brctl addbr br1, brctl addif br1 eth1.2 =85=85. Brctl addif br1 eth1.5=
00



Does anyone have face this problem before? Your reply is highly appreciate.





Thank you.







Regards,

Kian Yang, Liew

--0016364d26cf6247b90493d81a4d
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<p class=3D"MsoNormal"><span lang=3D"EN-US">Dear All,</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">I have a network with 500 vlan =
and I bind
all these 500 vlan into 1 bridge interface. Then I have run a dhcp server o=
n
this bridge interface to provide dhcp to all the computer in the vlan. It l=
ook
find all the time, but sometime, some of the computer on vlan will not able=
 to
get the ip from dhcp server but after I remove the vlan and add back to the
bridge it will work again. The most serious case is sometime there will be =
a
dhcp problem on vlan 1 as well, and I need to reboot the server only can ma=
ke
the service back to normal.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">The setting is as below</span><=
/p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Vconfig add eth1 2</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Vconfig add eth1 3</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">.vconfig add eth1 500</span></p=
>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Then ifconfig eth1.2 up =85. If=
config
eth1.500 up</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Then brctl addbr br1, brctl add=
if br1
eth1.2 =85=85. Brctl addif br1 eth1.500</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Does anyone have face this prob=
lem before?
Your reply is highly appreciate.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Thank you.</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Regards,</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">Kian Yang, Liew</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

<p class=3D"MsoNormal"><span lang=3D"EN-US">=A0</span></p>

--0016364d26cf6247b90493d81a4d--
