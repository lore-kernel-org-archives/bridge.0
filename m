Message-ID: <3357.78.42.24.243.1212696483.squirrel@postamt.eit.uni-kl.de>
Date: Thu, 5 Jun 2008 22:08:03 +0200 (CEST)
From: "Faruk Keskin" <faruk@eit.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Bridge] VLAN-aware bridge : [PATCH] Add vlan id to bridge forward
	database
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>
Cc: jaime.medrano@gmail.com

Hello everybody, hi Jaime,

I'm mailing to get more information about whether your patch
[PATCH] Add vlan id to bridge forward database
has been accepted so far.
I couldn't find the patched version yet - could you please tell me where I
can get the latest version of the patch or point out a reference to it ?

Has the vlan-aware bridge forwarding already been tested ?

And how about forwarding tagged packets ?
Until now, the bridge always stripped off the tag if present.

I'm currently thinking about extending the sk_buff data structure to
incorporate the vlan tag - to keep the VLAN information present when
exchanging packets from or to the bridge with the 8021q module and also
when a socket is bind to a interface (extending the sockaddr_ll struct in
that case).

Do you think thats's a sane approach ?

Thanks in advance, Faruk





