Date: Thu, 27 Sep 2007 16:55:36 +0200 (CEST)
From: Jan Engelhardt <jengelh@computergmbh.de>
In-Reply-To: <20070927075102.4335a263@freepuppy.rosehill>
Message-ID: <Pine.LNX.4.64.0709271654270.30621@fbirervta.pbzchgretzou.qr>
References: <46FA2C17.76E4.0078.0@novell.com>
	<20070926083705.6bc65ea5@fujitsu-loaner>
	<E1Iae5t-0007Sk-Vu@flower> <20070926140608.6e6d3d0c@freepuppy.rosehill>
	<Pine.LNX.4.64.0709270017120.17414@fbirervta.pbzchgretzou.qr>
	<20070926153330.77aade4d@freepuppy.rosehill>
	<46FB99EF.4020806@aitel.hist.no>
	<20070927075102.4335a263@freepuppy.rosehill>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bridge] Re: why network devices don't do reference counting? (Re:
 [PATCH]
 Module use count must be updated as bridges are created/destroyed)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <shemminger@linux-foundation.org>
Cc: Oleg Verych <olecom@flower.upol.cz>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@novell.com>, Helge Hafting <helge.hafting@aitel.hist.no>


On Sep 27 2007 07:51, Stephen Hemminger wrote:
>
>You need every socket to close and all routes to go away including the 
>routes through loopback device, and still there probably are control 
>sockets buried inside ipv6 that hold ref count.
>
>IMHO the kernel should just admit that IPV6 can't be removed.

I cannot accept that. If ipv6.ko has a way to tack ipv6 structs onto all 
sockets, interfaces and addresses, it should also be able to untack it 
again.
