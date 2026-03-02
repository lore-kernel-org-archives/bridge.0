Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC84C3112AD
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 17:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473502; cv=none; b=YSobSBFQVzz1DT1x2QFMUWAXEjA8KUF0H0/rr7jba9xKAOr5M5tH843BKDl8r/jUixq+MyhPOF+/GFIV6G2N3biZ2FvNg0aLMiTWFpp6fr41wOukbKNSlUVsW1aBjaMQAM10VjRzeDW2oUItIdIOu9WRFcXDEmDuYaNbLU7Of0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473502; c=relaxed/simple;
	bh=y+kypudA55pKUBSDZ4apE/asJo67KtYTUuqQvliSfmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qro4pLg24DaU3SFZR+4Yzn5saDDkHFoP/9K9gMCEzkikPbCQwmbY2PN/JvrFa+iqwKBEemS2WSRuflvC8XTeAXr3P2QIWs1j48xzQYO9v8KeC3tnUcEoSk03/AW6/1BZ1Dx0ANkUaAh2n+hPe6uhrpOYyW/gsXOXEUpiiVSsT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YeoI0cDN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j2x3pshb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YeoI0cDN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j2x3pshb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YeoI0cDN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j2x3pshb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YeoI0cDN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j2x3pshb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24C445BD85;
	Mon,  2 Mar 2026 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772473499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2txj2TGIj3mZxsW1nAGkxgF7hRYjoBSVrMi9ySIjLDI=;
	b=YeoI0cDNFcg4TTU4NRry682VwfTRUt3MSLcrpOlDFFoOXMpml1wBTNzJ2IaZOBD9zQkqRl
	RSIwmw2gCozbENgAJoN6dqz7QCesRII+jF/CBRh93fl8I4zMoUCvtywG2FZWAB8lhYB06L
	T8ZFq+igJGBZTaJ6jVTem82Sn++Kb0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772473499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2txj2TGIj3mZxsW1nAGkxgF7hRYjoBSVrMi9ySIjLDI=;
	b=j2x3pshbG09Bxv1sPBfqgchhH6gBwPRwpgwTYxOEIvvnrlVUZBKar0QfQmYJMnPKhSoD4V
	YDt46VJFJKoHQXDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772473499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2txj2TGIj3mZxsW1nAGkxgF7hRYjoBSVrMi9ySIjLDI=;
	b=YeoI0cDNFcg4TTU4NRry682VwfTRUt3MSLcrpOlDFFoOXMpml1wBTNzJ2IaZOBD9zQkqRl
	RSIwmw2gCozbENgAJoN6dqz7QCesRII+jF/CBRh93fl8I4zMoUCvtywG2FZWAB8lhYB06L
	T8ZFq+igJGBZTaJ6jVTem82Sn++Kb0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772473499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2txj2TGIj3mZxsW1nAGkxgF7hRYjoBSVrMi9ySIjLDI=;
	b=j2x3pshbG09Bxv1sPBfqgchhH6gBwPRwpgwTYxOEIvvnrlVUZBKar0QfQmYJMnPKhSoD4V
	YDt46VJFJKoHQXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DCBD3EA69;
	Mon,  2 Mar 2026 17:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7r36E5rMpWnTCAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 02 Mar 2026 17:44:58 +0000
Message-ID: <fd8370d6-b163-45ac-9e6c-24046f46539e@suse.de>
Date: Mon, 2 Mar 2026 18:44:34 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net v2] net: vxlan: fix nd_tbl NULL dereference when
 IPv6 is disabled
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
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260302163643.GA971179@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
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
X-Spam-Score: -2.80
X-Spam-Level: 

On 3/2/26 5:36 PM, Ido Schimmel wrote:
> On Mon, Mar 02, 2026 at 04:13:14PM +0100, Fernando Fernandez Mancera wrote:
>> On 3/2/26 3:43 PM, Sabrina Dubroca wrote:
>>> 2026-03-02, 15:08:47 +0100, Fernando Fernandez Mancera wrote:
>>>> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
>>>> initialized because inet6_init() exits before ndisc_init() is called
>>>> which initializes it. If an IPv6 packet is injected into the interface,
>>>> route_shortcircuit() is called and a NULL pointer dereference happens on
>>>> neigh_lookup().
>>>
>>> VXLAN can be built-in even when IPv6 is built as a module, and then
>>> ipv6_mod_enabled can't be used in VXLAN:
>>>
>>> ld: drivers/net/vxlan/vxlan_core.o: in function `route_shortcircuit':
>>> drivers/net/vxlan/vxlan_core.c:2133:(.text+0x116e0): undefined reference to `ipv6_mod_enabled'
>>>
>>>
>>> GENEVE has a Kconfig tweak to prevent this since 094be0927ff3
>>> ("geneve: fix build with modular IPV6"):
>>>
>>>       depends on IPV6 || !IPV6
>>>
>>> but VXLAN doesn't.
>>>
>>
>> Ugh, good catch. Thanks Sabrina.
>>
>>> But then I think we don't need to use ipv6_stub at all.
>>
>> If we enforce "depends on IPV6 || IPV6=n" on VXLAN we could get rid of
>> ipv6_stub completely and use direct calls instead.
> 
> I just noticed that this is already enforced for the bridge, so maybe
> you can just remove ipv6_stub in patch #1?
> 

Yes, after Sabrina mentioned it that was what I planned to do. But on 
VXLAN I want to avoid such patch for net tree as a fix. Instead I 
propose to use the __in6_dev_get() check as neigh_reduce() does. Later, 
do a follow-up patch on net-next tree removing ipv6_stub and enforcing 
"depends on IPV6 || IPV6=n".
