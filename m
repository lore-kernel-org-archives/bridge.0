Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233DB28EA4D
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768824; cv=none; b=UA0iVWHDEVgnpbMueuHSHmz/CvVdd8KnoAk0nrTopv0LDeX1R0SMDeH+LkQaCD5RggMx5mR8oYGAhFH1vzNgiFsIVm07V+tCGDBJ87KGvEqP2OAcZOJEiytRytLfBohMnVwxobBkjqXuztuNf0E4gQfnfxUJsYN8dnYUQscup4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768824; c=relaxed/simple;
	bh=cHHzTIXhwtARmju9cK4L23TwilG152pnyyrZSkCEM8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ez7hn8vK8SQc7ZMV7+G+gYsPejVu5hcOKLtMMHNQYY+bZdt9TkUrCHKT9XTiTj0OTbJGQwTswjYZHPU7B3yZ9a6/71rL6l36yidi8EQvwPmPshXI5sgsCG4x+Jvttb7dYsHNzNyBOySRitM0VYMCErVUpeCkcCgNX4AbQfItacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QYttC6S6; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QYttC6S6"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9204407FA
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:40:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aa0RwI6iV86E for <bridge@lists.linux-foundation.org>;
 Tue, 24 Jun 2025 12:40:22 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com; envelope-from=razor@blackwall.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B209B4093F
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=blackwall.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B209B4093F
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=QYttC6S6
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B209B4093F
	for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 12:40:21 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-ad891bb0957so66269566b.3
        for <bridge@lists.linux-foundation.org>; Tue, 24 Jun 2025 05:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750768820; x=1751373620; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F80+FeXYZ4PIUD3SGso4Ms5tu5YoNmQsHY1ak8AKKkY=;
        b=QYttC6S6kvofGy4M/PsYEp1J2YS6ZzAtk8iVlqdUQc1LQj1RdMryPRK2ZpFu47aUtG
         CQs8cNldeu4djzrBMydC7RiaMeUGZAi5sAQMaGBq8biSyBjYd3h9pKks3kAB9hP42bEL
         qI9da41DmvyUt45jkE8mwKmxv13eiQ5S+d7Mw2zR1xN2EgG50HXJk8+wLDsUhAmd2Qzg
         4VSlJroEuj6VYQtYpXVqgC7UnY5xK10LAy5iWG896R3ZkzpLHIJ3RYI5SgM1Rukr9YC7
         bgdymllu9D//zkhxIOAG6Qd+qjHYsNMtbqGMG+XJOlKlEdhvJeo8DNtLc/YSEJEsQEOc
         Ndig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750768820; x=1751373620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F80+FeXYZ4PIUD3SGso4Ms5tu5YoNmQsHY1ak8AKKkY=;
        b=IcIW9GXcJxRnYNihRu159uWt+DWBnA8kb2/rJ9s1pChpkpzXAqcakMr3k4zLZOhWM+
         vlD5Gk4/B6cOl/GwfIU3J32wHjGvEu8U7tIBaPipNI/3hLQn3ZvOYbfGTsQKdCFCYcsC
         9PDsgEpSIyuCsQersEQ0pXrN7Gelhx/39vlQdf4/jzOsDqM7VFcydq+ve2nVZQxJ9jYQ
         Xp9hY2Hnh6CxkSvgduMZQDGXgqHYBZGjkhzrESgX8TvGeimm/NpuVc0i7Pyqz59wRfc+
         t90OVahRKBodGEIycQ+5mzQKlTI/MAm4VYNcmjHURlUsjczx5jaa//PJkz1YcdUY5D59
         LGCw==
X-Forwarded-Encrypted: i=1; AJvYcCVG49ZSxgLaL2epwhPf4GScd172PztI+XpIisYkleDMVHGzKrWJ3hCBgc3eDoONwI3yMkBjNgU=@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxR1u4064J8dhf4QuecNIoH4IC7IjXa+kHdNlH4ZicmN97rysrC
	vEqFg8czLMROfCJWAkXdHsktAdhdzGo2rFpRhZAQYMaqr0oImS+ZegrbrJVUsO0Tm5c=
X-Gm-Gg: ASbGncuBizYGEjf7n1zUKD/7Ypzyc2SOHNeCvkZPmmdRVJocyG1yDUU9KvO+3484wL8
	hbOSuTSR4M5uOKYGl6IpA5r55I1YcJHy53BjG53izJcHvwnQXfdKM3nnv7ejvA6OEBSwktRfq0f
	AZ6Fbp8aZM6kE/iu2KFkVKy3c+KRshJkVvNF3DLAkp6k+MQYo7zwmtyQ41yDUCPsqbihx2Uk6gP
	QfrqwqFUQgYDfJy1EKAqkgCMV/q5osAypE8vPAploTlSgOB91vNAwYMOxG738hkc1nicthf3tn4
	7M4YfgLdC22QFW/L9a88RC5mfusebteM6L1eBOacQgUTYTj5lXYy3RrtwO2LPYWRscF1d0E+Xg4
	/j/N01g4curF5NuLV2Q==
X-Google-Smtp-Source: AGHT+IFwA+WLgLYFy2O6tezSdaj6yB20MbU6CjR5LnHVa2z1IrkO2ka6zQXD/IvsDUtxSuEP3ohnhQ==
X-Received: by 2002:a17:907:788:b0:ae0:a61f:2957 with SMTP id a640c23a62f3a-ae0a61f2a29mr380167966b.48.1750768819290;
        Tue, 24 Jun 2025 05:40:19 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054082d0esm875142466b.79.2025.06.24.05.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:40:18 -0700 (PDT)
Message-ID: <7dd1f60b-2efe-4e85-8449-f2b5dff79b90@blackwall.org>
Date: Tue, 24 Jun 2025 15:40:17 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v5 1/3] bridge: move mcast querier dumping
 code into a shared function
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
 <20250623093316.1215970-2-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623093316.1215970-2-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 12:33, Fabian Pfitzner wrote:
> Put mcast querier dumping code into a shared function. This function
> will be called from the bridge utility in a later patch.
> 
> Adapt the code such that the vtb parameter is used
> instead of tb[IFLA_BR_MCAST_QUERIER_STATE].
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
> 
> I decided to not only move the code into a separate function, but also
> to adapt it to fit into the function. If I split it into a pure refactoring
> and an adapting commit, the former will not compile preventing git bisects.
> 
> ---
>  include/bridge.h   |  3 +++
>  ip/iplink_bridge.c | 59 +++-----------------------------------------
>  lib/bridge.c       | 61 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 67 insertions(+), 56 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


