MIME-Version: 1.0
Date: Mon, 19 Apr 2010 15:05:35 +0530
Message-ID: <i2xe5da85b41004190235t447ea22exa046c63fc3373971@mail.gmail.com>
From: voxner <voxner.dev@gmail.com>
Content-Type: multipart/alternative; boundary=0016e6435456d6a34a048493ae20
Subject: [Bridge] RSTP-Linux Bridge (2.6 Kernel) query
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--0016e6435456d6a34a048493ae20
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I am fairly new to Bridging, and I have been trying to understand the
Bridge-RSTP communication. I have an RSTP implementation running in
user-space and I would like to use the existing Linux bridge data-structures
(like net_bridge, net_bridge_port used in Linux 2.6) so that I have a
Linux-Bridge/RSTP setup. For this I need to introduce some sort of
communication mechanism (maybe IOCTL calls) to alter these data-structures
by my RSTP.

My idea is to disable STP (thus making sure that routines like
br_configuration_update() are not called) and then use a communication
mechanism to alter bridge/bridge-port states(stored in net_bridge) of kernel
from my RSTP.

From my analysis, I found the following instances of communication

Bridge -> RSTP Communication
1. An RSTP BPDU (control) packet is received (like the routine br_stp_rcv in
existing linux)
2. When a bridge is added or removed
3. When a port in a bridge is added or removed

RSTP -> Bridge Communication
1.Setting a Bridge-Port state
2.Setting Bridge-Ports pirority
3.Getting number of ports.
4.Command to send a BPDU packet
etc .......

I would like to know if I am on the right track. To summarize I "disable"
all those STP routines, introduce a bunch of routines that set bridge/ports
based on communication received from the RSTP running in user-space.

I have looked at the differences between STP and RSTP but I am unsure as to
how this will play out in my solution. Should I go for another strategy? Is
there any similar work out there that does this? I would really appreciate
any input/pointers in this matter.

Thanks,
Vox

P.S. To get an insight into this problem I took a cursory look at another
RSTP implementation called RSTPLib (http://rstplib.sourceforge.net) but it
uses daemons, sysfs & crucially it is not "integrated" into the kernel. I am
also unclear if it's purely on a simulation tool. Also its code seems no
longer under development.

--0016e6435456d6a34a048493ae20
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi all,<br><br>I am fairly new to Bridging, and I have been trying to =
understand the Bridge-RSTP communication. I have an RSTP implementation run=
ning in user-space and I would like to use the existing Linux bridge data-s=
tructures (like net_bridge, net_bridge_port used in Linux 2.6) so that I ha=
ve a Linux-Bridge/RSTP setup. For this I need to introduce some sort of com=
munication mechanism (maybe IOCTL calls) to alter these data-structures by =
my RSTP.<br>
<br>My idea is to disable STP (thus making sure that routines like br_confi=
guration_update() are not called) and then use a communication mechanism to=
 alter bridge/bridge-port states(stored in net_bridge) of kernel from my RS=
TP. <br>
<br>From my analysis, I found the following instances of communication<br><=
br>Bridge -&gt; RSTP Communication<br>1. An RSTP BPDU (control) packet is r=
eceived (like the routine br_stp_rcv in existing linux)<br> 2. When a bridg=
e is added or removed<br>
 3. When a port in a bridge is added or removed<br><br>RSTP -&gt; Bridge Co=
mmunication<br>1.Setting a Bridge-Port state<br>2.Setting Bridge-Ports piro=
rity<br>3.Getting number of ports.<br>4.Command to send a BPDU packet<br>
etc .......<br><br>I would like to know if I am on the right track. To summ=
arize I &quot;disable&quot; all those STP routines, introduce a bunch of ro=
utines that set bridge/ports based on communication received from the RSTP =
running in user-space.=A0</div>
<div><br></div><div>I have looked at the differences between STP and RSTP b=
ut I am unsure as to how this will play out in my solution.=A0Should I go f=
or another strategy? Is there any similar work out there that does this? I =
would really appreciate any input/pointers in this matter.=A0<br>
<br>Thanks,<br>Vox<br><br>P.S. To get an insight into this problem I took a=
 cursory look at another RSTP implementation called RSTPLib (<a href=3D"htt=
p://rstplib.sourceforge.net">http://rstplib.sourceforge.net</a>) but it use=
s daemons, sysfs &amp; crucially it is not &quot;integrated&quot; into the =
kernel. I am also unclear if it&#39;s purely on a simulation tool. Also its=
 code seems no longer under development.=A0<br>
</div>

--0016e6435456d6a34a048493ae20--
