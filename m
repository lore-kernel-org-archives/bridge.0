MIME-Version: 1.0
From: Ravi Varun Nair <rvnair@us.ibm.com>
Message-ID: <OF0ED85024.3389DB4D-ON8525782D.0054FDD2-8525782D.00597D7B@us.ibm.com>
Date: Fri, 4 Feb 2011 11:17:29 -0500
Content-Type: multipart/alternative;
	boundary="=_alternative 005976D28525782D_="
Subject: [Bridge] Problem configuring bridge as a hub between host server
 and running VM guest
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

This is a multipart message in MIME format.
--=_alternative 005976D28525782D_=
Content-Type: text/plain; charset="US-ASCII"

Hi,
I am having a problem with configuring the bridge to work as a hub. My 
setup is the following:

 I have a RHEL host server on which I am running KVM. I have a Linux guest 
that I am running on this. A physical interface of the host is on the same 
bridge as the guest's interface. The bridge inherits the mac address of 
the physical interface on running the steps as mentioned in this link 
http://wiki.libvirt.org/page/Networking#Fedora.2FRHEL_Bridging . Also the 
static IP address that was being originally provided to the physical 
interface, is now given to the  bridge to enable networking for the host.

What I am trying to do is have a copy of all the traffic coming in on the 
physical interface be given to the VM. To configure the bridge as a hub, I 
set the ageing time value on the bridge to 0 as mentioned in a previous 
post on this list (
http://www.mail-archive.com/bridge@lists.linux-foundation.org/msg01940.html
). The problem I am facing is that on the VM,  I only see the 
traffic(using tcpdump) leaving the physical interface. I do not see the 
traffic that is coming in to the physical interface. The bridge assumes(I 
am guessing as it inherits the mac address of the physical interface), 
that the incoming traffic is meant for itself and hence does not forward 
on the traffic. 

In case a second guest is introduced in the above scenario(with an 
interface on the same bridge), then with the above configuration for 
ageing time, all the traffic going to one guest is seen by the second 
guest. So, the bridge does work as a hub for all other scenarios.

Could someone suggest if there is a way to work around this problem?

Thanks
varun
--=_alternative 005976D28525782D_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Hi,</font>
<br><font size=2 face="sans-serif">I am having a problem with configuring
the bridge to work as a hub. My setup is the following:</font>
<br>
<br><font size=2 face="sans-serif">&nbsp;I have a RHEL host server on which
I am running KVM. I have a Linux guest that I am running on this. A physical
interface of the host is on the same bridge as the guest's interface. The
bridge inherits the mac address of the physical interface on running the
steps as mentioned in this link </font><a href=http://wiki.libvirt.org/page/Networking#Fedora.2FRHEL_Bridging><font size=2 face="sans-serif">http://wiki.libvirt.org/page/Networking#Fedora.2FRHEL_Bridging</font></a><font size=2 face="sans-serif">
. Also the static IP address that was being originally provided to the
physical interface, is now given to the &nbsp;bridge to enable networking
for the host.</font>
<br>
<br><font size=2 face="sans-serif">What I am trying to do is have a copy
of all the traffic coming in on the physical interface be given to the
VM. To configure the bridge as a hub, I set the ageing time value on the
bridge to 0 as mentioned in a previous post on this list (</font><a href="http://www.mail-archive.com/bridge@lists.linux-foundation.org/msg01940.html"><font size=2 face="sans-serif">http://www.mail-archive.com/bridge@lists.linux-foundation.org/msg01940.html</font></a><font size=2 face="sans-serif">).
The problem I am facing is that on the VM, &nbsp;I only see the traffic(using
tcpdump) leaving the physical interface. I do not see the traffic that
is coming in to the physical interface. The bridge assumes(I am guessing
as it inherits the mac address of the physical interface), that the incoming
traffic is meant for itself and hence does not forward on the traffic.
</font>
<br>
<br><font size=2 face="sans-serif">In case a second guest is introduced
in the above scenario(with an interface on the same bridge), then with
the above configuration for ageing time, all the traffic going to one guest
is seen by the second guest. So, the bridge does work as a hub for all
other scenarios.</font>
<br>
<br><font size=2 face="sans-serif">Could someone suggest if there is a
way to work around this problem?</font>
<br>
<br><font size=2 face="sans-serif">Thanks</font>
<br><font size=2 face="sans-serif">varun</font>
--=_alternative 005976D28525782D_=--
