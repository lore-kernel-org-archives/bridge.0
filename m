Message-ID: <49FC4764.3030707@gmail.com>
Date: Sat, 02 May 2009 15:15:16 +0200
From: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
	<49FA1E28.5020604@free.fr>
In-Reply-To: <49FA1E28.5020604@free.fr>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Ubuntu: network bridging between wireless and wired
 connection fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
Cc: bridge@lists.linux-foundation.org

Nicolas de Peslo=FCan schreef:
>
> Can you also explain why you are trying to use bridge ?
>
> Are you just trying to share a common IP address between two links=20
> (Ethernet and wifi), in order to switch automatically to wifi when you=20
> unplug the Ethernet wire, without loosing any active connections ?
>
> If this is what you are trying to do, you might try the bonding module=20
> instead of bridge, and have a look at the ifenslave-2.6 package from=20
> Debian, which should work on Ubuntu. This package enhance the ifupdown=20
> system and allow you to bond an Ethernet and a Wifi link, in an=20
> active/backup mode. An "Ethernet+wifi" example configuration is=20
> provided in the documentation.
>
> You configuration should look like this :
>
> auto bond0
> iface bond0 inet dhcp
>     bond-slaves eth0
>     bond-mode 1
>     bond-miimon 100
>     bond-primary eth0
>
> iface eth0 inet manual
> # Useless, unless NetworkManager is enabled on you system.
>
> auto eth1
> iface eth1 inet manual
>     bond-master bond0
>     bond-give-a-chance 10
>     wpa-bridge bond0
>     wpa-driver wext
>     wpa-ssid ##SSID##
>     wpa-ap-scan 1
>     wpa-proto RSN
>     wpa-pariwire CCMP
>     wpa-group CCMP
>     wpa-key-mgmt WPA-PSK
>     wpa-psk ##PSK KEY##
>
> 'hope this help.
>
>     Nicolas.

Nicolas,

I'm not sure that bonding is the thing I need. I'll explain what I want=20
to do.

Please check this image: http://www.jochus.be/brol/networking.png
* Purple lines: wired (UTP)
* Blue (dashed) lines: wireless

So in this building, there are 2 locations. Location A and B. There's no=20
possibility to link them using a wired cable, and I don't like the net=20
adapters who transmits packets using the 50Hz channel.

In location A, there's a desktop and a notebook a. In location B,=20
there's a notebook, a server which maintains e-mails, backup,=20
Subversion, Archiva, ... and there's also printer (a network printer).

So, notebook B needs to print to the network printer, which is very easy=20
by using the switch that's on location B. So that works. But now I want=20
to print from location A on the desktop and notebook A. So I needed to=20
connect them in the same subnet of the networkprinter.

So, I wanted to created a bridge on the Ubuntu server (who has a=20
wireless WMP54G network card), and on eth0 an ethernet controller. So by=20
connecting eth0 to the switch, all notebooks and desktop would be able=20
to print to the networkprinter

This situation works fine if the server is running Windows, but not=20
Ubuntu as the bridge isn't working there :-(

Hope this clears out what I'm trying to do

Best regards,
Jochen
