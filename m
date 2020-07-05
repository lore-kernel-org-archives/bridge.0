Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xt3dOuMU6eTwoXcY8IjEkhHFc+2w+XryW8TVkin2ZTU=;
 b=PokwTfkLrg/bmM8c13myLwZt3KcUH8zV5xC962EE89+3RJyCJybDmdF5P0hHyoiEBx
 SbDQTSK5sdWOGsabemoZqA3fkToEAqMR84VdCLxu97SpYIh+R1PmlFGfdHMbWHv14lKM
 VmH5/fBkrq8jmYeqHNu3qL2rAxPXJZXo2EyMY=
References: <20200705182234.10257-1-linus.luessing@c0d3.blue>
 <093beb97-87e8-e112-78ad-b3e4fe230cdb@cumulusnetworks.com>
 <20200705190851.GC2648@otheros>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4728ef5e-0036-7de6-8b6f-f29885d76473@cumulusnetworks.com>
Date: Sun, 5 Jul 2020 22:11:39 +0300
MIME-Version: 1.0
In-Reply-To: <20200705190851.GC2648@otheros>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net] bridge: mcast: Fix MLD2 Report IPv6
 payload length check
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: Martin Weinelt <martin@linuxlounge.net>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>

On 7/5/20 10:08 PM, Linus Lüssing wrote:
> On Sun, Jul 05, 2020 at 09:33:13PM +0300, Nikolay Aleksandrov wrote:
>> On 05/07/2020 21:22, Linus Lüssing wrote:
>>> Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
>>> igmp3/mld2 report handling") introduced a small bug which would potentially
>>> lead to accepting an MLD2 Report with a broken IPv6 header payload length
>>> field.
>>>
>>> The check needs to take into account the 2 bytes for the "Number of
>>> Sources" field in the "Multicast Address Record" before reading it.
>>> And not the size of a pointer to this field.
>>>
>>> Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report handling")
>>> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
>>> ---
>>>   net/bridge/br_multicast.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>
>> I'd rather be more concerned with it rejecting a valid report due to wrong size. The ptr
>> size would always be bigger. :)
>>
>> Thanks!
>> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> Aiy, you're right, it's the other way round. I'll update the
> commit message and send a v2 in a minute, with your Acked-by
> included.
> 

By the way, I can't verify at the moment, but I think we can drop that whole
hunk altogether since skb_header_pointer() is used and it will simply return
an error if there isn't enough data for nsrcs.

