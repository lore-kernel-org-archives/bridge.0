Message-ID: <446C9333.90608@candelatech.com>
Date: Thu, 18 May 2006 08:30:59 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
Subject: Re: [Bridge] VLAN translation + PVST+
References: <446BC951.2050803@us.checkpoint.com>
	<20060518143959.GB21325@tuxdriver.com>
In-Reply-To: <20060518143959.GB21325@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: bridge@lists.osdl.org

John W. Linville wrote:
> On Wed, May 17, 2006 at 06:09:37PM -0700, Ian Schwimmer wrote:
> 
>>Hello, I am creating a configuration where a Redhat server running 
>>bridge-tools 0.9.5 will be bridging between different VLANs on the same 
>>physical interface (for example: a bridge consisting of eth1.100 and 
>>eth1.110). This physical interface is being connected to modern Cisco 
>>switches running PVST+.
> 
> 
> I'm curious as to how this is useful?  What is the point of having
> two VLANs on the same segment if you are just going to bridge them
> together?  Is this useful for something beyond some sort of migration?

You can add a bridge group for 10 vlans, and route them to another bridge
group of 10 VLANs.  You can also enforce firewall rules on particular
VLANs (ie, could put each customer on individual VLAN, and backhaul them
all to one linux box to bridge/firewall/bill/etc them...)

Ben

> 
> Curious,
> 
> John
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

