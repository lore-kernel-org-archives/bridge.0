Return-Path: <prvs=616840f11=julien.grall@citrix.com>
Message-ID: <55927095.1060607@citrix.com>
Date: Tue, 30 Jun 2015 11:33:57 +0100
From: Julien Grall <julien.grall@citrix.com>
MIME-Version: 1.0
References: <55916C5D.3080602@citrix.com> <20150629185525.GF2324@breakpoint.cc>
In-Reply-To: <20150629185525.GF2324@breakpoint.cc>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [Xen-devel] Unable to unregister netdevice after
 "netfilter: bridge: forward IPv6 fragmented packets"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Westphal <fw@strlen.de>
Cc: Wei Liu <wei.liu2@citrix.com>, Ian Campbell <ian.campbell@citrix.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, bernhard.thaler@wvnet.at, xen-devel <xen-devel@lists.xenproject.org>, pablo@netfilter.org, David Vrabel <david.vrabel@citrix.com>

Hi Florian,

On 29/06/15 19:55, Florian Westphal wrote:
> Julien Grall <julien.grall@citrix.com> wrote:
>> I tried to run the latest Linux tree
>> (4a10a91756ef381bced7b88cfb9232f660b92d93) as DOM0 Xen.
>> After destroying a guest using network, I got the following
>> lines in the DOM0 kernel log:
>>
>> unregister_netdevice: waiting for vif1.0 to become free. Usage count = 1
>>
>> The bisector pointed the problem after the commit
>> efb6de9b4ba0092b2c55f6a52d16294a8a698edd
>> "netfilter: bridge: forward IPv6 fragmented packets".
> 
> Seems we can leak skb in br_nf_dev_queue_xmit()...  Does this fix the problem?

It doesn't resolve the problem. I added some printk to see if the fixed
paths are executed and I don't see any.

Regards,


-- 
Julien Grall
