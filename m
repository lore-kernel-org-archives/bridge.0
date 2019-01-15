Return-Path: <makita.toshiaki@lab.ntt.co.jp>
References: <1547521959-3736-1-git-send-email-wangyunjian@huawei.com>
From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Message-ID: <fec59e13-bf9b-9bce-c662-3e044ade6c33@lab.ntt.co.jp>
Date: Tue, 15 Jan 2019 16:49:56 +0900
MIME-Version: 1.0
In-Reply-To: <1547521959-3736-1-git-send-email-wangyunjian@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: Fix ethernet header
 pointer before check skb forwardable
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wangyunjian <wangyunjian@huawei.com>
Cc: Nkolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, xudingke@huawei.com

On 2019/01/15 12:12, wangyunjian wrote:
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> The skb header should be set to ethernet header before using
> is_skb_forwardable. Because the ethernet header length has been
> considered in is_skb_forwardable(including dev->hard_header_len
> length).
> 
> To reproduce the issue:
> 1, add 2 ports on linux bridge br using following commands:
> $ brctl addbr br
> $ brctl addif br eth0
> $ brctl addif br eth1
> 2, the mtu of eth0 and eth1 is 1500
> 3, send a 1504 packet from eth0 to eth1
> 
> So the expect result is packet larger than 1500 cannot pass through
> eth0 and eth1. But currently, the packet passes through success, it
> means eth1's mtu limit donen't take effect.

I agree with the change but this test does not look appropriate.
In the first place is_skb_forwardable() accepts 4 bytes extra size (for
VLAN header). Doesn't your test case fail even after the change?

-- 
Toshiaki Makita

