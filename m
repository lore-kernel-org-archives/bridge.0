Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=OBygPYoH9eOHMctG/tJ0Rr+r+PpqAulwebHK5F77MXU=;
 b=Ia7psltFGoptmW0526Vz++uGR6At0o1ULKvloYNv+OCuVIgA/EqAswUtc6HVrkzoto
 u4MyQU8VdPeGSuNanN4LqjudjLvopRJDKYoUsB4FRKaieWrALMWzwgHBUCUAcw/l6VM2
 V7NdmLPTPmYI5HabCRYTbO3FSswzV4S/0NnJFsO4SHDE5yYahaoKhnucNKR7+cS77KcZ
 aHMq5rpL1AbjfSzfBYqpU9MKvnSc6xYYfb02bnc4zaeDYgTQidX3mQRDDBnx3RJV+BDw
 o2vrqFC2ChxQFR4ROWHFP7/KGwjNogCOG52GJosICA+X8mA6OtVl+Vk6PKRVrCpCXC5Q
 np+Q==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <586b97b3-0882-b42c-20f8-275a05b51beb@blackwall.org>
References: <20220411133837.318876-1-troglobit@gmail.com>
 <20220411133837.318876-9-troglobit@gmail.com>
 <ebd182a2-20bc-471c-e649-a2689ea5a5d1@blackwall.org>
 <87v8ve9ppr.fsf@gmail.com>
 <5d597756-2fe1-e7cc-9ef3-c0323e2274f2@blackwall.org>
 <87pmll9xj1.fsf@gmail.com>
 <96bb8ff0-26d8-e9d3-e7c8-78f2abd28126@blackwall.org>
 <586b97b3-0882-b42c-20f8-275a05b51beb@blackwall.org>
Date: Wed, 13 Apr 2022 12:12:55 +0200
Message-ID: <87a6cp9tqw.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH RFC net-next 08/13] net: bridge: avoid
	classifying unknown multicast as mrouters_only
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Vladimir Oltean <vladimir.oltean@nxp.com>, Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Tobias Waldekranz <tobias@waldekranz.com>

On Wed, Apr 13, 2022 at 12:00, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 13/04/2022 11:55, Nikolay Aleksandrov wrote:
>> On 13/04/2022 11:51, Joachim Wiberg wrote:
>>> So, if I add a bridge flag, default off as you mentioned out earlier,
>>> which changes the default behavior of MCAST_FLOOD, then you'd be OK with
>>> that?  Something cheeky like this perhaps:
>>>     if (!ipv4_is_local_multicast(ip_hdr(skb)->daddr))
>>>        	BR_INPUT_SKB_CB(skb)->mrouters_only = !br_opt_get(br, BROPT_MCAST_FLOOD_RFC4541);
>> Exactly! And that is exactly what I had in mind when I wrote it. :)

Awesome, thank you! :)

> Just please use a different option name that better suggests what it does.

Heh, yeah spent a good while with my colleague (Tobias) thinking about
how to name this one.  I'll see what I can come up with, but whatever
shows up in the next patch iteration will be very open for discussion.

Cheers
 /Joachim
 
