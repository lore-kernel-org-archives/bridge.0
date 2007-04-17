Date: Mon, 16 Apr 2007 19:41:37 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070416194137.520714d8@localhost.localdomain>
In-Reply-To: <006901c78082$847f7d80$8d7e7880$@net>
References: <006901c78082$847f7d80$8d7e7880$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: bridge@linux-foundation.org

On Mon, 16 Apr 2007 18:54:04 -0500
"Fernando Rodriguez" <frod@aitelecom.net> wrote:

> Hello,
> 
>  
> 
> I currently run a bridge with mastershaper but I im having somme issues
> regarding the udp packets that are fragmented is seems that they are unable
> to cross the bridge as they should they reach the other side of the network
> unusable, I have been trying to read regarding this issue on internet but
> couldn't find any answers.
> 

Bridges don't fragment themselves. They drop packets if MTU is different.
That is part of the standard.


> 
> Those udp packets are sent via multicast on the network
> 
>  
> 
> Im currently running Kernel  2.6.18.3 and bridge utils bridge-utils-1.0.4-4.

There maybe issues with checksum offload with some drivers in that kernel
Try turning it off in the ethernet driver (see ethtool)
driver.
