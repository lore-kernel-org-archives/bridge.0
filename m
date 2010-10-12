Message-ID: <4CB46549.2070901@ti-wmc.nl>
Date: Tue, 12 Oct 2010 15:40:25 +0200
From: Michel Lammertink <mlammertink@ti-wmc.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Why should static MAC address match one of the port MAC
	addresses.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,

I've read many messages on this mailing list with the question about
setting a static MAC address on the bridge interface, but two questions
remain:

 1. Why should the MAC address of the bridge match the address of one of
its interfaces? Setting the MAC address to a different value does not
generate an error, but the bridge is not working properly (Local data
does not arrive).

 2. Why does the bridge by default choose the "lowest" MAC address,
instead of the MAC address of the first port added, as is proposed by
the standard [1]?

[1] IEEE802.1D, Par. 7.12.5.
    Quote: "The Bridge Address may be the individual MAC Address of a
Bridge Port, in which case, use of the address of the lowest numbered
Bridge Port (Port 1) is recommended."

Thanks in advance,

Michel.
