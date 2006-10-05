Date: Thu, 5 Oct 2006 07:39:53 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20061005073953.4a8bdd6b@localhost.localdomain>
In-Reply-To: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>
References: <4c9f8dc30610042120o3089cbf6yaaa00728b271953f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Bridge Woes...
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris U <chris.uyehara@gmail.com>
Cc: bridge@lists.osdl.org

On Wed, 4 Oct 2006 18:20:43 -1000
"Chris U" <chris.uyehara@gmail.com> wrote:

> Hi List,
> 
> I have setup a bridge labeled br0. br0 has an ip address assigned to it. My
> network looks something similar to this...
> 
> |--------------------|                |--------------------|
> |------------------|
> |      laptop        |                |      bridge        |
> |     router       |
> | 128.171.103.10/24  |  ----->  (eth1)| 128.171.103.11/24  |(eth0)  ----->
> | 128.171.103.1/24 |
> | statically assignd |                | statically assignd |
> | tested / working |
> |--------------------|                |--------------------|
> |------------------|
> 
> Now for the PROBLEM! The bridge can access IP's outside of the subnet via
> eth0 of the bridge, ie - pinging 128.171.1.1, 128.171.3.13, 64.233.167.99.
> The laptop cannot ping the previously listed IPs. The only thing the laptop
> can ping is 128.171.103.11. It's very odd... I tried running tcpdump on the
> bridge. From the bridge I could see the laptop pinging the bridge but I
> couldn't see the laptop pinging any other IPs. So basically I have a bridge
> that's not really working but the bridge utils show that its working... any
> help would be greatly appreciated!
> 
> (The laptop works when taken off the bridge and connected to the router, the
> iptables default policy is ACCEPT and the rules are FLUSHED.)
> 
> Thanks for taking time to read this!
> 
> ###brctl show br0
> bridge name     bridge id               STP enabled     interfaces
> br0             8000.001372fc8436       no              eth0
>                                                         eth1
> 
> ###brctl showstp br0
> br0
>  bridge id              8000.001372fc8436
>  designated root        8000.001372fc8436
>  root port                 0                    path cost                  0
>  max age                  19.99                 bridge max age
> 19.99
>  hello time                1.99                 bridge hello time
> 1.99
>  forward delay            14.99                 bridge forward delay
> 14.99
>  ageing time             299.95
>  hello timer               0.03                 tcn timer
> 0.00
>  topology change timer     0.00                 gc timer
> 7.97
>  flags
> 
> 
> eth0 (1)
>  port id                8001                    state
> forwarding
>  designated root        8000.001372fc8436       path cost                100
>  designated bridge      8000.001372fc8436       message age timer
> 0.00
>  designated port        8001                    forward delay timer
> 0.00
>  designated cost           0                    hold timer
> 0.00
>  flags
> 
> eth1 (2)
>  port id                8002                    state
> forwarding
>  designated root        8000.001372fc8436       path cost                100
>  designated bridge      8000.001372fc8436       message age timer
> 0.00
>  designated port        8002                    forward delay timer
> 0.00
>  designated cost           0                    hold timer
> 0.00
>  flags


How are you setting IP addresses on the bridge.
You need to NOT assign IP addresses to eth0, eth1 and assign
an IP address to bridge pseudo device.

What kernel version?
What hardware is being used for eth0 and eth1? Are either one
of these wireless (802.11) devices?
