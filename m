Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2631946A0
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730327192; cv=none; b=XvBiOA22CN3fWl++Hvelwqn3sb4aFQLk/b7pxV60xac9Te4s+8T/vRHfulkc4hNZAIJNIFb+DiJapoH0TZC+wkcSUnEfP4atm45NL1sKy0GdQeyVvLwASyADQJesTVNlNPLNHzG0xT09clg7eKx17a8pWpPVtaI0GT4oegvn++4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730327192; c=relaxed/simple;
	bh=WdH+TAdRHqumVfw/fA8ZbJ0hs10NI2Ch5rbN3WE2XZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jydg/fNFVuN4WS7WuhWgE0Q0QquYQoNR58/ocAzsz92yUyM0ED1VrQ0BC2K5MVw1GIxb2OnsbEwq5+r7UDSvCkbi0Jn9wZO4dEBdLv/SHI/lFL2qn0Copd11lhoHF0lHtAPZWpfa28veGDQrbuJkwhChBO/IN8WD8qu9OeqOV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F088A400A6
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 22:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TxjLizNYiyHQ for <bridge@lists.linux-foundation.org>;
 Wed, 30 Oct 2024 22:26:29 +0000 (UTC)
X-Greylist: delayed 959 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 30 Oct 2024 22:26:28 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B961E400F5
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B961E400F5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=f.pfitzner@pengutronix.de; receiver=<UNKNOWN> 
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B961E400F5
	for <bridge@lists.linux-foundation.org>; Wed, 30 Oct 2024 22:26:28 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1t6GtW-00060z-Pf; Wed, 30 Oct 2024 23:10:26 +0100
Message-ID: <58d40a6c-7c42-4a46-8c9a-0da4a0c77380@pengutronix.de>
Date: Wed, 30 Oct 2024 23:10:26 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 iproute] bridge: dump mcast querier state
To: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org, entwicklung@pengutronix.de
References: <20241030084622.4141001-1-f.pfitzner@pengutronix.de>
 <f4efc424-6505-4e20-a9f2-14e973281921@blackwall.org>
Content-Language: de-DE, en-US
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <f4efc424-6505-4e20-a9f2-14e973281921@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bridge@lists.linux-foundation.org

> For the second time(!), please CC maintainers because it's very easy to
> miss a patch. In addition to maintainers, please CC reviewers of previous
> versions as well.
Could you please tell me at which mail addresses I should send the patch?
You said that I should send it to "the bridge maintainers" as well, so I 
put "bridge@lists.linux-foundation.org" into the CC this time.

On 10/30/24 4:29 PM, Nikolay Aleksandrov wrote:
> On 30/10/2024 10:46, Fabian Pfitzner wrote:
>> Kernel support for dumping the multicast querier state was added in this
>> commit [1]. As some people might be interested to get this information
>> from userspace, this commit implements the necessary changes to show it
>> via
>>
>> ip -d link show [dev]
>>
>> The querier state shows the following information for IPv4 and IPv6
>> respectively:
>>
>> 1) The ip address of the current querier in the network. This could be
>>     ourselves or an external querier.
>> 2) The port on which the querier was seen
>> 3) Querier timeout in seconds
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7fa1d9b1fb179375e889ff076a1566ecc997bfc
>>
>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>> ---
>>
>> v1->v2: refactor code
>>
>>   ip/iplink_bridge.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
> For the second time(!), please CC maintainers because it's very easy to
> miss a patch. In addition to maintainers, please CC reviewers of previous
> versions as well.
>
> Thank you,
>   Nik
>
>
>
