Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793266163;
	b=tiuNNBV9LXzI2QulprQkUCNZxy9YMRdCoW2QfEVFICYwYrIwAI96Zphwl52dZphM+afq
	 74QsvB34OYaRBJamgbAjR71qoKqq/B7EC4pUA7QoZGueNjAkJc6b/PlINF6EIsmW8fdLi
	 ZHLr6S9ROVduu1aFessQ1DZKx/dwInRREmfa+5tweA0uGlRfq3bmAzsjNIVazIiA1P8dY
	 q9dKtRE/Xn+er+q1TikKg8530I0KPdlflSnz/oYej3iQxE0Cr0lebsz/gQY8cZ02p54HG
	 yLB2KNytDsuXCDSX+NRFUciwEcHWqk0DcQy4JEDzJ903YKctP+HPn+cDtYzhPMqGKsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266163;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=p2VFQ2YdVBVMlHGI8TnDXTz0Id7EK8o66F4F8DkIzGs=;
	b=dx2WUDqg3BCm+qGxX2AXq8PxagRNRaq1fpVmnJKxDGTdlZbOaayXuvaMGQ1UqJiPHtoC
	 VixheuHriGv9YA0gMkDnDjoSpAK2cXRMIhTnUN8kuQpuGwGN+KWgcqbvMGIxUHTAeFGah
	 cDYD19pFvgKNiLa+ealmTfunCiQGIffFGnDZjFlEj15kUY0O6Vd0IvVwx+tYeIR/c1sQ3
	 /i1pM4E3DWOLzxKP1jJYxbpqkpupq9ZtDlm8zUTko2sFCcuI6bizvbODLSUf2gfYU/hzH
	 BuHo1HH8hNicjLJK8yywF1wHyA7Vq1kNFx4tRX2mRGtT0qXrvLNt0LaEYRkjQSywcMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJYzmoBs;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAC2606A31E
	for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 09:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EAC2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJYzmoBs
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so976389a12.1
        for <bridge@lists.linux.dev>; Thu, 29 Oct 2026 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793266163; x=1793870963; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p2VFQ2YdVBVMlHGI8TnDXTz0Id7EK8o66F4F8DkIzGs=;
        b=WJYzmoBsz4KbWEvvuJtiVUlyrNzOdYTwCfpkczBP7w0lWS9CHxBKIpXUHhaS2wCNjo
         v1cb7PzdEa/VUvGdqkjKkMEpeV1QeC2HN82U+UnQ0vpq9HRPtX4xFASLGc7rY+WUK1Xe
         mOBfBKMQeH3EYEcw5KsJbXBp7oaaNdM1Yz+ibFbzS/Tz3eFeUuBGhzEWAUIXjpZpgI76
         pJJwTQ0Bvka4bNrXuvi4Hmc1e/YQJXtYu3VNHn8GhfHYFSGHTB9D4kTwQvDbwkVg31S5
         IU+KNJz0v0JYYNwvll6l3fvA6ZUsq3de5KDhX1rZ7NVYNf1S19xgN2D1hLzmR9uQjbcD
         eTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793266163; x=1793870963;
        h=mime-version:content-transfer-encoding:content-type:message-id
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p2VFQ2YdVBVMlHGI8TnDXTz0Id7EK8o66F4F8DkIzGs=;
        b=Q+PO/8e2dpjhcvdDUiuqvRei0vsU6dazS4/KjT9F6UPef+0Nxwajo2xemBsrpA/1vK
         hEqUDkZow38kqdklwa+EdbUwxiZK3U7BGFL6aqltmK+4QKxxo8rZKh3ijUivo8cmSNWL
         9NDwq9O//5CGZ6bc4G+5ekFgDjOCWYcHLN8/EDooh6thYP+DnTLDiPGXL8DVS/9aQenX
         xFWHFlD/F6BCQI5qKcqXbpvaYRMj4BvXgjRmPkoSC1sIbt1d14O4ZyNzulELBs5uMmYj
         7z475a/IGl0Dag8xduhLw17L48dx58l3QyLpzC93oh70kN/H9rjCpC/jRdDQCZ0mVvbX
         l2Yg==
X-Forwarded-Encrypted: i=1; AKwUvBwG7RiOQ2cNsRsin7KrJPt5yKJVeUskSgsD7JorLeqguN0TjzBG9vxjLxHiA2RefJhRLcnsf3w=@lists.linux.dev
X-Gm-Message-State: AFq9FYLbGwjrWUv7xrt/r5hksS8Ii9+On79mbYTXSwf0rwkCxaD8ER2H
	MlXbhEO7LUSkW4PRXQ8dICfv2zaZBimtBR/A/DOB4mM0gV8ppMtii0pv
X-Gm-Gg: AYBFou0j/JbP0SmVUsDlZ3BXtkFr0CklrCdhLVDPwpMfop4mZ429fBuEgbB8QCRNVJU
	jKs8oTckVweX2tv2lu4H1uhaB8djHC92DT/ZwMxI+9FJks1wEQahI/7T/0zaCN2Jh+KmkQT3TpX
	K+I5EskV2yEEKt6X81fx8L49J9C9BLIA+vNCTeDQ6Jky7/w9O9v2KCCDUEVDzcKFjNi/lApwM6c
	jk7/X8IQiDGLcv2PV/UZqAw1f/F5i+jedGwvrcbI7kp0AGlkCYJoUtu5A2FtImwoG7ec0LL1S9w
	5iJl84dLeyGsssIxIs55syPdbePqtqgjE8nluanV2pmP9wCdEIGxvXs33B8Jtm1YXCpv13KqbPt
	x+NO3csv4gVHHFGSLysuNmaYUB9FAMvXgvxm/iVMrz7fGCOey+l9sU0filhGxojZp7czVIzqCKU
	0YKh5+fdWZOPnYj8CDgFHy+BGWPOGMrOIxLhDeitivyvVf2TuCmCJvlsDdq9W+iYI3sRcW52WdX
	h90Ag0BpZtdHTUIB9Fl55G/0Z2Uf8M1cOH26xc7tzFEF3oj01RpLT0iNCJnFA==
X-Received: by 2002:a17:90b:3c04:b0:3a7:a6bc:9d58 with SMTP id 98e67ed59e1d1-3ae581e8bd3mr3092891a91.54.1793266162773;
        Thu, 29 Oct 2026 02:29:22 -0700 (PDT)
Received: from [192.168.45.62] ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8fb1ddsm3540149a91.5.2026.10.29.02.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 02:29:22 -0700 (PDT)
Date: Thu, 29 Oct 2026 02:29:22 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH net v2 0/2] bridge: cfm: correct CC receive monitoring transitions
In-Reply-To: <12c35123-2c08-4d3a-b08f-c646b1a7b982@blackwall.org>
References: <20261028164730.253238-1-pocj8ur4in@gmail.com>
 <12c35123-2c08-4d3a-b08f-c646b1a7b982@blackwall.org>
Message-ID: <179326615954.265212.11556019462202036381@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi Nik,

I am not currently using bridge CFM in production. I found these issues while=
 inspecting the code, and I agree that the fixes can target net-next when it =
opens.

Thanks,
Baek Kyu
