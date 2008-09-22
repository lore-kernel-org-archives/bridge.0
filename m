Date: Sun, 21 Sep 2008 22:51:32 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20080921225132.4fa4639f@extreme>
In-Reply-To: <48D6DF9D.10708@126.com>
References: <48D6DF9D.10708@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] 4 ports bridge problem
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: czj <linuxdemo@126.com>
Cc: bridge@lists.linux-foundation.org

On Mon, 22 Sep 2008 07:58:21 +0800
czj <linuxdemo@126.com> wrote:

> Hi all,
> I work on a SOC based on AMCC/glacier based on PPC460GT. (
> http://WWW.AMCC.com <http://micrel.com/page.do?page=product-info/sys_on_chip.jsp>)
> This component has 4 network interfaces. 
> 
> Every one is connected to a PC.
> 
> eth0 =>192.168.1.11
> eth1 => 192.168.1.22
> eth2 => 192.168.1.33
> eth3 => 192.168.1.44

You have layer 2 and 3 confused. Are you sure you don't intend
to route (layer 3) rather than bridging.

> I want to make a bridge with these 4 ports
> 
> #brctl addbr br0
> 
> #ifconfig br0 192.168.1.20 netmask 255.255.255.0
> 
> #ifconfig eth0 0.0.0.0 up
> 
> #ifconfig eth1 0.0.0.0 up
> 
> #ifconfig eth2 0.0.0.0 up
> 
> #ifconfig eth3 0.0.0.0 up
> 
> # brctl addif br0 eth0
> 
> # brctl addif br0 eth1
> 
> # brctl addif br0 eth2
> 
> # brctl addif br0 eth3
> 
> #brctl stp on
> 
> but my problem is that when I used the PC(which IP is 192.168.1.11/24) to ping other PCs,
> 
> the ping reply time from 192.168.1.22 was about 1000ms;
> the ping reply time from 192.168.1.33 was about 0.2ms;
> the ping reply time form 192.168.1.44 was about 300ms;
> 
> Why? and how to configure  the 4 ethernet-ports glacier board to be a bridge or switch correctly? thanks a lot.

Don't assign IP addresses to the ethernet devices, only one common address
to the bridge. 
