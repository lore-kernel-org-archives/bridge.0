Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0D199EAD
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450703; cv=none; b=dXKwBnyba+MGEwo9jJrCfhOEl8E7KNl33GBcmnH+4YVtMNzsv+8/z9zchKo6ZBV2USf5lFN2QGau1Sz0G18Qcv3FIfhG0n92T+PJ671lrEW51uusd94St6zwfbw4I+ofST3s1sU95Nde2y5TWoQjGKobbqEiWeo64FaVvKIZdvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450703; c=relaxed/simple;
	bh=bdcBgnoNrwSBua7z5lr5qTjWw01ndENdX4WyAIM4u9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3sG0OGRP5cHA/ZYa2DzwpSos98hSriaL1sdTdZgnI6m0Ph/6vGy4QOYQcTZmK2d72wuj6Y7/VSeX7sANfUmE9o9rmz65+LEIz7HC/2kHkoi+ymcJbnop4EmtJJszVVjzn2KH3vNmhCGN2uLO7uQp5SF7mgrMLnPhU+Kr6Vacvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=waGS+jDI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=svhlnLeR; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FBQ3Ggik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=91kPCGgA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="waGS+jDI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="svhlnLeR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FBQ3Ggik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="91kPCGgA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 754035BD1E;
	Mon,  2 Mar 2026 11:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772450700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSzmkusbaMDPE3u9tJ8poO4+zjSt6klBfcovU0vZuEc=;
	b=waGS+jDIXDJIo0mShDWDoLfiYEXZK3qT4WOPY/6vcNVbUr89JDWx9fjj9rvX5UelFRfdlW
	mZKXzhO4lAJPQLXTQybPbzQdb/xNZWlnNouJH4cnBgoaArFqKwt8I4CgHxM/sCjQ2Awqhb
	2ZdUUOToYRBNza2W7XZvFlmuaTihJcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772450700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSzmkusbaMDPE3u9tJ8poO4+zjSt6klBfcovU0vZuEc=;
	b=svhlnLeReDHL+fDZFlY0889lmkZ/ZmUoIADBxwdixhZ8KlR0KWfqiS8ZIjAkhPMTbWwhIp
	PbrP466lPwvHXDCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772450698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSzmkusbaMDPE3u9tJ8poO4+zjSt6klBfcovU0vZuEc=;
	b=FBQ3Ggikx46ortHYWy0OwSOU/LgRP5qQprAAZcmv0sECEcGAzbgVI2zaUj5a3QCC0bwr2Q
	xijAT5FA6Io9Qr4jUaTdmGbZrGzEpp3RnPfVmC+Ssp9/4blwDiPTzndsg/ELRsl9Nhx5/b
	jEqxECZukC0oOXsbesKUei+JdXYrHZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772450698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rSzmkusbaMDPE3u9tJ8poO4+zjSt6klBfcovU0vZuEc=;
	b=91kPCGgAEawVSe1Cuo9U/BEXj5Uu250eLQ6/sb2jY+x9quW3bZOEqX2NGKuxxf2KKd9vMX
	CXcVEeT85sgtXJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB5B03EA69;
	Mon,  2 Mar 2026 11:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FaQ4MolzpWlZcgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 02 Mar 2026 11:24:57 +0000
Message-ID: <a0f4db13-9f18-4fcb-a6ab-73833cb0de3f@suse.de>
Date: Mon, 2 Mar 2026 12:24:37 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fix nd_tbl NULL dereference when IPv6 is
 disabled
To: Ido Schimmel <idosch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 bridge@lists.linux.dev, roopa@cumulusnetworks.com, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net,
 razor@blackwall.org
References: <20260226234059.19402-1-fmancera@suse.de>
 <20260228123057.14050980@kernel.org>
 <a09581fb-a3ad-4c0b-aa60-f16a75779756@suse.de>
 <20260302110838.GA875420@shredder>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260302110838.GA875420@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 3/2/26 12:08 PM, Ido Schimmel wrote:
> On Sun, Mar 01, 2026 at 07:27:56PM +0100, Fernando Fernandez Mancera wrote:
>> On 2/28/26 9:30 PM, Jakub Kicinski wrote:
>>> On Fri, 27 Feb 2026 00:40:59 +0100 Fernando Fernandez Mancera wrote:
>>>> Fix this by adding a check before br_is_local_ip6() or neigh_lookup()
>>>> call. If ipv6_stub->nd_tbl is NULL, return immediately.
>>>
>>> The problem should probably be fixed by replacing IS_ENABLED(IPV6) in
>>> the callers with ipv6_mod_enabled(), rather than randomly sprinkling
>>> null checks?
>>>
>>
>> I agree about using ipv6__mod_enabled() instead of the NULL check. Thanks
>> for that recommendation, although I do not agree with replacing
>> IS_ENABLED(IPV6) because here there is some ND message suppression that can
>> be applied and at the end bridge should not be look to L3 unless necessary.
>>
>> E.g NUD is still being suppressed even if ipv6 is disabled on boot.
>>
>> What do you think? Thanks.
> 
> I agree with Jakub and I believe it makes sense to not do any NS/NA
> suppression when IPv6 is disabled. You are right that some messages can
> be suppressed when IPv6 is disabled, but:
> 
> 1. We are planning to send a patch to prevent the unconditional
> suppression of ARP probes (DAD NS). Pending testing.
> 
> 2. There are some cases where GARP (unsolicited NA) should not be
> suppressed (see RFC 9161) and we plan to add a knob to control that.
> 
> 3. It's unlikely that anyone is actually relying on this behavior.
> Blamed commit is from 2017 and we only got a report now.
> 
> 4. Suppression that can be done without the IPv6 module being loaded can
> probably be achieved using stateless egress filters.

All right, given these arguments let's replace IS_ENABLED(IPV6) with 
ipv6_mod_enabled().

Thank you for all the feedback!
Fernando.
