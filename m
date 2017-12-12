Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=PBp2disfQfkGJ84yK1ZXB5o3ssOnT1JgjQLqEKj6748=;
	b=XuKYLgyLlhLciAy0+djDK+KMgIuoKrEFyqrdN6PDHYG4VYpp3BrEg9DA7HeEAHbtAx
	CtzPVoEiSN5A+tnBFgAklSfaEA025G5ASFD6Bi4iriqkXbr8uDN4VVxoHB+IGvTE2Hvb
	g1c2wGz/9tceeKF/MmVwy9F16HGHvtRMotZZM=
References: <1513087370-4791-1-git-send-email-nikolay@cumulusnetworks.com>
	<20171212100713.6c24c9c3@xeon-e3>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <c04ccce6-d98d-3624-39bf-439c5448f332@cumulusnetworks.com>
Date: Tue, 12 Dec 2017 20:16:48 +0200
MIME-Version: 1.0
In-Reply-To: <20171212100713.6c24c9c3@xeon-e3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: use rhashtable for fdbs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net, srn@prgmr.com

On 12/12/17 20:07, Stephen Hemminger wrote:
> On Tue, 12 Dec 2017 16:02:50 +0200
> Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
> 
>> Before this patch the bridge used a fixed 256 element hash table which
>> was fine for small use cases (in my tests it starts to degrade
>> above 1000 entries), but it wasn't enough for medium or large
>> scale deployments. Modern setups have thousands of participants in a
>> single bridge, even only enabling vlans and adding a few thousand vlan
>> entries will cause a few thousand fdbs to be automatically inserted per
>> participating port. So we need to scale the fdb table considerably to
>> cope with modern workloads, and this patch converts it to use a
>> rhashtable for its operations thus improving the bridge scalability.
>> Tests show the following results (10 runs each), at up to 1000 entries
>> rhashtable is ~3% slower, at 2000 rhashtable is 30% faster, at 3000 it
>> is 2 times faster and at 30000 it is 50 times faster.
>> Obviously this happens because of the properties of the two constructs
>> and is expected, rhashtable keeps pretty much a constant time even with
>> 10000000 entries (tested), while the fixed hash table struggles
>> considerably even above 10000.
>> As a side effect this also reduces the net_bridge struct size from 3248
>> bytes to 1344 bytes. Also note that the key struct is 8 bytes.
>>
>> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
>> ---
> 
> Thanks for doing this, it was on my list of things that never get done.
> 
> Some downsides:
>  * size of the FDB entry gets larger.

It does not, due to smp alignment of the write-heavy members we had a large
hole between cache line 1 and 2, the new 8 bytes fit perfectly and there are
still bytes left to use.

>  * you lost the ability to salt the hash (and rekey) which is important
>    for DDoS attacks

The hash is always salted (property of rhashtable) and in fact is better because
now the salt is generated for each rhashtable separately rather than having 1 global
salt for all bridge devices.

>  * being slower for small (<10 entries) also matters and is is a common
>    use case for containers.

I think they're pretty comparable in speed, the difference is negligible IMO.


