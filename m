Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473C4291C1C
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768836; cv=none; b=Ng2YO1eIUDQpvxtQs2pmVfhbOqXIlZI3vZK0Wt3RwAvSZFCZFLhCyxpfk1/DGTmiQQatwpSdpGm6xvhk7ZizrxkpXXuy7iQXXcFhHFoWS8Z6pp7OFykKhz+T2xhovjixWlbkVacXxOrtaJWHpwSE2jPKkGln/wTbqKHYnal1fsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768836; c=relaxed/simple;
	bh=EK5fpWiETs7JEsGfpFKK7kvWd05z/Eb4sAehelWB+2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ekdSNT56F8kSHZZ13MhFTodDCUpygNS1RnW6JHaWDlbWtXeLHkKc05RppLH15SJggy130ThC8iKR9/aQ2bVL8FXwhhlwakJoTg/RJDgaM10dDsyWEc5tOXT+HUxe/E/fpjxf2g6LLwEB+jg2BZ8q3kFTpvPG/rx48+JgQyvQzbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=AqbrJg14; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="AqbrJg14"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E63B60A4F
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:40:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j35PSPYKM5e8 for <bridge@lists.linux-foundation.org>;
 Tue, 24 Jun 2025 12:40:33 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::52e; helo=mail-ed1-x52e.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 372FA608D9
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 372FA608D9
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=AqbrJg14
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 372FA608D9
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:40:32 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so643911a12.2
        for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 05:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750768831; x=1751373631; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4fdhcxdSvG4YFNR1XNWXsS8m7a9YlfMp0AeYu52oVQ=;
        b=AqbrJg147wdZKitGVfJMT9szSMlBiRt3KS2vZs4ChCzjsUxHHDybGZYy93P7wFCRQe
         cc+hp1talcJhNDTEVK3z3vJLs0qkly3YDqHUWUv0TAoE7e/qD/R9I6Cou4mI+htGHSav
         9lN3Xm1IW8wSwcFM6hN/dEWo73EaZdmLxCutHpqph6mIeFLcE/dd6dXiEYkoqOQivbD/
         7OwqBaSlG5am0EUwA0lKs9mL5Ck3rQ050yUKWBrRgsREtK4py1fwu2kHsm+r4ae8b2jA
         qJW7EBDM+qIHzOii0mbPFrRV2yTplbL3oINu/huBLryMYrsb8xgVRaL9Ey3ITgO0PeBW
         /nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750768831; x=1751373631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V4fdhcxdSvG4YFNR1XNWXsS8m7a9YlfMp0AeYu52oVQ=;
        b=d+OSjVmmZyuSr6Ghl8PIWmPaGc48GWEnjqAlL7kxWdU0TRaqlr4TIzJU8qi612OWKy
         16k5jjh8YMOsxMLBam9LUTIIfol5PdV3IZCnDJlr9gacjlR4b0Pggi0nxBgYkATCbHLz
         xnUqn620MbuGJmfioC8Wjgah+zp1+3SzSpzIQPkIpWLDYMePlJxwtpzVXM4fJd795LmY
         oFvYrmlmIL5Ga7UWmZPCSDzICJ8VDZI3St3nySlMQmO57RuIqgUjaD18KcpEAT/wHt38
         Px0sox+dfZoF4wmRzFzYrmbe/47Dryap3nmkiJ36Grz4G7tCTVJhoy2sTVCRST4267Sc
         85cg==
X-Forwarded-Encrypted: i=1; AJvYcCUIAgFGqR8WbWrBqYsUlI/ZsWQ0+kYYqQOEFaT+ly8cT4hc65h2bK5gL9v4EzmXYiZdxIQqimQ=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz252GrrCD6jmUxzRt3EmLn/z+k8G2oHe4gFUObcdNF/aojLjwY
	XGNrjMkQrjpdWuyJTDbXhkD6+J/8IyInz3nZfSWV6m24wEBPxqV44F+8y+yiyR0DlyI=
X-Gm-Gg: ASbGncuCJwEEPGOAF/ja79nu0U4cJ2XXBlRE1r2JXlM+AhLcVe+++D19CRFxm9vckwh
	Q1nEhhQnTFzf1UCYOa/nTOWS0Tyjufo931Z4XJBP7xsobwmDkjd7XafSH/99rqid/bUlGG4YbSe
	4WEtZev2eGKBkSytBrb+DWAUCyA676c7KlGO29nuOqhwI10tF0l79/1a7AfWDqbulz5/ufamxzd
	3L+fIisCuhFZSH/g5PC7Ylb7UbCKwV6ocL5MjhG3hRKDM/eSQ4cUjov6cq/Pa+UK7eSXyAISRZr
	AzOE3yhJ+n9f3+BiPXqVb9Wxq3pZTW6vCmO381us78xV0htJMuPd2s6WVpYQmy+9WVViBKmQ8DE
	2Oe3Tsu3gDy3uD+V1uJiiRYP1rqxq
X-Google-Smtp-Source: AGHT+IHdjgal16iaGYR282K8gG/RsOmIUsT0teCb0iFZSsjNBjWmjpdFG17QSTWFxT+Hy2d/ZCC8Kw==
X-Received: by 2002:a05:6402:520d:b0:60c:3a86:e117 with SMTP id 4fb4d7f45d1cf-60c3a86e394mr1304707a12.34.1750768830669;
        Tue, 24 Jun 2025 05:40:30 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f1b8e14sm969638a12.35.2025.06.24.05.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:40:30 -0700 (PDT)
Message-ID: <ef528c8e-9931-4746-b72f-31110fc3aebe@blackwall.org>
Date: Tue, 24 Jun 2025 15:40:29 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v5 2/3] bridge: dump mcast querier per vlan
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
 <20250623093316.1215970-3-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623093316.1215970-3-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 12:33, Fabian Pfitzner wrote:
> Dump the multicast querier state per vlan.
> This commit is almost identical to [1].
> 
> The querier state can be seen with:
> 
> bridge -d vlan global
> 
> The options for vlan filtering and vlan mcast snooping have to be enabled
> in order to see the output:
> 
> ip link set [dev] type bridge mcast_vlan_snooping 1 vlan_filtering 1
> 
> The querier state shows the following information for IPv4 and IPv6
> respectively:
> 
> 1) The ip address of the current querier in the network. This could be
>    ourselves or an external querier.
> 2) The port on which the querier was seen
> 3) Querier timeout in seconds
> 
> [1] https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=16aa4494d7fc6543e5e92beb2ce01648b79f8fa2
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>  bridge/vlan.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/bridge/vlan.c b/bridge/vlan.c
> index 14b8475d..3c240207 100644
> --- a/bridge/vlan.c
> +++ b/bridge/vlan.c
> @@ -852,6 +852,11 @@ static void print_vlan_global_opts(struct rtattr *a, int ifindex)
>  		print_uint(PRINT_ANY, "mcast_querier", "mcast_querier %u ",
>  			   rta_getattr_u8(vattr));
>  	}
> +	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE]) {
> +		struct rtattr *attr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE];
> +
> +		bridge_print_mcast_querier_state(attr);
> +	}
>  	if (vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]) {
>  		vattr = vtb[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION];
>  		print_uint(PRINT_ANY, "mcast_igmp_version",
> --
> 2.39.5
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

