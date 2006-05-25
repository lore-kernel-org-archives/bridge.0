Message-ID: <c49421c50605250704w2b1c2d52v19d809fa104a3999@mail.gmail.com>
Date: Thu, 25 May 2006 11:04:39 -0300
From: "Loreno Oliveira" <lorenooliveira@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5730_25526112.1148565879969"
Subject: [Bridge] loosing network connectivity
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_5730_25526112.1148565879969
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks,

I'm new on brctl and didn't find the archive of this list, so, sorry if my
question was previously answered.

Well, my problem is: when I run "brctl addif pan0 eth0" my network
connection is lost. If I execute "brctl delif pan0 eth0" the connection is
restablished.

Does anyone knows what is missing here??
My full script is typed bellow.

Thanks in advance for any help

Loreno

--------------------------------------------------------------------

# Make a Bridge
brctl addbr pan0

# Assign IP address
ifconfig pan0 192.168.10.1

# Disable Listening and learning states
brctl setfd pan0 0

# Disable Spanning Tree Protocol
brctl stp pan0 off

# Adding pan0 to gateway
brctl addif pan0 eth0

# Flush all the rules in filter and nat tables
/sbin/iptables --flush
/sbin/iptables --table nat --flush

# Delete all chains that are not in default filter and nat table
/sbin/iptables --delete-chain
/sbin/iptables --table nat --delete-chain

# Set up IP Forwarding and Masquerading
/sbin/iptables --table nat --append POSTROUTING --out-interface eth0 -j
MASQUERADE

# Assuming one NIC to local LAN
/sbin/iptables --append FORWARD --in-interface pan0 -j ACCEPT

# Enables packet forwarding by kernel

echo 1 > /proc/sys/net/ipv4/ip_forward

# Setting bluetooth AP

/usr/bin/pand --listen --role NAP

# Starting DHCP

dhcpd3 pan0

------=_Part_5730_25526112.1148565879969
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi folks, <br><br>I'm new on brctl and didn't find the archive of this list=
, so, sorry if my question was previously answered.<br><br>Well, my problem=
 is: when I run &quot;brctl addif pan0 eth0&quot; my network connection is =
lost. If I execute &quot;brctl delif pan0 eth0&quot; the connection is rest=
ablished.
<br><br>Does anyone knows what is missing here??<br>My full script is typed=
 bellow.<br><br>Thanks in advance for any help<br><br>Loreno<br><br>-------=
-------------------------------------------------------------<br><br># Make=
 a Bridge
<br>brctl addbr pan0<br><br># Assign IP address<br>ifconfig pan0 <a href=3D=
"http://192.168.10.1">192.168.10.1</a><br><br># Disable Listening and learn=
ing states<br>brctl setfd pan0 0<br><br># Disable Spanning Tree Protocol<br>
brctl stp pan0 off<br><br># Adding pan0 to gateway<br>brctl addif pan0 eth0=
<br><br># Flush all the rules in filter and nat tables<br>/sbin/iptables --=
flush<br>/sbin/iptables --table nat --flush<br><br># Delete all chains that=
 are not in default filter and nat table
<br>/sbin/iptables --delete-chain<br>/sbin/iptables --table nat --delete-ch=
ain<br><br># Set up IP Forwarding and Masquerading<br>/sbin/iptables --tabl=
e nat --append POSTROUTING --out-interface eth0 -j MASQUERADE<br><br># Assu=
ming one NIC to local LAN
<br>/sbin/iptables --append FORWARD --in-interface pan0 -j ACCEPT<br><br># =
Enables packet forwarding by kernel<br><br>echo 1 &gt; /proc/sys/net/ipv4/i=
p_forward<br><br># Setting bluetooth AP<br><br>/usr/bin/pand --listen --rol=
e NAP
<br><br># Starting DHCP<br><br>dhcpd3 pan0<br><br>

------=_Part_5730_25526112.1148565879969--
