Date: Fri, 3 Dec 2004 10:42:40 -0500 (EST)
From: "Mark S. Mathews" <mark@linux-wlan.com>
Subject: Re: [Bridge] Bridge Performance 2
In-Reply-To: <41B07B61.9010603@student.ethz.ch>
Message-ID: <Pine.LNX.4.61.0412031042070.29578@chef.linux-wlan.com>
References: <41B07B61.9010603@student.ethz.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Patrick Stuedi <stuedip@student.ethz.ch>
Cc: bridge@lists.osdl.org


See the FAQ at http://bridge.sourceforge.net/faq.html for the answer.

-M

On Fri, 3 Dec 2004, Patrick Stuedi wrote:

> Hi there,
>
> I was asking this question already a few days go, but I'm not sure whether 
> anyone noticed due to the mailserver outtage. So I'm just re-posting it, 
> sorry, but it's an important issue for me, I would be glad to hear some 
> insight on this. 
> The question is regarding throughput performance using linux 2.4.5.1. My 
> setup is very simple : I have two laptops with a wireless card. On each 
> laptop I configure the wireless cards to be in ad hoc mode, create a bridge 
> and include the interface within the bridge (stp is off). Then of course I'm 
> assigning an IP address to the bridge while assigning 0.0.0.0 to the wireless 
> interface (eth1). After having setup both machines I run throughput tests 
> using iperf. What I measure is around 1.5 Mbit/s for TCP traffic. This is 
> about 1/3 of what I get when communicating directly through the wireless 
> interface on both machines, without any bridge on top. Where all this 
> performance gets lost? Does anyone have an idea? The same performance 
> degradation I measured on a 2.6 Kernel.
>
> Any help would be appreciated.
>
> Best Regards, Patrick
>
>
>

-- 

Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.linux-wlan.com
721-D North Drive          e-mail: mark@linux-wlan.com
Melbourne, FL 32934        Phone:  321.259.0737
USA                        Fax:    321.259.0286
