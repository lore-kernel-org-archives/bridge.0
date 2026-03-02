Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63F2C032E
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474667; cv=none; b=XXBigMCtgQhg5ezPyLqkmU2gl3jIg7qAiDzJ6aTyfnPlrkAKOABost/WOOy7dP6WJP8Kblo1J0NAqTG54rQJqStco5Eo6fvoQAZfljRfrX8SkbY7cvTQRfR3hzhjc8QdGHtAj7tAMszHBPCZUzsjLuu+KJol2oZ+CeReCMkm/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474667; c=relaxed/simple;
	bh=R1Dbvh1pmboUcYuJFEcOO/GfLAD+e/fedUvedqlpCH4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hbov4IVIbC4E+u+FDaAkVU7lG4ivfEGXxrPXO1b2KIPrne4u9EMczMRltY2tBw0GVEBit7TrJjdhWYl58T8OvgyIjKoqLxhj0i/0cZSKxc7Ylz9CWpFqTP8fd1Ll9FbMlMXvMrLixUUyk/z/ogJ1pg0NqTE5t/ALS1dH3v5de7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h8ZFTM9y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8KRcdpIm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h8ZFTM9y; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8KRcdpIm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h8ZFTM9y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8KRcdpIm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h8ZFTM9y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8KRcdpIm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E7373F7CF;
	Mon,  2 Mar 2026 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772474664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3QPaiyhHD+sQ1UXL7Oz94+5X44amwAjUKqLsSP2Szo=;
	b=h8ZFTM9yS4OUgkRKD3J8i4kMQ49reKUwyv7g0PFVyPcaVIF+7S+vH7jjd7gub3d1Q8qI6H
	Q5E+FeVcVk/eSlOJjH8IpYSZH64q8Hr00aP5j6Mm/X8KHK3GaT4n3NmFdx16PEQuJEC2/j
	N3DfH88BcAQ0ciYK3zPGgvwDoXfGe4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772474664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3QPaiyhHD+sQ1UXL7Oz94+5X44amwAjUKqLsSP2Szo=;
	b=8KRcdpImcGE7uCpHgB9Bwlro7L070aWgD+bwvI+2UJelYE6/fxLs6yRB6mrNXtLl0ZjwOs
	I5mQZZi6wDzuhsBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772474664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3QPaiyhHD+sQ1UXL7Oz94+5X44amwAjUKqLsSP2Szo=;
	b=h8ZFTM9yS4OUgkRKD3J8i4kMQ49reKUwyv7g0PFVyPcaVIF+7S+vH7jjd7gub3d1Q8qI6H
	Q5E+FeVcVk/eSlOJjH8IpYSZH64q8Hr00aP5j6Mm/X8KHK3GaT4n3NmFdx16PEQuJEC2/j
	N3DfH88BcAQ0ciYK3zPGgvwDoXfGe4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772474664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3QPaiyhHD+sQ1UXL7Oz94+5X44amwAjUKqLsSP2Szo=;
	b=8KRcdpImcGE7uCpHgB9Bwlro7L070aWgD+bwvI+2UJelYE6/fxLs6yRB6mrNXtLl0ZjwOs
	I5mQZZi6wDzuhsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C98E43EA69;
	Mon,  2 Mar 2026 18:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RBdKLifRpWkKHAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 02 Mar 2026 18:04:23 +0000
Message-ID: <853cf5a5-1c4e-43e5-b1fb-38c986488ba8@suse.de>
Date: Mon, 2 Mar 2026 19:04:14 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net v2] net: vxlan: fix nd_tbl NULL dereference when
 IPv6 is disabled
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, roopa@cumulusnetworks.com, sdf@fomichev.me,
 petrm@nvidia.com, horms@kernel.org, razor@blackwall.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20260302140847.5941-1-fmancera@suse.de>
 <20260302140847.5941-2-fmancera@suse.de> <aaWiH5KBf-n1NxAR@krikkit>
 <c2e08123-9338-4836-82e7-f47eb344f41f@suse.de>
 <20260302163643.GA971179@shredder>
 <fd8370d6-b163-45ac-9e6c-24046f46539e@suse.de>
Content-Language: en-US
In-Reply-To: <fd8370d6-b163-45ac-9e6c-24046f46539e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 3/2/26 6:44 PM, Fernando Fernandez Mancera wrote:
> On 3/2/26 5:36 PM, Ido Schimmel wrote:
>> On Mon, Mar 02, 2026 at 04:13:14PM +0100, Fernando Fernandez Mancera 
>> wrote:
>>> On 3/2/26 3:43 PM, Sabrina Dubroca wrote:
>>>> 2026-03-02, 15:08:47 +0100, Fernando Fernandez Mancera wrote:
>>>>> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
>>>>> initialized because inet6_init() exits before ndisc_init() is called
>>>>> which initializes it. If an IPv6 packet is injected into the 
>>>>> interface,
>>>>> route_shortcircuit() is called and a NULL pointer dereference 
>>>>> happens on
>>>>> neigh_lookup().
>>>>
>>>> VXLAN can be built-in even when IPv6 is built as a module, and then
>>>> ipv6_mod_enabled can't be used in VXLAN:
>>>>
>>>> ld: drivers/net/vxlan/vxlan_core.o: in function `route_shortcircuit':
>>>> drivers/net/vxlan/vxlan_core.c:2133:(.text+0x116e0): undefined 
>>>> reference to `ipv6_mod_enabled'
>>>>
>>>>
>>>> GENEVE has a Kconfig tweak to prevent this since 094be0927ff3
>>>> ("geneve: fix build with modular IPV6"):
>>>>
>>>>       depends on IPV6 || !IPV6
>>>>
>>>> but VXLAN doesn't.
>>>>
>>>
>>> Ugh, good catch. Thanks Sabrina.
>>>
>>>> But then I think we don't need to use ipv6_stub at all.
>>>
>>> If we enforce "depends on IPV6 || IPV6=n" on VXLAN we could get rid of
>>> ipv6_stub completely and use direct calls instead.
>>
>> I just noticed that this is already enforced for the bridge, so maybe
>> you can just remove ipv6_stub in patch #1?
>>
> 
> Yes, after Sabrina mentioned it that was what I planned to do. But on 
> VXLAN I want to avoid such patch for net tree as a fix. Instead I 
> propose to use the __in6_dev_get() check as neigh_reduce() does. Later, 
> do a follow-up patch on net-next tree removing ipv6_stub and enforcing 
> "depends on IPV6 || IPV6=n".
> 

FWIW; removing the ipv6_stub won't keep us from checking 
ipv6_mod_enabled() as ipv6.disable=1 can still be set at booting time 
and therefore nd_tbl will still be non-initialized because ndisc_init() 
and neigh_table_init() are never called.
