Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795758816;
	b=qW7Oavnoav6gRkU90o/UW7qN285gpXWid5HjwNTYOHvmnHcL3HJKENlYRYbXJnqZkyBH
	 1IHinpa22orIhkJDlqzTCBa+4ZLvVq/4tb38A+bj7SN6boUSuPluaz8p9qBqHcPNwy40F
	 wco1+4+5NOcrHDVBtnD0Bjw+iDGoSjCdV5dWgw0epiZ1OHTlpgEsWST85PA+OS6BHwleH
	 B7mPvRFrYodwKQ+tuvMWSVMEMWWBKxaMjnneDzHZo3OiWZpLFeKF+ounjgmBhJmfBq3DZ
	 w2jGnOO2HBj1N5kY6DXzvvFLerMdAdzYvlrzO0RiOziEaC5T5CH39as6UcknCOPm/Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758816;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=CJVSd+Wq9RvOR9XH+zDJ1/ZiXPZMqlEQ5ITdd3R2yzA=;
	b=VHTPGQML1xTJdpYyB2IoQAsDO8O3eZP4YtZaEo4zr+utZkQtLhdOi4Ssys/3yiLH8qUy
	 m+5LkvKdTT6l5eoxc+vXNYvbx7murBFWb+I/rNXGmVCJhvSsSe+cke3OhAHitr/DSkN0L
	 CD9TZJ+jzdpsGG6k9GBzehkeB+4BGsAI3UwON9eeh952aCxR75pU+NRjOgjzTNfVOS/KD
	 HP733mAnDRoRoJkWQFC0msfUW+4E0Gsg8TZAnuAKV9Jf8fXDYpnpUkhjiPuMTLenWYE4J
	 dehGK5kzMyX/BQYaOlNcldrHCHKPomvIyS2jnW1JZQDMF0ruEbPA5PTnJD6rS5VYEfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="NwhX0mN/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AB606A31E
	for <bridge@lists.linux.dev>; Fri, 27 Nov 2026 05:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F3AB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=NwhX0mN/
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::109])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 809272004B4;
	Fri, 27 Nov 2026 06:53:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795758812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJVSd+Wq9RvOR9XH+zDJ1/ZiXPZMqlEQ5ITdd3R2yzA=;
	b=NwhX0mN//G4M2a0VYDKm6nUkkDMwG4vBR6RV+efZVeauhRpBofw27nPjTHtysIVGBbB68U
	T1/ruXPRbRVTZUUM6qZnrttoRX/sLFaOGbBaibWRRw0/gHZxLCfLFlbG6zQvNHV2hPn+v4
	MeozIWKe+3c9KgwLHn5auheoG/U7AM8h+AGrtzOIJbNMV7MqYO6zdKK3sbEcgMvstZjdxY
	r80NQuTEunZSvVmnMK7ZWiCD8l5TjaN8rhAG7NUIaPzn5dFPpL0w5clYpY1iObkI/yFzTB
	bDM6em2UEiWWjRLQVnTLV/1PHPqDnNsYE6iIMGygPVXw5cI8pSUm6Oa+Ndkh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795758812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJVSd+Wq9RvOR9XH+zDJ1/ZiXPZMqlEQ5ITdd3R2yzA=;
	b=HdgxwwqaDqMVorUtQsozvqx1uq3VSG9Cm4HrocEafLbEy0MIMbbpxwoFUvhGmxwGa7dBwu
	vqweP2iUC9pSVz4kQeNQQ0LVx1+ByJqb5+o/2aJfCtET773GJ5WmiWgaKyE7bkWFqTnod8
	8brAm5W1xDCnKE/Sce5dvqu8P8xiwAF8MqccbOWqUCyRsgO4WZEcpDL+GI2248O5EcgaXc
	FcrM/UfT1BUSsVdObvEdn7P/NU7Bsd+nVUceUoWvVieS0sQY5l9gvNC9HfBOiGgM/33/Qh
	A/jRJJFtcrOiTAaJVpnZfCoYIxDLaE842Hqd5Zo+Qxyg4ppPnx9tae0R7DA22A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795758812; a=rsa-sha256;
	cv=none;
	b=FY/lZxDa02OO8cvJfh8T2ZeL82qhacfC2w4P0dwk8fFzdghocHtKg5W3dK/FBb+uW0Brdk
	TrhgMkvKjvxF9jz2qBy8UykWv+F2XDfXLqHFOlGan0oH/nzzm1X5D60E9LtnZkiCEaJf3K
	yDA4ckQnlRSBXaa+z5+rM/ZEoSQ4emCvg4ygcXG2HrIOCpxneqJmghM3RYfWuSRJpY1y/H
	kvXGmhHXqKNGSIiGVXTz4JMTyU2NjwAomU3lxrORAihz+104lrrmqj7Zr/Ek/NWMMkKJiG
	ySi3eTmTKz7i3JuVEHYg1QeHL4ASsphbM7C2X1PuadKwzfVmGsRWiwbbR6G4XQ==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id 6A29E1BF4EE; Fri, 27 Nov 2026 06:53:32 +0100 (CET)
Date: Fri, 27 Nov 2026 06:53:32 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	bridge@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/5] net: dsa: microchip: let the bridge decide
 about link-local frames
Message-ID: <awka3GOt3XIKURcX@pengutronix.de>
References: <20261126-ksz-stp-link-local-v1-0-39aed15f6271@pengutronix.de>
 <awgHiY9mcEAD1C34@skbuf>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awgHiY9mcEAD1C34@skbuf>

Hi Vladimir,

On Thu, Nov 26, 2026 at 12:23:55PM +0200, Vladimir Oltean wrote:
> I didn't go into any sort of detail in these patches yet, but they
> reminded me of this thread:
> https://lore.kernel.org/netdev/20250127125426.3b7cdkb75o5dbcr5@skbuf/
>
> IIRC Tim's problem there still wasn't resolved (he tried to use the
> reserved multicast address tables). Does your series address his issue
> too?

If I see it correctly, Tim had two concerns:
- the reserved multicast table assumed that the CPU is the last port,
- and 01:80:C2:00:00:0E was not forwarded.

The first one is handled by 96baf482ca1f ("net: dsa: microchip: Fix
reserved multicast address table programming")

This series addresses the second one. :0E is trapped to the CPU, the
tagger no longer sets offload_fwd_mark for it

Best Regards,
Oleksij
