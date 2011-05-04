MIME-Version: 1.0
Date: Wed, 4 May 2011 15:21:41 +0200
Message-ID: <BANLkTi=xF2j-hU+4mELWWpXet06WV5NAxA@mail.gmail.com>
From: IMS <ims77.dev@gmail.com>
Content-Type: multipart/alternative; boundary=485b393ab2072f6f5104a27323d1
Subject: [Bridge] Bridge and authentication
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

--485b393ab2072f6f5104a27323d1
Content-Type: text/plain; charset=ISO-8859-1

Hello,
I'm trying to configure an Ubuntu server with 2 wired interfaces set as a
bridge and I want a radius authentication on each interfaces.

I'm able to set my configuration files to have a bridge between the 2
interfaces without authentication.
I'm able to set my configuration files to have an authentication on each
interfaces but without the bridge.
I don't know how to configure my files to have both authentication and
bridge !
Can someone help me ?

I give you my /etc/network/interface not working :
*# loopback interface**
auto lo**
iface lo inet loopback**
# network interface**
auto eth0**
iface eth0 inet manual**
**
auto eth1**
iface eth1 inet manual**
**
auto br0**
iface br0 inet dhcp**
bridge_ports eth0 eth1**
**
wpa-iface eth0  #*How to add eth1 ? If I add a new line it's not working
*wpa-bridge br0**
wpa-driver wired**
wpa-conf /etc/wpa_supplicant/wired.conf*


The wired.conf file for information :
*ctrl_interface=/var/run/wpa_supplicant**
ctrl_interface_group=0**
ap_scan=0**
#On configure la re-authentification rapide pour protocoles EAP**
#fast_reauth=1**
**
network={**
        ssid="lan"**
        key_mgmt=IEEE8021X**
        eapol_flags=0**
        eap=MD5**
        identity="labo"**
        password="test"**
}*

With this configuration, it's working if my interface eth0 is connected, but
it's not working if it's eth1 which is connected.
Could you tell me what I need to add in my configuration file ?

Thanks for your help.

Sebastien.

--485b393ab2072f6f5104a27323d1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br>

I&#39;m trying to configure an Ubuntu server with 2 wired interfaces set as=
 a
 bridge and I want a radius authentication on each interfaces. <br>

<br>

I&#39;m able to set my configuration files to have a bridge between the 2 i=
nterfaces without authentication.<br>

I&#39;m able to set my configuration files to have an authentication on eac=
h interfaces but without the bridge.<br>

I don&#39;t know how to configure my files to have both authentication and =
bridge !<br>

Can someone help me ?<br>

<br>

I give you my /etc/network/interface not working :<br>

<b><i># loopback interface</i></b><b><i><br>

auto lo</i></b><b><i><br>

iface lo inet loopback</i></b><b><i><br>

# network interface</i></b><b><i><br>

auto eth0</i></b><b><i><br>

iface eth0 inet manual</i></b><b><i><br>

</i></b><b><i><br>

auto eth1</i></b><b><i><br>

iface eth1 inet manual</i></b><b><i><br>

</i></b><b><i><br>

auto br0</i></b><b><i><br>

iface br0 inet dhcp</i></b><b><i><br>

bridge_ports eth0 eth1</i></b><b><i><br>

</i></b><b><i><br>

wpa-iface eth0=A0 #</i></b>How to add eth1 ? If I add a new line it&#39;s n=
ot working<br>

<b><i>wpa-bridge br0</i></b><b><i><br>

wpa-driver wired</i></b><b><i><br>

wpa-conf /etc/wpa_supplicant/wired.conf</i></b><br>

<br>

<br>

The wired.conf file for information :<br>

<b><i>ctrl_interface=3D/var/run/wpa_supplicant</i></b><b><i><br>

ctrl_interface_group=3D0</i></b><b><i><br>

ap_scan=3D0</i></b><b><i><br>

#On configure la re-authentification rapide pour protocoles EAP</i></b><b><=
i><br>

#fast_reauth=3D1</i></b><b><i><br>

</i></b><b><i><br>

network=3D{</i></b><b><i><br>

=A0=A0=A0=A0=A0=A0=A0 ssid=3D&quot;lan&quot;</i></b><b><i><br>

=A0=A0=A0=A0=A0=A0=A0 key_mgmt=3DIEEE8021X</i></b><b><i><br>

=A0=A0=A0=A0=A0=A0=A0 eapol_flags=3D0</i></b><b><i><br>

=A0=A0=A0=A0=A0=A0=A0 eap=3DMD5</i></b><b><i><br>

=A0=A0=A0=A0=A0=A0=A0 identity=3D&quot;labo&quot;</i></b><b><i><br>

=A0=A0=A0=A0=A0=A0=A0 password=3D&quot;test&quot;</i></b><b><i><br>

}</i></b><br>

<br>

With this configuration, it&#39;s working if my interface eth0 is connected=
, but it&#39;s not working if it&#39;s eth1 which is connected.<br>

Could you tell me what I need to add in my configuration file ?<br>

<br>

Thanks for your help.<br>

<br>

Sebastien.

--485b393ab2072f6f5104a27323d1--
