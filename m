From: <james.card@nokia.com>
Date: Mon, 22 Feb 2010 17:04:43 +0100
Message-ID: <C7A8154B.1201%james.card@nokia.com>
In-Reply-To: <2e59e6971002211647r10f229b2l25b5dd68e397dfff@mail.gmail.com>
Content-Language: en
Content-Type: multipart/alternative;
	boundary="_000_C7A8154B1201jamescardnokiacom_"
MIME-Version: 1.0
Subject: [Bridge] Slow receive side on bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--_000_C7A8154B1201jamescardnokiacom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I have a CentOS 5.4 distro running Xen on top of a Linux bridge (set up by =
Xen).  I have noticed by using iPerf in bidirectional mode that the traffic=
 going into the server running the bridge is quite a bit slower with the br=
idge enabled than when it isn't.   The HW is a multiblade setup (8 blades e=
ach running CentOS 5.x).  On one of the blades, I shut down Xen and initial=
ly run with the bridge shut down and transferred a file from another machin=
e using scp.  I then started up the bridge and transferred the same file an=
d you can see below there is a big difference (3.6MB/s vs 23.2KB/s).  I sto=
pped Xen before doing the following...

Any help on where to look would be helpful.  I was going to shut down all b=
ut one blade to see if it could be a lack of STP causing issues.

-- Xen bridge initially shut down

[root@bsbchp003 ~]# brctl show
bridge name    bridge id        STP enabled    interfaces
virbr0        8000.000000000000    yes

-- transfer the 3.7GB file

[root@bsbchp003 ~]# scp card@harvard:bigfile .
bigfile                                                                    =
                                                                           =
                  100% 3685KB   3.6MB/s   00:00

-- start the bridge

[root@bsbchp003 ~]# /etc/xen/scripts/network-bridge start
net.bridge.bridge-nf-call-arptables =3D 0
net.bridge.bridge-nf-call-ip6tables =3D 0
net.bridge.bridge-nf-call-iptables =3D 0
Nothing to flush.
Nothing to flush.
Waiting for peth0 to negotiate link..[root@bsbchp003 ~]#

-- the Xen bridge is now up

[root@bsbchp003 ~]# brctl show
bridge name    bridge id        STP enabled    interfaces
virbr0        8000.000000000000    yes
xenbr0        8000.feffffffffff    no        peth0
                            vif0.0
[root@bsbchp003 ~]# scp card@harvard:bigfile .
bigfile                                                                    =
                                                                           =
                  100% 3685KB  23.2KB/s   02:39
[root@bsbchp003 ~]#

--_000_C7A8154B1201jamescardnokiacom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML>
<HEAD>
<TITLE>Slow receive side on bridge</TITLE>
</HEAD>
<BODY>
<FONT FACE=3D"Calibri, Verdana, Helvetica, Arial"><SPAN STYLE=3D'font-size:=
11pt'>Hi,<BR>
<BR>
I have a CentOS 5.4 distro running Xen on top of a Linux bridge (set up by =
Xen). &nbsp;I have noticed by using iPerf in bidirectional mode that the tr=
affic going into the server running the bridge is quite a bit slower with t=
he bridge enabled than when it isn&#8217;t. &nbsp;&nbsp;The HW is a multibl=
ade setup (8 blades each running CentOS 5.x). &nbsp;On one of the blades, I=
 shut down Xen and initially run with the bridge shut down and transferred =
a file from another machine using scp. &nbsp;I then started up the bridge a=
nd transferred the same file and you can see below there is a big differenc=
e (3.6MB/s vs 23.2KB/s). &nbsp;I stopped Xen before doing the following...<=
BR>
<BR>
Any help on where to look would be helpful. &nbsp;I was going to shut down =
all but one blade to see if it could be a lack of STP causing issues.<BR>
<BR>
-- Xen bridge initially shut down<BR>
<BR>
[root@bsbchp003 ~]# brctl show<BR>
bridge name &nbsp;&nbsp;&nbsp;bridge id &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;STP enabled &nbsp;&nbsp;&nbsp;interfaces<BR>
virbr0 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8000.000000000000 &nbsp;&n=
bsp;&nbsp;yes<BR>
<BR>
-- transfer the 3.7GB file<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
[root@bsbchp003 ~]# scp card@harvard:bigfile .<BR>
bigfile &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;100% 36=
85KB &nbsp;&nbsp;3.6MB/s &nbsp;&nbsp;00:00 &nbsp;&nbsp;&nbsp;<BR>
<BR>
-- start the bridge<BR>
<BR>
[root@bsbchp003 ~]# /etc/xen/scripts/network-bridge start<BR>
net.bridge.bridge-nf-call-arptables =3D 0<BR>
net.bridge.bridge-nf-call-ip6tables =3D 0<BR>
net.bridge.bridge-nf-call-iptables =3D 0<BR>
Nothing to flush.<BR>
Nothing to flush.<BR>
Waiting for peth0 to negotiate link..[root@bsbchp003 ~]# <BR>
<BR>
-- the Xen bridge is now up<BR>
<BR>
[root@bsbchp003 ~]# brctl show<BR>
bridge name &nbsp;&nbsp;&nbsp;bridge id &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;STP enabled &nbsp;&nbsp;&nbsp;interfaces<BR>
virbr0 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8000.000000000000 &nbsp;&n=
bsp;&nbsp;yes &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
xenbr0 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8000.feffffffffff &nbsp;&n=
bsp;&nbsp;no &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;peth0<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;vif0.0<BR>
[root@bsbchp003 ~]# scp card@harvard:bigfile .<BR>
bigfile &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;100% 36=
85KB &nbsp;23.2KB/s &nbsp;&nbsp;02:39 &nbsp;&nbsp;&nbsp;<BR>
[root@bsbchp003 ~]# <BR>
</SPAN></FONT>
</BODY>
</HTML>


--_000_C7A8154B1201jamescardnokiacom_--
