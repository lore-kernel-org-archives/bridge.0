Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=OyCnuCG6AS2P1i2XtRCcTuDofsx+cFMFYugIhGVPNfg=;
	b=bjP7pZapEbliP/nuHv8l3nVg6wD1X38QdKErf+W4dQAvHUU3zzo110aKn3ACDkq/NB
	3mpmg/sGDyK9DFmjbQvGnSU0EgzhswR6SVpaClhtcC5Fxh5qAsO1hEEWS3kSlhI4cViS
	mHWFfxAVgC2eZeUlTKyvXpm4GJ9T3Hj+VcjMw=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20190215130427.29824-1-nikolay@cumulusnetworks.com>
	<20190215171332.GA1472@otheros>
	<479a1acf-c7f3-4e6f-4246-e1583e98d356@cumulusnetworks.com>
Message-ID: <733b151e-47dd-ad9a-b112-473cf551fbeb@cumulusnetworks.com>
Date: Sat, 16 Feb 2019 10:35:32 +0200
MIME-Version: 1.0
In-Reply-To: <479a1acf-c7f3-4e6f-4246-e1583e98d356@cumulusnetworks.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH RFC] net: bridge: don't flood known multicast
 traffic when snooping is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com, davem@davemloft.net

On 16/02/2019 10:05, Nikolay Aleksandrov wrote:
> On 15/02/2019 19:13, Linus Lüssing wrote:
>> On Fri, Feb 15, 2019 at 03:04:27PM +0200, Nikolay Aleksandrov wrote:
>>> Every user would expect to have traffic forwarded only to the configured
>>> mdb destination when snooping is enabled, instead now to get that one
>>> needs to enable both snooping and querier. Enabling querier on all
>>> switches could be problematic and is not a good solution,
>>
>> There is no need to set the querier on all snooping switches.
>> br_multicast_querier_exists() checks if a querier exists on the
>> link in general, not if this particular host/bridge is a querier.
>>
> 
> We need a generic solution for the case of existing mdst and no querier.
> More below.
> 
>>
>>> for example as summarized by our multicast experts:
>>> "every switch would send an IGMP query
>>
>> What? RFC3810, section 7.1 says:
>>
>> "If it is the case, a querier election mechanism (described in
>>  section 7.6.2) is used to elect a single multicast router to be
>>  in Querier state. [...] Nevertheless, it is only the [elected] Querier
>>  that sends periodical or triggered query messages on the subnet."
>>>> for any random multicast traffic it
>>> received across the entire domain and it would send it forever as long as a
>>> host exists wanting that stream even if it has no downstream/directly
>>> connected receivers"
>>
> 
> This was taken out of context and it's my bad, I think everyone is aware
> of the election process, please nevermind the above statement.
> 
> [snip]> 
>>
>> Have you done some tests with this change yet, Nikolay?
>>
> 
> You've raised good questions, IPv6 indeed needs more work - we'll have to flood
> link-local packets etc. but I wanted to have a discussion about no querier/existing mdst.
> To simplify we can modify the patch and have traffic forwarded to the proper ports when an
> mdst exists and there is no querier for both unsolicited report and user-added entry.

To add a bit more:
"- no querier exists on the link
- one port gets an unsolicited MLD report, i.e. because a host has just
  started to listen to a particular multicast address
=> will only this port receive multicast traffic? what happens to
   other ports that have listeners for the same multicast group?"

Correct, only the interested ports (where reports have been seen or the user has
added them) will get the traffic. We could also consider having this only
for user-added mdsts, I'll have to think more about that.

> We can keep the current behaviour for unknown traffic with and without querier.
> This would align it closer to what other vendors currently do as well IIRC.
> What do you think ?
> 
> Thanks,
>  Nik
> 

