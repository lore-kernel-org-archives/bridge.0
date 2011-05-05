MIME-Version: 1.0
Date: Thu, 5 May 2011 08:49:28 +0200
Message-ID: <BANLkTimkRLdA6DpzLu49UnKeN19o51Kmyw@mail.gmail.com>
From: IMS <ims77.dev@gmail.com>
Content-Type: multipart/alternative; boundary=00151743f88453752904a281c612
Subject: Re: [Bridge] Bridge and authentication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: bridge@linux-foundation.org

--00151743f88453752904a281c612
Content-Type: text/plain; charset=ISO-8859-1

First, thanks for your response.
My code is inspired from the ubuntu documentation but there was only one
interface in the example (
https://help.ubuntu.com/community/Network802.1xAuthentication)
Do you means it's not possible to do it with two interfaces ? I should be
connected and authenticated on the 2 interfaces to be able to use the bridge
?
Or should I authenticate the bridge ? if so how to do that !?

If someone has a valid example with 2 Ethernet interfaces I'm interested by
!

Sebastien.

--------------------------------------------------------------------------------------------------------------

> Hello,
> I'm trying to configure an Ubuntu server with 2 wired interfaces set as a
> bridge and I want a radius authentication on each interfaces.
>
> I'm able to set my configuration files to have a bridge between the 2
> interfaces without authentication.
> I'm able to set my configuration files to have an authentication on each
> interfaces but without the bridge.
> I don't know how to configure my files to have both authentication and
> bridge !
> Can someone help me ?
>
> I give you my /etc/network/interface not working :
> *# loopback interface**
> auto lo**
> iface lo inet loopback**
> # network interface**
> auto eth0**
> iface eth0 inet manual**
> **
> auto eth1**
> iface eth1 inet manual**
> **
> auto br0**
> iface br0 inet dhcp**
> bridge_ports eth0 eth1**
> **
> wpa-iface eth0  #*How to add eth1 ? If I add a new line it's not working
> *wpa-bridge br0**
> wpa-driver wired**
> wpa-conf /etc/wpa_supplicant/wired.conf*
>
>
> The wired.conf file for information :
> *ctrl_interface=/var/run/wpa_supplicant**
> ctrl_interface_group=0**
> ap_scan=0**
> #On configure la re-authentification rapide pour protocoles EAP**
> #fast_reauth=1**
> **
> network={**
>         ssid="lan"**
>         key_mgmt=IEEE8021X**
>         eapol_flags=0**
>         eap=MD5**
>         identity="labo"**
>         password="test"**
> }*
>
> With this configuration, it's working if my interface eth0 is connected,
but
> it's not working if it's eth1 which is connected.
> Could you tell me what I need to add in my configuration file ?
>
> Thanks for your help.
>
> Sebastien.

Once you put interfaces into a bridge, all applications and services
should use the bridge interface not the underlying ethernet devices
because packets received on the underlying device will be absorbed
by the bridge and not processed for the ethernet device.

--00151743f88453752904a281c612
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font size=3D"2"><span style=3D"font-size:10pt;">First, thanks for your res=
ponse.<br>My code is inspired from the ubuntu documentation but there was o=
nly one interface in the example (<a href=3D"https://help.ubuntu.com/commun=
ity/Network802.1xAuthentication">https://help.ubuntu.com/community/Network8=
02.1xAuthentication</a>)<br>
Do you means it&#39;s not possible to do it with two interfaces ? I should =
be connected and authenticated on the 2 interfaces to be able to use the br=
idge ?<br>Or should I authenticate the bridge ? if so how to do that !?<br>
<br>If someone has a valid example with 2 Ethernet interfaces I&#39;m inter=
ested by !<br><br>Sebastien.<br><br>---------------------------------------=
-----------------------------------------------------------------------<br>
<br>&gt; Hello,<br>

&gt; I&#39;m trying to configure an Ubuntu server with 2 wired interfaces s=
et as a<br>

&gt; bridge and I want a radius authentication on each interfaces.<br>

&gt; <br>

&gt; I&#39;m able to set my configuration files to have a bridge between th=
e 2<br>

&gt; interfaces without authentication.<br>

&gt; I&#39;m able to set my configuration files to have an authentication o=
n each<br>

&gt; interfaces but without the bridge.<br>

&gt; I don&#39;t know how to configure my files to have both authentication=
 and<br>

&gt; bridge !<br>

&gt; Can someone help me ?<br>

&gt; <br>

&gt; I give you my /etc/network/interface not working :<br>

&gt; *# loopback interface**<br>

&gt; auto lo**<br>

&gt; iface lo inet loopback**<br>

&gt; # network interface**<br>

&gt; auto eth0**<br>

&gt; iface eth0 inet manual**<br>

&gt; **<br>

&gt; auto eth1**<br>

&gt; iface eth1 inet manual**<br>

&gt; **<br>

&gt; auto br0**<br>

&gt; iface br0 inet dhcp**<br>

&gt; bridge_ports eth0 eth1**<br>

&gt; **<br>

&gt; wpa-iface eth0=A0 #*How to add eth1 ? If I add a new line it&#39;s not=
 working<br>

&gt; *wpa-bridge br0**<br>

&gt; wpa-driver wired**<br>

&gt; wpa-conf /etc/wpa_supplicant/wired.conf*<br>

&gt; <br>

&gt; <br>

&gt; The wired.conf file for information :<br>

&gt; *ctrl_interface=3D/var/run/wpa_supplicant**<br>

&gt; ctrl_interface_group=3D0**<br>

&gt; ap_scan=3D0**<br>

&gt; #On configure la re-authentification rapide pour protocoles EAP**<br>

&gt; #fast_reauth=3D1**<br>

&gt; **<br>

&gt; network=3D{**<br>

&gt;=A0=A0=A0=A0=A0=A0=A0=A0 ssid=3D&quot;lan&quot;**<br>

&gt;=A0=A0=A0=A0=A0=A0=A0=A0 key_mgmt=3DIEEE8021X**<br>

&gt;=A0=A0=A0=A0=A0=A0=A0=A0 eapol_flags=3D0**<br>

&gt;=A0=A0=A0=A0=A0=A0=A0=A0 eap=3DMD5**<br>

&gt;=A0=A0=A0=A0=A0=A0=A0=A0 identity=3D&quot;labo&quot;**<br>

&gt;=A0=A0=A0=A0=A0=A0=A0=A0 password=3D&quot;test&quot;**<br>

&gt; }*<br>

&gt; <br>

&gt; With this configuration, it&#39;s working if my interface eth0 is conn=
ected, but<br>

&gt; it&#39;s not working if it&#39;s eth1 which is connected.<br>

&gt; Could you tell me what I need to add in my configuration file ?<br>

&gt; <br>

&gt; Thanks for your help.<br>

&gt; <br>

&gt; Sebastien.<br>

<br>

Once you put interfaces into a bridge, all applications and services<br>

should use the bridge interface not the underlying ethernet devices<br>

because packets received on the underlying device will be absorbed<br>

by the bridge and not processed for the ethernet device.</span></font>

--00151743f88453752904a281c612--
