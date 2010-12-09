Date: Thu, 9 Dec 2010 08:30:43 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20101209083043.3fe6d7e1@nehalam>
In-Reply-To: <OFD643E4FF.BA761D6E-ON652577F4.004E3BAB-652577F4.00593751@tcs.com>
References: <OFD643E4FF.BA761D6E-ON652577F4.004E3BAB-652577F4.00593751@tcs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] ksoftirqd process
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pravin Pardeshi <pravin.pardeshi@tcs.com>
Cc: bridge@lists.linux-foundation.org

On Thu, 9 Dec 2010 21:44:28 +0530
Pravin Pardeshi <pravin.pardeshi@tcs.com> wrote:

> Hi,
> I want to have bridge for two NICs (eth0 and eth1) with Knoppix 6.2 Live CD on virtualbox. I tried the following commands;
>  
> # brctl addbr br0
> # brctl sethello 30
> # brctl stp br0 off
>  
> # ifconfig eth0 0.0.0.0
> # ifconfig eth1 0.0.0.0
> # ifconfig eth0 down
> # ifconfig eth1 down
>  
> # brctl addif br0 eth0
> # brctl addif br0 eth1
>  
> After the addition of eth0 and eth1 to the bridge, the ksoftirq gets kicked off and starts consuming CPU. The connection to network is lost. The CPU utilization never stabilizes even after waiting for 10-15 minutes. Knoppix 6.2 has kernel 2.6.32.6 and bridge-utils is the latest version from debian repositories.
>  
> Firstly, am I missing something?
> Secondly, is it possible to have a setup I am attempting with the live cd? 
>  
> Thanks,
> Pravin

You probably created a network loop. And you turned STP off
so it can't be detected.

-- 
