Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB2F158DA3
	for <bridge@lists.linux.dev>; Sun,  1 Mar 2026 18:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772389693; cv=none; b=XwboFeKPcA9iE0CXb7snRzL56CofBnSMcTPtMK77a81DFEEt/wTaiQdthjRMR0PMy2vVVqJ8hN3T80CHPNWBHMn5f7As+NPV0W/UE3gUSZKTMTZcuixouJfrmYVMM1G5N/YG4PEHbv0CYejlonXzN72oG++PO2NvxuwUc5nUy4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772389693; c=relaxed/simple;
	bh=IwXDuxWm34IQqItaDBHATWEyByNCTdVciA9392jU+k4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lx7jgvY89mJvwZJJDREgy2yHMr9GiD8cfkQ0TC9QqOFxtpFt62cIHB3X4ZTJYcbo1KZcl2swcEJoMVEKNg2giKOT7lkizoGR6w0/6QQsQ6bdvwLqFW+j5IahK6U1k02pof03u+4zhoY+9ONW4xyZuqWZNMzzHV1S7JQdrMum9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f1NsDcSZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=95i0g/cP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f1NsDcSZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=95i0g/cP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f1NsDcSZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="95i0g/cP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f1NsDcSZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="95i0g/cP"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 586541FAD0;
	Sun,  1 Mar 2026 18:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772389685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzqMJaZ02R93CdXd/PqPoLIcnZG6tScdU23T7GvlCoo=;
	b=f1NsDcSZ0aIYzkcC2hslKQmfbzkAF7wLH1XpiU8xQrYmyMpwnam1buU4xXEQwfhXHPEEgh
	52svbkRz+hCIyR7bRGNO5Wrl/670sboDhG3eb2/pqWFCa01R/9KCOsdhdjjiu+dxvVCwD5
	jUP4PkLbgan6EMPXDbhR+k6kX47fx3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772389685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzqMJaZ02R93CdXd/PqPoLIcnZG6tScdU23T7GvlCoo=;
	b=95i0g/cP/ViDP35PQ0wjdxiGmjwDpONcc//koY3DMti9bkxfQpI3WNQD4reyQsCvzCj/hW
	+H+qw/uWvKPTRDCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f1NsDcSZ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="95i0g/cP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772389685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzqMJaZ02R93CdXd/PqPoLIcnZG6tScdU23T7GvlCoo=;
	b=f1NsDcSZ0aIYzkcC2hslKQmfbzkAF7wLH1XpiU8xQrYmyMpwnam1buU4xXEQwfhXHPEEgh
	52svbkRz+hCIyR7bRGNO5Wrl/670sboDhG3eb2/pqWFCa01R/9KCOsdhdjjiu+dxvVCwD5
	jUP4PkLbgan6EMPXDbhR+k6kX47fx3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772389685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IzqMJaZ02R93CdXd/PqPoLIcnZG6tScdU23T7GvlCoo=;
	b=95i0g/cP/ViDP35PQ0wjdxiGmjwDpONcc//koY3DMti9bkxfQpI3WNQD4reyQsCvzCj/hW
	+H+qw/uWvKPTRDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B39883EA69;
	Sun,  1 Mar 2026 18:28:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wEuQKDSFpGkLEQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 01 Mar 2026 18:28:04 +0000
Message-ID: <a09581fb-a3ad-4c0b-aa60-f16a75779756@suse.de>
Date: Sun, 1 Mar 2026 19:27:56 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fix nd_tbl NULL dereference when IPv6 is
 disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 roopa@cumulusnetworks.com, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, idosch@nvidia.com,
 razor@blackwall.org
References: <20260226234059.19402-1-fmancera@suse.de>
 <20260228123057.14050980@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260228123057.14050980@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 586541FAD0
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 2/28/26 9:30 PM, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 00:40:59 +0100 Fernando Fernandez Mancera wrote:
>> Fix this by adding a check before br_is_local_ip6() or neigh_lookup()
>> call. If ipv6_stub->nd_tbl is NULL, return immediately.
> 
> The problem should probably be fixed by replacing IS_ENABLED(IPV6) in
> the callers with ipv6_mod_enabled(), rather than randomly sprinkling
> null checks?
> 

I agree about using ipv6__mod_enabled() instead of the NULL check. 
Thanks for that recommendation, although I do not agree with replacing 
IS_ENABLED(IPV6) because here there is some ND message suppression that 
can be applied and at the end bridge should not be look to L3 unless 
necessary.

E.g NUD is still being suppressed even if ipv6 is disabled on boot.

What do you think? Thanks.

>> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
>> Closes: https://lore.kernel.org/netdev/CAHXs0ORzd62QOG-Fttqa2Cx_A_VFp=utE2H2VTX5nqfgs7LDxQ@mail.gmail.com/
> 
> I think we should also have a Reported-by: in this case?

Yep, sorry about that. Adding it on the next revision.
