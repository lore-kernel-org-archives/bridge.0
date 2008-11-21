Date: Fri, 21 Nov 2008 22:14:50 +0530 (IST)
From: rahul bhardwaj <rahul_bhardwaj36in@yahoo.co.in>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-81776775-1227285890=:33987"
Message-ID: <95177.33987.qm@web8804.mail.in.yahoo.com>
Subject: [Bridge] Help needed regarding bridge entered into disabled state!!!
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0-81776775-1227285890=:33987
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi All,

I have setup which include communication b/w two boxes take a name as BOX A=
 and BOX B. Inside BOX A, I am having one bridge interface name as br1. br1=
 has two interfaces one is eth0 and other one is ath0. eth0 is physically c=
onnected to BOX B. but we are issuing dhcp client on br1 and communicating =
with BOX B with br1 itself.=20

We are running one keep alive timer with 15 secs in BOX B to monitor BOX A.=
 whenever BOX B found BOX A unreachable for keep alive time, it tries to re=
boot BOX A with the help of some internal implementation. This is all about=
 my setup. If anybody has any doubt please let me know.

Now I am going to explain you my problem, We are destroying or disabling th=
e port 2 of the bridge br1 and after that I am not able to reach to BOX A f=
rom any where for quite some time somewhere around 20 to 30 secs. So I just=
 want to know is this the correct behavior. I mean if we disabled any port =
of the bridge, at that time bridge will not be reachable at all for quite s=
ome time. I have not enabled stp and i also set fd to 0. Then also i am fac=
ing this issue.

Please help me in this, I really required your help on this.

With Regards=20

Rahul Bhardwaj=20

=C2=A0=0A=0A=0A      Add more friends to your messenger and enjoy! Go to ht=
tp://messenger.yahoo.com/invite/
--0-81776775-1227285890=:33987
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hi All,<br><br>I have setup which include com=
munication b/w two boxes take a name as BOX A and BOX B. Inside BOX A, I am=
 having one bridge interface name as br1. br1 has two interfaces one is eth=
0 and other one is ath0. eth0 is physically connected to BOX B. but we are =
issuing dhcp client on br1 and communicating with BOX B with br1 itself. <b=
r><br>We are running one keep alive timer with 15 secs in BOX B to monitor =
BOX A. whenever BOX B found BOX A unreachable for keep alive time, it tries=
 to reboot BOX A with the help of some internal implementation. This is all=
 about my setup. If anybody has any doubt please let me know.<br><br>Now I =
am going to explain you my problem, We are destroying or disabling the port=
 2 of the bridge br1 and after that I am not able to reach to BOX A from an=
y where for quite some time somewhere around 20 to 30 secs. So I just want =
to
 know is this the correct behavior. I mean if we disabled any port of the b=
ridge, at that time bridge will not be reachable at all for quite some time=
. I have not enabled stp and i also set fd to 0. Then also i am facing this=
 issue.<br><br>Please help me in this, I really required your help on this.=
<br><div><em><br>With Regards <br><br>Rahul Bhardwaj <br></em></div><br><di=
v><em>&nbsp;</em></div></td></tr></table><br>=0A      <!--6--><hr size=3D1>=
</hr> Add more friends to your messenger and enjoy! <a href=3D"http://in.rd=
.yahoo.com/tagline_messenger_6/*http://messenger.yahoo.com/invite/"> Invite=
 them now.</a>
--0-81776775-1227285890=:33987--
