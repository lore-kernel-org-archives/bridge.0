Return-Path: <gongruiqi1@huawei.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB93A611A9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC43360A6B
Message-ID: <e5624b47-52f1-e01c-6e5c-e8192132edf9@huawei.com>
MIME-Version: 1.0
Content-Language: en-US
References: <20230816093443.1460204-1-gongruiqi@huaweicloud.com>
 <ZNywHiWhaL6pRZsd@vergenet.net>
From: Gong Ruiqi <gongruiqi1@huawei.com>
In-Reply-To: <ZNywHiWhaL6pRZsd@vergenet.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] netfilter: ebtables: replace
 zero-length array members
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Wed, 16 Aug 2023 12:41:28 -0000
To: Simon Horman <horms@kernel.org>, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: coreteam@netfilter.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Florian Westphal <fw@strlen.de>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Pablo Neira Ayuso <pablo@netfilter.org>



On 2023/08/16 19:16, Simon Horman wrote:
> On Wed, Aug 16, 2023 at 05:34:43PM +0800, GONG, Ruiqi wrote:
>> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
>>
>> As suggested by Kees[1], replace the old-style 0-element array members
>> of multiple structs in ebtables.h with modern C99 flexible array.
>>
>> [1]: https://lore.kernel.org/all/5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org/
>>
>> Link: https://github.com/KSPP/linux/issues/21
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>>
>> v2: designate to net-next; cc more netdev maintainers
> 
> It's slightly unclear to me if this should be targeting
> net-next or nf-next. But regardless, it doesn't seem
> to apply cleanly to the main branch of either tree.

I find out that it's because this patch depends on a previous patch I've
just sent:

[v4] netfilter: ebtables: fix fortify warnings in size_entry_mwt()

Maybe I should make them two into a patch set? Otherwise if I adapt this
patch to net-next, it won't be applied either if the above patch is
applied ...

> 
> Please consider resolving that and posting again,
> being sure to allow 24h before postings.
> 
> Link: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
>
