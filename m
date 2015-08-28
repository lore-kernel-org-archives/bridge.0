Return-Path: <toshiaki.makita1@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=XspkDDNqsnhcEZgc4i5AQrrzEWEJFEAPEU7laYhylq0=;
	b=QgPNF7PHBjPbCfg9o9ie/QgeXupVg605TjFtZxotRjb6ffWnk33etpV1HI4IG0ucs1
	IHAv833nrwujTM0025QpDAf9r7QH8rIcSiPrC9WhXLaftxV2ehX06m+fWzrT4nf0EnWt
	OkvrLDzxt1GHSqD/cginnd+hAeaTE90hmQ+/iO3bhC2tOBI742qkeKSgw+O/zYqn8pqF
	mp0UzcZS0/pPUiq/yPizczv3+rem1HxPe52EO9UBQTdXtkp8jLZi8FMNQFhRmpiazMKk
	0tHAWPrb5VWkRk6FdFpu8KST9EM/LTjZ3c0nql1e59276s3D7BJDA1S9Am9Qt0YGRn6t
	BnLQ==
Message-ID: <55E040A9.8040707@gmail.com>
Date: Fri, 28 Aug 2015 20:06:17 +0900
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
MIME-Version: 1.0
References: <1440655205-14247-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<63AC6A69-F9A1-4A83-8EF7-D897243743B4@cumulusnetworks.com>
In-Reply-To: <63AC6A69-F9A1-4A83-8EF7-D897243743B4@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] bridge: Add netlink support for
 vlan_protocol attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>

On 15/08/28 (金) 0:48, Nikolay Aleksandrov wrote:
>
>> On Aug 26, 2015, at 11:00 PM, Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp> wrote:
>>
>> This enables bridge vlan_protocol to be configured through netlink.
>>
>> When CONFIG_BRIDGE_VLAN_FILTERING is disabled, kernel behaves the
>> same way as this feature is not implemented.
>>
>> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
>> ---
>> include/uapi/linux/if_link.h |  1 +
>> net/bridge/br_netlink.c      | 34 ++++++++++++++++++++++++++++++++++
>> net/bridge/br_private.h      |  1 +
>> net/bridge/br_vlan.c         | 35 +++++++++++++++++++++--------------
>> 4 files changed, 57 insertions(+), 14 deletions(-)
>>
>
> Nice, looks good. I have a similar patch as well and was going to ask wouldn’t it be
> better to make empty stubs which return an error when vlan filtering isn’t configured
> and drop the ifdefs in the netlink handling code ?
> Similar to how vlan_filtering netlink attribute is handled in commit:
> a7854037da00 ("bridge: netlink: add support for vlan_filtering attribute”)
>
> Potential problem would be the return of the protocol, but I think if 0 is returned that
> can be handled.

This is the exact reason why I didn't implement the stub.
I wanted to avoid to charge userspace with that special casing 0.
Also, this is consistent with sysfs implementation, which doesn't expose 
vlan_* entries when CONFIG_BRIDGE_VLAN_PROTOCOL is disabled.

Toshiaki Makita
