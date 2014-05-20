Return-Path: <davidn@davidnewall.com>
Message-ID: <537AD2AC.4050009@davidnewall.com>
Date: Tue, 20 May 2014 13:27:32 +0930
From: David Newall <davidn@davidnewall.com>
MIME-Version: 1.0
References: <537621AC.1060409@davidnewall.com>
	<5379FFFD.1050705@davidnewall.com>
	<20140519140119.GA24523@breakpoint.cc>
	<537A12EA.4060604@davidnewall.com>
	<20140519170915.GB24523@breakpoint.cc>
In-Reply-To: <20140519170915.GB24523@breakpoint.cc>
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
To: Florian Westphal <fw@strlen.de>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Netdev <netdev@vger.kernel.org>, bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org

On 20/05/14 02:39, Florian Westphal wrote:
>  From a quick glance, it should be sufficient to edit
> br_parse_ip_options() and remove everything after
>
> memset(IPCB(skb), 0, sizeof(struct inet_skb_parm));

Yes.  That's the way it used to be, and how it would return with the 
change I'm proposing.  The br_parse_ip_option function would be removed 
and its remaining code moved back from whence it came.


> A 2nd step would be to move a copy of ip_options_compile()
> into br_netfilter.c and trim it down to only validate the
> ipv4 header without modifying it.

The bridge sounds like the wrong place to validate an IPv4 header, 
unless it also validates every type of header; and that can't be right.  
That we need to zero the cb area seems like a big clue that IP's 
treatment of the area is lame.  I think that's where the problem lies, 
and that the right thing to do is to yank out the crap from bridge that 
papers over IP's weakness.
