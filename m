Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688640;
	b=zGs6V45oWX9Ib9MpcYpIezMk63oz0MxKec8pS4pVHjushpkBMiAz2bqz7V5XRfgExd2O
	 ZEVidQM9l4CqybCUEzyaijhNnaxBHT2ufzQq/ww4NbdQmKioNR+Ip2G+6l0OW7yaeps43
	 6MeXoEbnxe7zwBzE5ZlbJ2EmKTfboySNOZ/Hwj322+HBsPyP0WnrS9cPfvwm88oyyusxX
	 6tW3KZMKtNh76GUsSx00mwaFZBWboTGBIbkCXuuve8JsAC9jQdHoeeMhgg6bnYZEliemb
	 gU0tdIhyC6IZI6SULK/M3qdSHpGWe9ILSV6CKhigB3JXLgACV8/2tb5eyuHb6LEXTLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=2mKmxH++E4qor1mQxu0ggKku3S8sooA/5pfD3qywnr0=;
	b=FOpOcmsCdOz728Qs+Qx8+oJMnS8ZXapeai14lQ06MkqqFzvR3rD77UJulmM7+LZWBdq6
	 RZSVEIFVC7C+oafAUr3c8fxI23NhI4cm++gOraS0xMtCvT46Q3s4dBJokqIy4sffFbxFe
	 46ipd0sBAoofJj2T7sVwrLrTyHKxYrnDcf1WAxE5zJl+aL40QEkpZQq0LZsyY9a+WfM6S
	 s7XraRyoDMbS8ta1SdnhsRDJPBYLOUY9eYa9rcUI1Vr9k38xbQroVdSopv8v47y5WWz26
	 E8/67NKW2DdlcAKAR9cSoQ84hMXbtGWDKaVoWur4OEp5y6OO8yOBcFEGo1sB4HXlRaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k09+Oej5;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF3606A321
	for <bridge@lists.linux.dev>; Thu, 26 Nov 2026 10:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EAF3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k09+Oej5
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb67b3a18aso6701125e9.3
        for <bridge@lists.linux.dev>; Thu, 26 Nov 2026 02:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795688639; x=1796293439; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2mKmxH++E4qor1mQxu0ggKku3S8sooA/5pfD3qywnr0=;
        b=k09+Oej5rmu6WGirKgu3Fd7RHX4rG958s2ZOFRAFFTEiTPXOyGI5hLdiEHhL9rkNKp
         Nd4v/PeeSCRHnsRs+r5lNyYqU63RQuGlB11pOPd5hoMMy66EJFF+KuEcGBhcus2ftSFu
         owt1Ugn2qMCEQn+uaEB4pYo37WrpFRRL/2mZywsc77Y185fIbDhVLtlg8vw75/Gg6VWO
         zmEJASNkuL7HsQi8aAY76Gmvea31q6sRhaB2l6IPvyVJa3LfbOMCpU8+9h1WLYWH+8e3
         SVxOR5Z21p+cvEO70I5iqzcp9QEf+yj6jvlnreGnmrIqvsK5JULGOdeVXlRjqeN5ky4w
         E2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795688639; x=1796293439;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2mKmxH++E4qor1mQxu0ggKku3S8sooA/5pfD3qywnr0=;
        b=JuxEK2EQux98n4iTV3ttttJ9cWXyvfBelDD3tXz3g++8mYVCctjdsCjIG2QSijmqfV
         SQ9a8xw1tHqhNBhE1FccbrsGaO76i5RoHEK1Jx6JaSGDrSNnMSyBix3CBxrjbXWZjZRM
         /rBsCW2fRJldWuqyfO41KzxI5RJGg+wOiZwsTjt2g6lRDAumYFGJ45oCd41vWliOGlxz
         oXUrmvFU/yLUoHckjebRQ0WBcfO3f2eEPmyGC75LU/lWa7usUhz7l6cqi2K5EW36mTt+
         VsV7fCAssKAzPMavf6h6bcAVnKWq+F60GjQGAlBOdtSwuZiV671X+r94M5V/kbAKucxQ
         gaVQ==
X-Forwarded-Encrypted: i=1; AL+hErHNzbnrPSdZnGhfep8+95jdoKTAarX7SM3Tcn3UZmvGw3wx0rWeWppOvc6hp619IfEliDlOky4=@lists.linux.dev
X-Gm-Message-State: APuU4Z9TPQLk/pKFDKRxEhp6XUHbZMmNcxLF79YrltmYXEL0FC4sj/36
	96v9ps/antVxjnGyRCGodmxu7kn0IKk7AVDIxRTWbVHqYcWr/uUNZD6/
X-Gm-Gg: AZFdTZdjwWTdhikO+PBfSaLQmByBA7kMS8hlUhOJB29WedBH6QV2QYEVvSqMkfE85/3
	YLC7CRTSaDSsXp8LaiCyqlCtGFgYNZ7Tnbfv31YbbpXAxUZc1cFUrK22i7D6puR0keVvafXOLPi
	+9mriV6Z9LDL/lqlOeG/pH+eRr5QjZ95R+16cN9p75qbfxEkKd70xtcrCuxnKAu7ZO7UTjKRLPG
	P3NYwDW9jY0YnBOUJZanr5GIYqLaJe8GbHPZt/ZdtUa0UnJ8hUvKq9DwQnmwv9WwHRVSRmu1BwT
	sQVWTT34YCOZyDgG4U7YcM2IBwf9zJaCHzzmROqr2MK6yN8mGdiYlcUuu4J+CNhuFOOZWrrIXei
	bYN7i4ekO236e+HGTccdKhXX41E3eG1Dy0uLKVoVpo7xOsLHVprqX1tSlbXHxj1nn27eo5C01jO
	tKCQLB7b2m+2QVoAOCvLd85PZzzI4YfcFPAcN2CDKqQ2Ud2mgw/54UETNQw8yw042SF/0BYAHK2
	u2Xm1Fg0s6/sCYeq2fuubsRJMXLqgS+eJQ5z+DFP34JXMArA8ks6k0HX2fe18P26jTvA5p+tent
	adv5ykFrQApq9RtDSpHRTA==
X-Received: by 2002:a05:600c:217:b0:4bb:6a02:d42e with SMTP id 5b1f17b1804b1-4bb887f3fb8mr287364035e9.1.1795688638583;
        Thu, 26 Nov 2026 02:23:58 -0800 (PST)
Received: from skbuf ([2a02:2f04:d401:2601:c96e:548d:4428:1f72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm581525025e9.5.2026.11.26.02.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:23:57 -0800 (PST)
Date: Thu, 26 Nov 2026 12:23:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux.dev, 
	kernel@pengutronix.de
Subject: Re: [PATCH net-next 0/5] net: dsa: microchip: let the bridge decide
 about link-local frames
Message-ID: <awgHiY9mcEAD1C34@skbuf>
References: <20261126-ksz-stp-link-local-v1-0-39aed15f6271@pengutronix.de>
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Post: <mailto:bridge@lists.linux.dev>
List-Help: <mailto:bridge+help@lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
List-Owner: <mailto:bridge+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-ksz-stp-link-local-v1-0-39aed15f6271@pengutronix.de>

Hi Oleksij,

On Thu, Nov 26, 2026 at 09:07:47AM +0100, Oleksij Rempel wrote:
> Let the bridge decide about the link-local frames that the KSZ9477
> family and LAN937x trap to the CPU. These switches trap most link-local
> groups (01:80:C2:00:00:0X, for example STP BPDUs and LLDP), but the
> tagger marks the frames as forwarded in hardware. So the bridge never
> forwards them to the other ports of the switch, whatever group_fwd_mask
> says. An FDB or MDB entry for such a group can also make the switch
> forward these frames on its own.
> 
> The tagger now leaves these frames unmarked, and the driver keeps FDB
> and MDB entries for them out of the hardware. As the bridge then sends
> some link-local frames back out through the CPU port, the switch no
> longer learns addresses there; DSA adds the addresses that the bridge
> learns on its other ports, such as Wi-Fi, as static entries instead. An
> old FDB bug hits these entries often, so one patch fixes it; without the
> series it needs a static entry added over a learned one, so that patch
> goes to net-next with the series. The series goes to net-next as it
> changes how the bridge handles link-local frames.
> 
> To reproduce on a KSZ9893, with link partners on lan1 and lan2:
> 
>   ip link add br0 type bridge
>   ip link set lan1 master br0 up; ip link set lan2 master br0 up
>   ip link set br0 up
>   # 0x4000: forward 01:80:C2:00:00:0E
>   ip link set br0 type bridge group_fwd_mask 0x4000
>   # Send frames to 01:80:C2:00:00:0E into lan1. Without the series
>   # none reach lan2; with it, all do.
> 
> With STP off, the bridge now also forwards BPDUs between the ports of
> the switch. IEEE 802.1Q says a bridge filters frames to the reserved
> addresses, including the BPDU address 01:80:C2:00:00:00. The Linux
> bridge forwards BPDUs when STP is off, so that other bridges can still
> detect a loop through it; see commit a598f6aebea2 ("bridge: relay
> bridge multicast pkgs if !STP"). DSA switches whose tagger leaves
> trapped or link-local frames unmarked, such as mv88e6xxx and b53,
> already behave this way.
> 
> The switches driven by ksz8.c (KSZ8463, KSZ87xx, KSZ88x3, KSZ8864,
> KSZ8895, KSZ8995XA) keep their behaviour; KSZ8563 and KSZ8567 use the
> KSZ9477 code and are covered. The ksz8.c switches have one static MAC
> table. It holds the trap entries, the FDB and MDB entries and the local
> addresses of the bridge, and on the KSZ88x3 it has only 8 entries, so a
> change on the KSZ88x3 can run out of space. Of these switches I can test
> only a KSZ8873, so I left them unchanged. Their taggers still mark all
> frames as forwarded.
> 
> Tested on a KSZ9893.
> 
> ---
> Oleksij Rempel (5):
>       net: dsa: tag_ksz: do not mark trapped link-local frames as forwarded
>       net: dsa: microchip: ksz9477: do not keep the learned port in FDB entries
>       net: dsa: microchip: ksz9477: do not learn addresses on the CPU port
>       net: dsa: microchip: ksz9477: refuse FDB/MDB entries for trapped groups
>       net: dsa: microchip: ksz9477: report the trapped link-local groups
> 
>  drivers/net/dsa/microchip/ksz9477.c      | 81 +++++++++++++++++++++++++++++---
>  drivers/net/dsa/microchip/ksz_common.h   | 14 ++++++
>  drivers/net/dsa/microchip/lan937x_main.c | 16 ++++---
>  include/linux/dsa/ksz_common.h           |  8 ++++
>  net/dsa/tag_ksz.c                        | 42 ++++++++++++++++-
>  5 files changed, 145 insertions(+), 16 deletions(-)
> ---
> base-commit: c2621b518b38ed38e280e008aa33e6c2d302f8cc
> change-id: 20261125-ksz-stp-link-local-5c53396cc960
> 
> Best regards,
> -- 
> Oleksij Rempel <o.rempel@pengutronix.de>
> 

I didn't go into any sort of detail in these patches yet, but they
reminded me of this thread:
https://lore.kernel.org/netdev/20250127125426.3b7cdkb75o5dbcr5@skbuf/

IIRC Tim's problem there still wasn't resolved (he tried to use the
reserved multicast address tables). Does your series address his issue
too?
