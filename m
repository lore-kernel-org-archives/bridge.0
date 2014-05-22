Return-Path: <davidn@davidnewall.com>
Message-ID: <537D73ED.4010400@davidnewall.com>
Date: Thu, 22 May 2014 13:20:05 +0930
From: David Newall <davidn@davidnewall.com>
MIME-Version: 1.0
References: <537621AC.1060409@davidnewall.com>
	<5379FFFD.1050705@davidnewall.com>
	<20140519140119.GA24523@breakpoint.cc>
	<537A12EA.4060604@davidnewall.com>
	<20140519170915.GB24523@breakpoint.cc>
	<537A6E5C.6090602@pandora.be> <537C5A6C.3030809@davidnewall.com>
	<537CF5A2.3080401@pandora.be>
In-Reply-To: <537CF5A2.3080401@pandora.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Revert 462fb2af9788a82a534f8184abfde31574e1cfa0
 (bridge : Sanitize skb before it enters the IP stack)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Bart De Schuymer <bdschuym@pandora.be>, Florian Westphal <fw@strlen.de>, "David S. Miller" <davem@davemloft.net>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

On 22/05/14 04:21, Bart De Schuymer wrote:
> There's no reason why they should overlap in the cb: it's 48 bytes 
> big, so big enough to hold both struct br_input_skb_cb and struct 
> inet_skb_parm.

No reason, aside from the math, I think.  Those 48 bytes appear to be 
used for 16 bytes of ip_options plus up to 40 bytes of options data, so 
we're using pretend-space; of which we'd need more to squeeze 
br_input_skb_cb in at the same time.

I hate opening a second can of worms, but, if I read this right, IPCB is 
quite, quite broken.


> As for your other remark: as I've said before, if you don't like 
> bridge-netfilter then don't compile it into your kernel.

That's not very helpful.  I could say, with just as much merit, that it 
should be marked deprecated (so that it's not compiled into distribution 
kernels) and you can compile it into yours.

What I dislike is that bridge-netfilter is faulty.
