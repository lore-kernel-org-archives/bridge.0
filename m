Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=jI+ia+CFNwEP8+o2FRfQ+lAuBa3i6IJeYEuyvtP9jQk=;
	b=WfcQEztQkVbL4QGxPNtqaY6sAMz+E5u48U+RDW09D32fahecZPGb8DK6UXCjQbCJlx
	Cl5tqtVeYkdNXbf3uQB4YW2C6UQHI3srsYaBt3UWC7WlJ5xWQzOjKc/ZAIHWw4ivxUZW
	PdWy4ateAv5aiLN8QZEcmEIf5egWpdPRZ3cPs=
References: <1472570588-32503-1-git-send-email-nikolay@cumulusnetworks.com>
	<1472570588-32503-3-git-send-email-nikolay@cumulusnetworks.com>
	<20160831013726.GD4883@otheros>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <7d1fc865-f092-5d9d-8f4c-f19aeac914c0@cumulusnetworks.com>
Date: Wed, 31 Aug 2016 08:02:22 +0200
MIME-Version: 1.0
In-Reply-To: <20160831013726.GD4883@otheros>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v2 2/2] net: bridge: add per-port
 multicast flood flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 31/08/16 03:37, Linus Lüssing wrote:
> On Tue, Aug 30, 2016 at 05:23:08PM +0200, Nikolay Aleksandrov via Bridge wrote:
>> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
>> index 1da3221845f1..ed0dd3340084 100644
>> --- a/net/bridge/br_if.c
>> +++ b/net/bridge/br_if.c
>> @@ -362,7 +362,7 @@ static struct net_bridge_port *new_nbp(struct net_bridge *br,
>>  	p->path_cost = port_cost(dev);
>>  	p->priority = 0x8000 >> BR_PORT_BITS;
>>  	p->port_no = index;
>> -	p->flags = BR_LEARNING | BR_FLOOD;
>> +	p->flags = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD;
> 
> I'm discontent with this new flag becoming the default.
> 
> Could you elaborate a little more on your use-case, when/why do
> you want/need this flag?
> 

The use case is the current default behaviour if we don't make this flag on by default
then we'll change user-visible default behaviour. Right now we flood unregistered mcast
traffic by default (if there's no querier and router port, which continues to function
as before). Also we have the port flags equal to BR_AUTO_MASK by default.

Cheers,
 Nik

