Return-Path: <jengelh@inai.de>
Date: Mon, 26 Aug 2019 09:59:33 +0200 (CEST)
From: Jan Engelhardt <jengelh@inai.de>
In-Reply-To: <20190730123542.zrsrfvcy7t2n3d4g@breakpoint.cc>
Message-ID: <nycvar.YFH.7.76.1908260955400.22383@n3.vanv.qr>
References: <20190730122534.30687-1-rdong.ge@gmail.com>
	<20190730123542.zrsrfvcy7t2n3d4g@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Bridge] [PATCH] bridge:fragmented packets dropped by bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>
Cc: Rundong Ge <rdong.ge@gmail.com>, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kadlec@netfilter.org, nikolay@cumulusnetworks.com, coreteam@netfilter.org, netfilter-devel@vger.kernel.org, kuznet@ms2.inr.ac.ru, davem@davemloft.net, pablo@netfilter.org


On Tuesday 2019-07-30 14:35, Florian Westphal wrote:
>Rundong Ge <rdong.ge@gmail.com> wrote:
>> Given following setup:
>> -modprobe br_netfilter
>> -echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
>> -brctl addbr br0
>> -brctl addif br0 enp2s0
>> -brctl addif br0 enp3s0
>> -brctl addif br0 enp6s0
>> -ifconfig enp2s0 mtu 1300
>> -ifconfig enp3s0 mtu 1500
>> -ifconfig enp6s0 mtu 1500
>> -ifconfig br0 up
>> 
>>                  multi-port
>> mtu1500 - mtu1500|bridge|1500 - mtu1500
>>   A                  |            B
>>                    mtu1300
>
>How can a bridge forward a frame from A/B to mtu1300?

There might be a misunderstanding here judging from the shortness of this
thread.

I understood it such that the bridge ports (eth0,eth1) have MTU 1500, yet br0
(in essence the third bridge port if you so wish) itself has MTU 1300.

Therefore, frame forwarding from eth0 to eth1 should succeed, since the
1300-byte MTU is only relevant if the bridge decides the packet needs to be
locally delivered.
