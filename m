Message-ID: <49FA1E28.5020604@free.fr>
Date: Thu, 30 Apr 2009 23:54:48 +0200
From: =?ISO-8859-1?Q?Nicolas_de_Peslo=FCan?= <nicolas.2p.debian@free.fr>
MIME-Version: 1.0
References: <20090428124009.GA26387@kallisti.us>	<2e59e6970904281200u44e3ebbfga0f074dfaa78c1ab@mail.gmail.com>	<49F77248.1050800@gmail.com>	<2e59e6970904281600u42142392vb8e0eb45c4ede15c@mail.gmail.com>	<49F87D4E.4060705@gmail.com>
	<20090429162651.GA9455@kallisti.us>	<49F882F9.4010100@gmail.com>
	<20090429165329.GA9893@kallisti.us>	<49F8C4C3.9020504@gmail.com>	<2e59e6970904292118u71ff441ft19448f753c1b6dd9@mail.gmail.com>
	<db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
In-Reply-To: <db99f77d0904292330n4c460ccbv45e60f06bfa49c4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Jochen Hebbrecht <jochenhebbrecht@gmail.com>
Cc: bridge@lists.linux-foundation.org


> 2009/4/30 richardvoigt@gmail.com <richardvoigt@gmail.com>:
>>

>> That's at the IP stack.  At the firmware level, most wireless cards will
>> refuse to transmit/receive packets with other MAC addresses, making them
>> useless for AP or bridging.  Yours is apparently not one of those since
>> bridging works in Windows (or else the Windows bridge code does transparent
>> routing w/MAC address replacement, rather like NAT or PAT but working at
>> layer 2 instead of 3).
>>
>> That's why I suggested testing for the DHCP discover on a different wireless
>> node.

Can you also explain why you are trying to use bridge ?

Are you just trying to share a common IP address between two links 
(Ethernet and wifi), in order to switch automatically to wifi when you 
unplug the Ethernet wire, without loosing any active connections ?

If this is what you are trying to do, you might try the bonding module 
instead of bridge, and have a look at the ifenslave-2.6 package from 
Debian, which should work on Ubuntu. This package enhance the ifupdown 
system and allow you to bond an Ethernet and a Wifi link, in an 
active/backup mode. An "Ethernet+wifi" example configuration is provided 
in the documentation.

You configuration should look like this :

auto bond0
iface bond0 inet dhcp
	bond-slaves eth0
	bond-mode 1
	bond-miimon 100
	bond-primary eth0

iface eth0 inet manual
# Useless, unless NetworkManager is enabled on you system.

auto eth1
iface eth1 inet manual
	bond-master bond0
	bond-give-a-chance 10
	wpa-bridge bond0
	wpa-driver wext
	wpa-ssid ##SSID##
	wpa-ap-scan 1
	wpa-proto RSN
	wpa-pariwire CCMP
	wpa-group CCMP
	wpa-key-mgmt WPA-PSK
	wpa-psk ##PSK KEY##

'hope this help.

	Nicolas.
