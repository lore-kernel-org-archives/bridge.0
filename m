Message-ID: <41E400B1.9030409@tamu.edu>
Date: Tue, 11 Jan 2005 10:37:05 -0600
From: Patrick Bogen <pdbogen@tamu.edu>
MIME-Version: 1.0
Subject: Re: [Bridge] Cannot ping to the board when changing loop configuration
References: <20050111025021.17664.qmail@web14715.mail.yahoo.com>
In-Reply-To: <20050111025021.17664.qmail@web14715.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Prashant Agrawal wrote:
| Hi all,
|
| I am running a bridge with STP 'on' on an arm-linux
| board. I have two ethernet ports on the bridge both
| connected to a single switch thus creating a loop.
| Using brctl on the board, I can see one of the port
| being blocked and the other forwarding. I can ping the
| board from a remote PC connected to the same switch.
|
|     _______ 1       _______       ____
|    |       |-------|       |_____|    |
|    | Board |xxx----|Switch |     | PC |
|    |_______|2      |_______|     |____|
|
|
| When I disconnect the cable from the forwarding port
| (port 1), I can see both the ports going into the
| forwarding state. However, when I try to ping the
| board again from the remote PC, I am not able to reach
| the board anymore. Sniffing the packets show that the
| board can receive arp requests on the port 2 but the
| arp response is not generated. Sniffing packets on the
| bridge interface show arp queries being sent to PC
| instead.
|
| Please help.
|
|
| --Prashant
|
It's possible I'm making this up, but could it perhaps be that the STP code is
detecting the loop and changing things to "fix" it? Does it work with STP turned
off?

- - Patrick Bogen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB5ACx7TVqlMhnUCYRApFoAJ0QdkZtOwmSyNJu38lL/qmOHUR5ugCbBWTR
P614viU1s8u3FVf2mkxKmxI=
=xNfH
-----END PGP SIGNATURE-----
