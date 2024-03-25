Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045CC5D74C
	for <bridge@lists.linux-foundation.org>; Mon, 25 Mar 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371880; cv=none; b=lWpqKMCi2i52+cvdgeSbGSNB+rjUQdYUlC6M/YjLeKrKbZ6tH4R5UgOJKyGpmhdbceFX235De6oOZw7D0bWTsot0qQNCmYD1yV+37W5EuhX/MSKF7C/ry2yTAEEurAT5ZTAzYyEpXcFWP08K+g2ai9JzKyfVpfQf/y5Cmi8bLXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371880; c=relaxed/simple;
	bh=StXWaTBoyd9Tje91UaCId+bbkSFToXQL4cx0rhEEsfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e3Rvqf95BXumm/pnCnC1PIcfgzFKB0eyoK+0o3Nn5hNWax5/Gr23nyv262RP3hjmZmxM4Vk5TKG/9UnvQhcIRHTEvvPXC2brSaV32CTqGc/x+TpbcsbENO8kI5SE56zQuZy/Nbt5n+zY0uMPDoR0H8tmm3qsboeGZuBCNDepOco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mSEKPYR5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j5iaYn/S; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mSEKPYR5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j5iaYn/S; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mSEKPYR5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j5iaYn/S";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mSEKPYR5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j5iaYn/S"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 840DC40B85
	for <bridge@lists.linux-foundation.org>; Mon, 25 Mar 2024 13:04:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.4
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SWaYQOBWAGA9 for <bridge@lists.linux-foundation.org>;
 Mon, 25 Mar 2024 13:04:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=dkirjanov@suse.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B2C3040B7B
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=suse.de
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B2C3040B7B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mSEKPYR5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=j5iaYn/S;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=mSEKPYR5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=j5iaYn/S
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B2C3040B7B
	for <bridge@lists.linux-foundation.org>; Mon, 25 Mar 2024 13:04:37 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BEA05C6E0;
	Mon, 25 Mar 2024 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711371874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+zT1+tu64VVL4YrYUd/902NqQlxbkUXi0Ke76WYDHo=;
	b=mSEKPYR50oH/oPYE/X8NNkMY9E1I7WbJ88RKv6s33VYE1FaRjrl9CEeVMGe3Y8OIkVfhTc
	cT/9X0VQnY2CZYDOc6MwJmfPdh6rXSiY9U6L0laBdGrTGet4rqaZ9+9+4wnxDwofmd+70U
	u+c/w3vo5hOnGgOj06kQ+CWGdkem9SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711371874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+zT1+tu64VVL4YrYUd/902NqQlxbkUXi0Ke76WYDHo=;
	b=j5iaYn/Sqh9XpXnd3nZGL++fXaaY7xt2UkDdID1q7HwQTmgwhxISfVdxUnwiqmSGdcdpZl
	PCRx3PruUgiuH4AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711371874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+zT1+tu64VVL4YrYUd/902NqQlxbkUXi0Ke76WYDHo=;
	b=mSEKPYR50oH/oPYE/X8NNkMY9E1I7WbJ88RKv6s33VYE1FaRjrl9CEeVMGe3Y8OIkVfhTc
	cT/9X0VQnY2CZYDOc6MwJmfPdh6rXSiY9U6L0laBdGrTGet4rqaZ9+9+4wnxDwofmd+70U
	u+c/w3vo5hOnGgOj06kQ+CWGdkem9SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711371874;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q+zT1+tu64VVL4YrYUd/902NqQlxbkUXi0Ke76WYDHo=;
	b=j5iaYn/Sqh9XpXnd3nZGL++fXaaY7xt2UkDdID1q7HwQTmgwhxISfVdxUnwiqmSGdcdpZl
	PCRx3PruUgiuH4AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F5EE13A2E;
	Mon, 25 Mar 2024 13:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id W7qQO2F2AWbGGQAAn2gu4w
	(envelope-from <dkirjanov@suse.de>); Mon, 25 Mar 2024 13:04:33 +0000
Message-ID: <455b0c17-e977-4647-8dc5-6c56530f7945@suse.de>
Date: Mon, 25 Mar 2024 16:04:29 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3 2/2] bridge: vlan: add compressvlans
 manpage
Content-Language: en-US
To: Date Huang <tjjh89017@hotmail.com>, roopa@nvidia.com, razor@blackwall.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20240325054916.37470-1-tjjh89017@hotmail.com>
 <MAZP287MB0503FE53735FD12BD753C328E4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <MAZP287MB0503FE53735FD12BD753C328E4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mSEKPYR5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="j5iaYn/S"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[hotmail.com,nvidia.com,blackwall.org];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-0.00)[38.37%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[hotmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 6BEA05C6E0



On 3/25/24 08:49, Date Huang wrote:
> Add the missing 'compressvlans' to man page
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---
> v3: change man page desription

s/desription/description/


> 
>  man/man8/bridge.8 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index eeea4073..e614a221 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
>  \fB\-s\fR[\fItatistics\fR] |
>  \fB\-n\fR[\fIetns\fR] name |
>  \fB\-b\fR[\fIatch\fR] filename |
> +\fB\-com\fR[\fIpressvlans\fR] |
>  \fB\-c\fR[\fIolor\fR] |
>  \fB\-p\fR[\fIretty\fR] |
>  \fB\-j\fR[\fIson\fR] |
> @@ -345,6 +346,12 @@ Don't terminate bridge command on errors in batch mode.
>  If there were any errors during execution of the commands, the application
>  return code will be non zero.
>  
> +.TP
> +.BR "\-com", " \-compressvlans"
> +Show a compressed VLAN list of continuous VLAN IDs as ranges.
> +All VLANs in a range have identical configuration.
> +Default is off (show each VLAN separately).
> +
>  .TP
>  .BR \-c [ color ][ = { always | auto | never }
>  Configure color output. If parameter is omitted or
