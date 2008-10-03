Date: Fri, 3 Oct 2008 19:01:24 +0530 (IST)
From: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-918943124-1223040684=:59431"
Message-ID: <601216.59431.qm@web8804.mail.in.yahoo.com>
Subject: [Bridge] Problam with vlan interface of ath0
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0-918943124-1223040684=:59431
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi to all,

I have on setup where I have created one Vlan interface of an wireless inte=
rface ath0 (vconfig add ath0 100). By doing this I am getting one vlan inte=
rface as ath0.100. I already have one more Ethernet vlan interface as eth0.=
100. I have added both ath0.100 as well eth0.100 into a bridge. Now I am re=
ceiving DHCP discover packets on ath0 but then some how ath0 is not giving =
this packet to its own vlan interface ath0.100. That is why it is not reach=
ing to eth0.100.

Can somebody explain this behavior to me. Why ath0 is not giving packet to =
ath0.100.
Any kind of help be very much appreciated.

Thanks a lot,

With Regards=20

Rahul Bhardwaj=20

=C2=A0=0A=0A=0A      Be the first one to try the new Messenger 9 Beta! Go t=
o http://in.messenger.yahoo.com/win/
--0-918943124-1223040684=:59431
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi to all,<br><br>I have on setup where I hav=
e created one Vlan interface of an wireless interface ath0 (vconfig add ath=
0 100). By doing this I am getting one vlan interface as ath0.100. I alread=
y have one more Ethernet vlan interface as eth0.100. I have added both ath0=
.100 as well eth0.100 into a bridge. Now I am receiving DHCP discover packe=
ts on ath0 but then some how ath0 is not giving this packet to its own vlan=
 interface ath0.100. That is why it is not reaching to eth0.100.<br><br>Can=
 somebody explain this behavior to me. Why ath0 is not giving packet to ath=
0.100.<br>Any kind of help be very much appreciated.<br><br>Thanks a lot,<b=
r><br><div><em>With Regards <br><br><span>Rahul</span> Bhardwaj <br></em></=
div><br><div><em>&nbsp;</em></div></td></tr></table><br>=0A      <!--6--><h=
r size=3D1></hr> Add more friends to your messenger and enjoy! <a href=3D"h=
ttp://in.rd.yahoo.com/tagline_messenger_6/*http://messenger.yahoo.com/invit=
e/"> Invite them now.</a>
--0-918943124-1223040684=:59431--
