Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE52AD03
	for <bridge@lists.linux.dev>; Mon,  2 Mar 2026 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464399; cv=none; b=EPnd3/pg75jYgGRAQ5a8A4DbB262TXvnVLbFXdQeQeaO16mq+Z7nHV4k5ZYhOFFtRFbiDncUUKq68aijcMBAh/NC/QqVCacP64jUr02Dr7EyfsWAGup6pNP5bMFimRuTxh2Uu7tiGD58r4bKKbQrx/2kXnZuTL0iyKNduqvvWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464399; c=relaxed/simple;
	bh=jPIKzapsf+6tYbFy4ijDS66rV7VUmSKYLAlzueHgTM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7hvQ35GHcDlDeMTKukXhC2EQOvL4bOQ2YKy+byvzjxQ3+G//utkm2scadZCW6gpMXadYXxaCiu2fd1+TycCy8tjSmBcSeHT5It2kRne+PDoZEQstfVqEG4YP5E8TlYVMT26R9fOx9Dd+E4jgQ+MRLuscgNs6X+yJFIpIpaoP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dn2dVTcC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2FWLvUop; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dn2dVTcC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2FWLvUop; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dn2dVTcC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FWLvUop";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dn2dVTcC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2FWLvUop"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D8A85BD76;
	Mon,  2 Mar 2026 15:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772464396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVXywuTp1pb+td6w2Nr7b2qvhMks5yV5Bn0JrpL0v5I=;
	b=Dn2dVTcCBJDtAsyAm/FsOSB4GCG+Zn1i++1XS8hqiJIviV9Y6f8za+uMpNIYSE0HnYm5s1
	O9p/FVNBC06qBvV5DfjMc1jwh5nNNLtyVyeadP85XaHd12NmgxJxvXvuomGr+QaMZU+ewz
	ycSr3sJObV3bbUlZOnmBIuNNR4d8/Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772464396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVXywuTp1pb+td6w2Nr7b2qvhMks5yV5Bn0JrpL0v5I=;
	b=2FWLvUopsdgVtLze2i2hRd16UvCbj30RSsBb5iw52lEDLC780qmx1okPhSykhkn2MNQ3jv
	+cIcm3jPj4tS3/Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772464396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVXywuTp1pb+td6w2Nr7b2qvhMks5yV5Bn0JrpL0v5I=;
	b=Dn2dVTcCBJDtAsyAm/FsOSB4GCG+Zn1i++1XS8hqiJIviV9Y6f8za+uMpNIYSE0HnYm5s1
	O9p/FVNBC06qBvV5DfjMc1jwh5nNNLtyVyeadP85XaHd12NmgxJxvXvuomGr+QaMZU+ewz
	ycSr3sJObV3bbUlZOnmBIuNNR4d8/Ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772464396;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVXywuTp1pb+td6w2Nr7b2qvhMks5yV5Bn0JrpL0v5I=;
	b=2FWLvUopsdgVtLze2i2hRd16UvCbj30RSsBb5iw52lEDLC780qmx1okPhSykhkn2MNQ3jv
	+cIcm3jPj4tS3/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A8533EA69;
	Mon,  2 Mar 2026 15:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /YrSIguppWktaQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 02 Mar 2026 15:13:15 +0000
Message-ID: <c2e08123-9338-4836-82e7-f47eb344f41f@suse.de>
Date: Mon, 2 Mar 2026 16:13:14 +0100
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net v2] net: vxlan: fix nd_tbl NULL dereference when
 IPv6 is disabled
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 roopa@cumulusnetworks.com, sdf@fomichev.me, petrm@nvidia.com,
 horms@kernel.org, idosch@nvidia.com, razor@blackwall.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch
References: <20260302140847.5941-1-fmancera@suse.de>
 <20260302140847.5941-2-fmancera@suse.de> <aaWiH5KBf-n1NxAR@krikkit>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <aaWiH5KBf-n1NxAR@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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

On 3/2/26 3:43 PM, Sabrina Dubroca wrote:
> 2026-03-02, 15:08:47 +0100, Fernando Fernandez Mancera wrote:
>> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
>> initialized because inet6_init() exits before ndisc_init() is called
>> which initializes it. If an IPv6 packet is injected into the interface,
>> route_shortcircuit() is called and a NULL pointer dereference happens on
>> neigh_lookup().
> 
> VXLAN can be built-in even when IPv6 is built as a module, and then
> ipv6_mod_enabled can't be used in VXLAN:
> 
> ld: drivers/net/vxlan/vxlan_core.o: in function `route_shortcircuit':
> drivers/net/vxlan/vxlan_core.c:2133:(.text+0x116e0): undefined reference to `ipv6_mod_enabled'
> 
> 
> GENEVE has a Kconfig tweak to prevent this since 094be0927ff3
> ("geneve: fix build with modular IPV6"):
> 
>      depends on IPV6 || !IPV6
> 
> but VXLAN doesn't.
>

Ugh, good catch. Thanks Sabrina.

> But then I think we don't need to use ipv6_stub at all.

If we enforce "depends on IPV6 || IPV6=n" on VXLAN we could get rid of 
ipv6_stub completely and use direct calls instead.

Would you agree to do as Ido mentioned on v1 and follow neigh_reduce() 
approach (__in6_dev_get()), then on net-next follow-up getting rid of 
ipv6_stub? I think this could be good.

Thanks,
Fernando.

