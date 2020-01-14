Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V2/KACwQfuatGD6xiBWykj7BNbLnSCoeL08Mx230O9w=;
 b=KMHOAoyODqv/sIwy3dOoTEhjU3Z918xwkAGL76mJjmwpi2a3LbUK16dHfaL3Xaf4WK
 q4sgR/qtO07q+q7i699yKKMRfcTKsXsfvN0Pr70rsCT2nWjhzvMEj+VV7B6RBo/mGMHk
 5iAh92DBrZ1TS+8hwQcrAiK9UATl3+6N5Kpfg=
References: <20200113155233.20771-1-nikolay@cumulusnetworks.com>
 <20200113155233.20771-4-nikolay@cumulusnetworks.com>
 <20200114055544.77a7806f@cakuba.hsd1.ca.comcast.net>
 <076a7a9f-67c6-483a-7b86-f9d70be6ad47@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <00c4bc6b-2b31-338e-a9ad-b4ea28fc731c@cumulusnetworks.com>
Date: Tue, 14 Jan 2020 18:36:47 +0200
MIME-Version: 1.0
In-Reply-To: <076a7a9f-67c6-483a-7b86-f9d70be6ad47@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/8] net: bridge: vlan: add rtm
 definitions and dump support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 14/01/2020 17:34, David Ahern wrote:
> On 1/14/20 6:55 AM, Jakub Kicinski wrote:
>> On Mon, 13 Jan 2020 17:52:28 +0200, Nikolay Aleksandrov wrote:
>>> +static int br_vlan_rtm_dump(struct sk_buff *skb, struct netlink_callback *cb)
>>> +{
>>> +	int idx = 0, err = 0, s_idx = cb->args[0];
>>> +	struct net *net = sock_net(skb->sk);
>>> +	struct br_vlan_msg *bvm;
>>> +	struct net_device *dev;
>>> +
>>> +	if (cb->nlh->nlmsg_len < nlmsg_msg_size(sizeof(*bvm))) {
>>
>> I wonder if it'd be useful to make this a strict != check? At least
>> when strict validation is on? Perhaps we'll one day want to extend 
>> the request?
>>
> 
> +1. All new code should be using the strict checks.
> 

IIRC, I did it to be able to add filter attributes later, but it should just use nlmsg_parse()
instead and all will be taken care of.
I'll respin v2 with that change.

Thanks,
 Nik



