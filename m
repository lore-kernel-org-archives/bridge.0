Message-ID: <4624B133.3030104@trash.net>
Date: Tue, 17 Apr 2007 13:36:19 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <006901c78082$847f7d80$8d7e7880$@net>
In-Reply-To: <006901c78082$847f7d80$8d7e7880$@net>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] UDP Framgment
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Fernando Rodriguez <frod@aitelecom.net>
Cc: bridge@osdl.org

Fernando Rodriguez wrote:
> I currently run a bridge with mastershaper but I im having somme issues
> regarding the udp packets that are fragmented is seems that they are unable
> to cross the bridge as they should they reach the other side of the network
> unusable, I have been trying to read regarding this issue on internet but
> couldn't find any answers.


Possibly related to connection tracking, it defragments packets.
Try "echo 0 > /proc/sys/net/bridge/bridge-nf-call-iptables".

