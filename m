Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DADC27CCEA
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644804; cv=none; b=Ay6BhQT4WlQGTyAWKO3UcE2iwqkNQCJUt7uWLSA4R4GRlvf8kYXkW0J1czng7bgGuPfKwK+S3Bt8H98xAcVoFRNgt6XtaNBdXcX97g0Zou0/diyDur+vxS54RVwVYFEaAU2y/SQ99bALXskK0V4yryTnfoRvqz/KIrMAbxYNo+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644804; c=relaxed/simple;
	bh=LnUumeNEdEHZqFIrLiHzMV5L1txyW+F+LXghYm2oaCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBAI/emDtK8UKAtuPeU17oB26SdkRTQLdxN4z/Nsf5AOhHp8lLSuwj4ZAZruZzFw0YNG/0OprCjFOoxbO4bTjIVYXwAyqyUN8JuxLCYftyLwgEOpYDxLyqaMBnaY6C+47lbTeLucKO6yTRRrUzyqgUw0jBT+KnOUO06MBfWZDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1710981F15
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:26:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.2
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9mebyTs1CzTp for <bridge@lists.linux-foundation.org>;
 Wed, 11 Jun 2025 12:26:41 +0000 (UTC)
X-Greylist: delayed 675 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 11 Jun 2025 12:26:40 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1B9C881E5E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B9C881E5E
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=f.pfitzner@pengutronix.de; receiver=<UNKNOWN> 
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1B9C881E5E
	for <bridge@lists.linux-foundation.org>; Wed, 11 Jun 2025 12:26:40 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1uPKXM-0000zY-3u; Wed, 11 Jun 2025 14:26:36 +0200
Message-ID: <73539d7f-75a9-4f52-a95c-b2b1a608fe6d@pengutronix.de>
Date: Wed, 11 Jun 2025 14:26:34 +0200
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bridge: dump mcast querier state per vlan
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com,
 bridge@lists.linux-foundation.org, entwicklung@pengutronix.de,
 razor@blackwall.org
References: <20250611121151.1660231-1-f.pfitzner@pengutronix.de>
 <aEl0eD0qm5xYgvE7@shredder>
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <aEl0eD0qm5xYgvE7@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bridge@lists.linux-foundation.org

On 6/11/25 14:20, Ido Schimmel wrote:
> On Wed, Jun 11, 2025 at 02:11:52PM +0200, Fabian Pfitzner wrote:
>> Dump the multicast querier state per vlan.
>> This commit is almost identical to [1].
>>
>> The querier state can be seen with:
>>
>> bridge -d vlan global
>>
>> The options for vlan filtering and vlan mcast snooping have to be enabled
>> in order to see the output:
>>
>> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
>>
>> The querier state shows the following information for IPv4 and IPv6
>> respectively:
>>
>> 1) The ip address of the current querier in the network. This could be
>>     ourselves or an external querier.
>> 2) The port on which the querier was seen
>> 3) Querier timeout in seconds
>>
>> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
>>
>> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
>> ---
>>
>> v1->v2
>> 	- refactor code
>> 	- link to v1: https://lore.kernel.org/netdev/20250604105322.1185872-1-f.pfitzner@pengutronix.de/
> Regarding your note on v1, there is a patch under review to add a bridge
> lib file:
>
> https://lore.kernel.org/netdev/8a4999a27c11934f75086354314269f295ee998a.1749567243.git.petrm@nvidia.com/
>
> Maybe wait until it's accepted and then submit v3 with a shared helper
> function?
Sounds good to me. I'll submit a v3 then.
>
-- 
Pengutronix e.K.                           | Fabian Pfitzner             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

