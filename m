Date: 22 Jun 2008 14:05:30 -0000
Message-ID: <20080622140530.2091.qmail@f4mail-235-239.rediffmail.com>
MIME-Version: 1.0
From: "Sibu Thomas Mathew" <sibumatrix@rediffmail.com>
Content-type: multipart/alternative;
	boundary="Next_1214143530---0-202.137.235.239-2088"
Subject: [Bridge] Queries about Bridging
Reply-To: Sibu Thomas Mathew <sibumatrix@rediffmail.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

 This is a multipart mime message


--Next_1214143530---0-202.137.235.239-2088
Content-type: text/plain;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sir,=0AI shared internet on a LAN using my machine. It has got two ethernet=
 cards. I installed Ubuntu 8.04. I did the bridging using "bridge-utils". E=
ven though it turned out to be successful, I came across certain other prob=
lems:=0A1) I couldn't use the internet using my machine.=0A2) After every r=
estart, I had to redo the whole bridging configuration.=0A=0AThis is how i =
configured.=0AThe two ethernet cards are eth0 and eth1. eth1 is the one con=
nected to the internet. This is what I typed:=0A    brctl addbr br0=0A    b=
rctl addif br0 eth0=0A    brctl addif br0 eth1=0A    ifconfig br0 up=0AThen=
 i edited the /etc/network/interfaces as follows:=0A    auto lo=0A    iface=
 lo inet loopback=0A=0A    iface eth0 inet dhcp=0A=0A    auto eth1=0A    if=
ace eth1 inet dhcp=0A=0A    auto br0=0A    iface br0 inet dhcp=0A=0AAfter t=
hat i restarted the service by typing =0A        /etc/init.d/networking res=
tart=0AThe bridging worked. The client machine could access the internet ex=
cept mine i.e. the server. Where did I go wrong? What can I do to solve thi=
s. =0A=0ALooking forward for a solution. =0AThanking you.=0A=0AYours sincer=
ely,=0ASibu Thomas Mathew
--Next_1214143530---0-202.137.235.239-2088
Content-type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<P>=0ASir,<BR>=0AI shared internet on a LAN using my machine. It has got tw=
o ethernet cards. I installed Ubuntu 8.04. I did the bridging using &quot;b=
ridge-utils&quot;. Even though it turned out to be successful, I came acros=
s certain other problems:<BR>=0A1) I couldn't use the internet using my mac=
hine.<BR>=0A2) After every restart, I had to redo the whole bridging config=
uration.<BR>=0A<BR>=0AThis is how i configured.<BR>=0AThe two ethernet card=
s are eth0 and eth1. eth1 is the one connected to the internet. This is wha=
t I typed:<BR>=0A&nbsp; &nbsp; brctl addbr br0<BR>=0A&nbsp; &nbsp; brctl ad=
dif br0 eth0<BR>=0A&nbsp; &nbsp; brctl addif br0 eth1<BR>=0A&nbsp; &nbsp; i=
fconfig br0 up<BR>=0AThen i edited the /etc/network/interfaces as follows:<=
BR>=0A&nbsp; &nbsp; auto lo<BR>=0A&nbsp; &nbsp; iface lo inet loopback<BR>=
=0A<BR>=0A&nbsp; &nbsp; iface eth0 inet dhcp<BR>=0A<BR>=0A&nbsp; &nbsp; aut=
o eth1<BR>=0A&nbsp; &nbsp; iface eth1 inet dhcp<BR>=0A<BR>=0A&nbsp; &nbsp; =
auto br0<BR>=0A&nbsp; &nbsp; iface br0 inet dhcp<BR>=0A<BR>=0AAfter that i =
restarted the service by typing <BR>=0A&nbsp; &nbsp; &nbsp; &nbsp; /etc/ini=
t.d/networking restart<BR>=0AThe bridging worked. The client machine could =
access the internet except mine i.e. the server. Where did I go wrong? What=
 can I do to solve this. <BR>=0A<BR>=0ALooking forward for a solution. <BR>=
=0AThanking you.<BR>=0A<BR>=0AYours sincerely,<BR>=0ASibu Thomas Mathew=0A<=
/P>=0A<br><br>=0A
--Next_1214143530---0-202.137.235.239-2088--

