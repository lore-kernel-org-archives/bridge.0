MIME-Version: 1.0
Date: Tue, 6 Apr 2010 17:02:07 -0400
Message-ID: <q2x1803dfd21004061402h67b2a920m4b9b1ac2dc66bb2f@mail.gmail.com>
From: Ryan Whelan <ryan.whelan@tbamerica.com>
Content-Type: multipart/alternative; boundary=001485ec0e582e65c1048397c2d5
Subject: [Bridge] Bridging vSwitches in VMwares ESXi
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

--001485ec0e582e65c1048397c2d5
Content-Type: text/plain; charset=ISO-8859-1

I'm having an issue bridging 2 virtual switches in VMwares ESXi.  I've made
a post on the VMware forums describing the issue (
http://communities.vmware.com/message/1507261#1507261).

I have searched the internet and found a post (
http://archives.free.net.ph/message/20100108.174704.efbb18cc.ja.html) by
someone having the exact same issue- it looks like that post was on this
list?

In short, I have a Linux VM in ESXi with 2 vNICs- one in each of 2 different
vSwitches.  A client (in my case a windows machine) on the second vSwitch
can't get the MAC address of the default gateway on the first vSwitch.
 Sniffing the traffic shows the arp broadcast from the windows machine
making if over the linux bridge and getting responded to by the cisco
gateway but the response never makes it back over the bridge.  Watching the
mac table in the linux bridge shows it mistakenly associates the mac address
of the windows machine to the wrong port (eth0 in my case, eth1 is the vNIC
plugged into the switch with the windows box)

Im not sure where the issue is; its really pretty simple setup.  Am I
missing something simple? Is there really a bug here?

Thanks!

--001485ec0e582e65c1048397c2d5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I&#39;m having an issue bridging 2 virtual switches in VMwares ESXi. =
=A0I&#39;ve made a post on the VMware forums describing the issue (<a href=
=3D"http://communities.vmware.com/message/1507261#1507261" target=3D"_blank=
">http://communities.vmware.com/message/1507261#1507261</a>).</div>
<div><br></div><div>I have searched the internet and found a post (<a href=
=3D"http://archives.free.net.ph/message/20100108.174704.efbb18cc.ja.html" t=
arget=3D"_blank">http://archives.free.net.ph/message/20100108.174704.efbb18=
cc.ja.html</a>) by someone having the exact same issue- it looks like that =
post was on this list?</div>
<div><br></div><div>In short, I have a Linux VM in ESXi with 2 vNICs- one i=
n each of 2 different vSwitches. =A0A client (in my case a windows machine)=
 on the second vSwitch can&#39;t get the MAC address of the default gateway=
 on the first vSwitch. =A0Sniffing the traffic shows the arp broadcast from=
 the windows machine making if over the linux bridge and getting responded =
to by the cisco gateway but the response never makes it back over the bridg=
e. =A0Watching the mac table in the linux bridge shows it mistakenly=A0asso=
ciates the mac address of the windows machine to the wrong port (eth0 in my=
 case, eth1 is the vNIC plugged into the switch with the windows box)</div>
<div><br></div><div>Im not sure where the issue is; its really pretty simpl=
e setup. =A0Am I missing something simple? Is there really a bug here?=A0</=
div><div><br></div><div>Thanks!</div>

--001485ec0e582e65c1048397c2d5--
