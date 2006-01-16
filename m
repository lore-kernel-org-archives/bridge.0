Message-ID: <43CBC962.9070408@osdl.org>
Date: Mon, 16 Jan 2006 08:27:14 -0800
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Subject: Re: [Bridge] 1 system with 3 bridges
References: <43CBB729.9030007@phreaker.net>
In-Reply-To: <43CBB729.9030007@phreaker.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: ro0ot <ro0ot@phreaker.net>
Cc: bridge@lists.osdl.org

ro0ot wrote:

> Hi all,
>
> I have one bridge system (used for controlling bandwidth) connected to 
> three different DSL ISP provider.  I have the following setup below: -
>
> +-------------+
> |   br0             |
> |   -> eth1       | -> DSL_1
> |   -> eth2       |
> +-------------+
> |   br1             |
> |   -> eth3       | -> DSL_2
> |   -> eth4       |
> +-------------+
> |   br2             |
> |   -> eth5       | -> DSL_3
> |   -> eth6       |
> +-------------+
>
> br0 has eth1 and eth2; br0 has no ip address
>
> br1 has eth3 and eth4; br0 has no ip address
>
> br2 has eth5 and eth6; br0 has no ip address
>
> The traffic of DSL_1 ISP will pass thru br0.  The traffic of DSL_2 ISP 
> will pass thru br1.  The traffic of DSL_3 ISP will pass thru br2.
>
> I have a question.  Is it ok I do it as above in 1 system with 3 
> bridges or separate it to 3 system with each system have their own 
> bridge?
>
> Regards,
> ro0ot
>
One system with three bridges will work fine. The only advantage of 
separate systems would be the increased CPU and bandwidth available. As 
long as you are using a fast enough processor and memory, you should be 
fine. A normal 32 bit/33 Mhz PCI bus peaks at about 600 Mbits/sec. 
Double that for 64 bit and double again for 66 Mhz (PCI-X). PCI-express, 
not sure yet.
