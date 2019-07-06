Return-Path: <wenxu@ucloud.cn>
References: <1562332598-17415-1-git-send-email-wenxu@ucloud.cn>
	<1562332598-17415-7-git-send-email-wenxu@ucloud.cn>
	<caaaa242-6bb8-9d5e-af66-a0cd6592f81d@cumulusnetworks.com>
From: wenxu <wenxu@ucloud.cn>
Message-ID: <83e9506d-8888-f841-f16c-0d038e52b39e@ucloud.cn>
Date: Sat, 6 Jul 2019 22:29:14 +0800
MIME-Version: 1.0
In-Reply-To: <caaaa242-6bb8-9d5e-af66-a0cd6592f81d@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH nf-next v2] netfilter:nft_meta: add
	NFT_META_VLAN support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, pablo@netfilter.org
Cc: bridge@lists.linux-foundation.org, netfilter-devel@vger.kernel.org


在 2019/7/6 20:02, Nikolay Aleksandrov 写道:
> On 05/07/2019 16:16, wenxu@ucloud.cn wrote:
>> From: wenxu <wenxu@ucloud.cn>
>>
>> This patch provide a meta vlan to set the vlan tag of the packet.
>>
>> for q-in-q outer vlan id 20:
>> meta vlan set 0x88a8:20
>>
>> set the default 0x8100 vlan type with vlan id 20
>> meta vlan set 20
>>
>> Signed-off-by: wenxu <wenxu@ucloud.cn>
>> ---
>>  include/net/netfilter/nft_meta.h         |  5 ++++-
>>  include/uapi/linux/netfilter/nf_tables.h |  4 ++++
>>  net/netfilter/nft_meta.c                 | 25 +++++++++++++++++++++++++
>>  3 files changed, 33 insertions(+), 1 deletion(-)
>>
> The patch looks fine, just a note: you'll only be able to work with the
> outer tag, so guessing to achieve a double-tagged frame you'll have to
> add another NFT_META_VLAN_INNER(?) and will have to organize them one
> after another.

yes, It's just set/mangle the meta vlan data. 
I think it's a good idear for stacked tagged with NFT_META_VLAN_INNER, in 
this case it should check the the proto of vlan tag already on packet
There are three case:
1. packet already contain a vlan header with proto 0x88a8, it should push the inner vlan tag
2. there is no outer vlan tag, maybe we should add a inner 0x8100 tag 
and outer 0x88a8 tag?
3.  packet already contain a vlan tag with proto 0x8100, push the vlan tag and add outer 0x88a8 tag ?

>
>
>
