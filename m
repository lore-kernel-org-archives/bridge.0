Date: Mon, 22 Sep 2008 16:24:00 +0530 (IST)
From: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-961355650-1222080840=:34099"
Message-ID: <205854.34099.qm@web8807.mail.in.yahoo.com>
Subject: [Bridge] bridge is not forwarding the packet <Urgent,
	Please reply ASAP>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0-961355650-1222080840=:34099
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello to all,

I am stating my problem below in detail so that you all can understand it p=
roperly.

I am having setup of Linux box. In that box I am having one Ethernet interf=
ace eth0 and one wireless interface ath0. I have also configured one vlan p=
ort as eth0.100 with the help of vconfig (vconfig add eth 100).=C2=A0 Now I=
 have created two bridges br1 and br100. I have added eth0 into br1 so br1 =
is having only one interface. I have added ath0 and eth0.100 into br100. Ph=
ysically eth0 is connected to a switch which is configured to handle vlan 1=
00. DHCP server is also running into that switch to provide IP address to w=
ireless stations. This is all about my setup.

After this I am associating one wireless station with the ath0. After succe=
ssful association station issues a dhclient to get ip address, which reache=
s to ath0 interface of my Linux box. ath0 bridges that request to eth0.100.=
 Now eth0.100 adds it's vlan tags and forward that request to the switch. B=
ecause switch is configured to support vlan 100, so it process the dhcp req=
uest and send back the dhcp response with vlan tag 100.=20

Now I don't know but this response is not reaching to ath0. I have putted w=
ireshark and figured out that those dhcp responses are reaching on eth0 and=
 as eth0 is part of br1 so this packet is reaching to br1 which is just dis=
carding them all. So the wireless station is not getting the ip address. Ac=
cording to me eth0 should give these packets to eth0.100 port instead of br=
1. Or what I mean to say first vlan handling should be done priror then=C2=
=A0 bridge handling. Do I need to change something into Linux kernel for th=
at or there is some other problem with my setup?

Can anybody help me in this? If anybody want more detail I will provide. I =
am using Linux 2.6.15 kernel. Any kind of help will be much appreciated.=20


With Regards=20

Rahul Bhardwaj=20

=C2=A0=0A=0A=0A      Unlimited freedom, unlimited storage. Get it now, on h=
ttp://help.yahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/
--0-961355650-1222080840=:34099
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hello to all,<br><br>I am stating my problem =
below in detail so that you all can understand it properly.<br><br>I am hav=
ing setup of Linux box. In that box I am having one Ethernet interface eth0=
 and one wireless interface ath0. I have also configured one vlan port as e=
th0.100 with the help of vconfig (vconfig add eth 100).&nbsp; Now I have cr=
eated two bridges br1 and br100. I have added eth0 into br1 so br1 is havin=
g only one interface. I have added ath0 and eth0.100 into br100. Physically=
 eth0 is connected to a switch which is configured to handle vlan 100. DHCP=
 server is also running into that switch to provide IP address to wireless =
stations. This is all about my setup.<br><br>After this I am associating on=
e wireless station with the ath0. After successful association station issu=
es a dhclient to get ip address, which reaches to ath0 interface of my Linu=
x
 box. ath0 bridges that request to eth0.100. Now eth0.100 adds it's vlan ta=
gs and forward that request to the switch. Because switch is configured to =
support <span>vlan</span> 100, so it process the dhcp request and send back=
 the dhcp response with vlan tag 100. <br><br>Now I don't know but this res=
ponse is not reaching to ath0. I have putted wireshark and figured out that=
 those dhcp responses are reaching on eth0 and as eth0 is part of br1 so th=
is packet is reaching to br1 which is just discarding them all. So the wire=
less station is not getting the ip address. According to me eth0 should giv=
e these packets to eth0.100 port instead of br1. Or what I mean to say firs=
t vlan handling should be done priror then&nbsp; bridge handling. Do I need=
 to change something into Linux kernel for that or there is some other prob=
lem with my setup?<br><br>Can anybody help me in this? If anybody want more=
 detail I will provide. I am using Linux 2.6.15 kernel. Any kind of
 help will be much appreciated. <br><br><br><div><em>With Regards <br><br><=
span><span>Rahul</span></span> Bhardwaj <br></em></div><br><div><em>&nbsp;<=
/em></div></td></tr></table><br>=0A=0A=0A      <!--1--><hr size=3D1></hr> D=
ownload prohibited? No problem. <a href=3D"http://in.rd.yahoo.com/tagline_w=
ebmessenger_1/*http://in.webmessenger.yahoo.com/">CHAT</a> from any browser=
, without download.
--0-961355650-1222080840=:34099--
