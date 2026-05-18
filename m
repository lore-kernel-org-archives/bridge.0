Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BEA3A6B61
	for <bridge@lists.linux.dev>; Mon, 18 May 2026 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779142256; cv=none; b=tYbgrB620JTVm5YlpyksGe4C87fOD5fSr1guffY7vpKBvcOghFuczMjb2EG/dQ/dF3vdfNCj9zZ3eA0IfyRsa4VWtP7ugidDKluHI8dhnV46J59MwhdYUXGB3Be6po8XC0/D8cTEKX6ZkfKFtoRAx7f30V2cuGDcETQb+p1FxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779142256; c=relaxed/simple;
	bh=E1F8Bv0JMO95AP1LroZfNQSpDjtd44MvQX58AKIq+XE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+81J/VX4w0HP5nvCP6utauy3udUT2sBCReQAy34PPfQcdHIZjt7+T65cK3+QdHaLsu3SUIghFHx2IBc9wlDb9q5zcuKL2cBCfTbbC4Lfsnkksktm7Rtaae7StTlUZwdBvObZK97I/vlOmiGIdx+1eveD+cGcyeCi14wHiDWqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Q84e1m9+; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="Q84e1m9+"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1357c851a48so2460596c88.1
        for <bridge@lists.linux.dev>; Mon, 18 May 2026 15:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779142254; x=1779747054; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6vAzFHT3rBOl6VAhV1BRH93ujw55GkVtyi8zlCynfk=;
        b=Q84e1m9+1SL8pKF1gyj40J2Avov5uBodLrvdWopiH2PNmn4LQNfnY7pbb610+yXzxY
         LSD0yg4Y7nGbHcWpyzVSRuYdoDoumfXNvmPdE6l5k0hSP9QuLyPCZrmGVURy5WTxJ8Dm
         bPhMRIsVGgv50WPeqD/exwMiw5iDLY4NMpzRkvGdeyBTw7rTgxIyIBpFtBZY307e5T/s
         RSKxXWMkOOZQVpgv39JW0GFnH/0fukzt5uyXiFqwNz9lQ2ZCMQ24rgs9XQhkaKAsCfYP
         xmKfFm6qdFh6jvj2UfcqrrAgCpeuMnE8yYFVzNMEQRahPtkWS8tGsLcqmO6ti0TGMIuY
         wtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779142254; x=1779747054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N6vAzFHT3rBOl6VAhV1BRH93ujw55GkVtyi8zlCynfk=;
        b=R3t4okcmIC0ow98nZ9sRV22fBL7gKdxEsN+QRm00FsXhTeTz6nwrjzeXK8NcerPNL3
         u3VIeyibze62JCV4CbmBFuz0fjcGwvOnhCoQEReXKYUdM7H4SU70oEXBWXrWZMR+OjY6
         04x2P7djFyOquuHhflbEE8aBuTT4Kesl+GiupAdtKBWesA61/yfBTx829WyMnQ/OOje7
         pGGA6/bO79+oik+ox/YZVOH9pmfleTEAtoTSb2VYzWNdeQ64fFpbWzWWrIw5x3TbBE5B
         sAUGIz/3WEepyn7P7oduF2d7q3nhNAwXRVEMd4/tjUOcVNFr3ZrFSAPpLDd9fwCO685X
         KWjw==
X-Forwarded-Encrypted: i=1; AFNElJ/VETNnBhROpio0DdLTKkSdFLgcTHK2IyDNuMBHnBUd5u2cQH+Jshl5isTLtLNC63PjmfzWSB0=@lists.linux.dev
X-Gm-Message-State: AOJu0YzObcZsOBi4lU/2itesgZYlYXWwCsgGQpZgpuAUQNL247UQeZ+a
	esLeKNiIxjaGwIBwo72UjX78QHaTGqrv1DHPJSd3jFobkUOPpKAJPMQoPKqkFxlo67o=
X-Gm-Gg: Acq92OELXLBwhuE60hIMihsDAZJCNE2VMCgBg/aZBy6KiWPMYCFiXHPROhGDWoXZie+
	PPkYx0RfYP9mbrilcOxwiMcDPDb4qs8KzpofObmnTHdJTOi8OkDGV2DNelF84lBaa36QxeHS2DZ
	tEmMcBIpxSwrX1EnCEa/kt40WUHflBMUxxra27oh8N7Any8eXDEfkWQ1oM7BQNRnIoG5flz1cuC
	IShmQgMohDHJ4XZ6gjQLTre39LDkRCXtKPU7zntgN0fpvCcK53COTN/O5RRN8w8ueE3ArErTWmJ
	/tKCMhjGZSKo4ZYJGkReBi4sfh54ePYnNDjhH1yRrUPZoxwym5XHqCOajwqA1EPcRVHBUm0tcop
	A3gUVyJkbUOrKAieQ2Im3h69eXRCO5F+nlqkPX3aNuACyrRh2SF5sJCKAhkL6Cq3vL+wOEIeLAd
	9vZeV5oXVnj/GRkOA8gOKGAekTj0HrmFM3bXFLXuh00SqUew==
X-Received: by 2002:a05:701b:2611:b0:135:1be3:a4ac with SMTP id a92af1059eb24-1351be3a71cmr3521981c88.23.1779142253940;
        Mon, 18 May 2026 15:10:53 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cf44668asm17681620c88.6.2026.05.18.15.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:10:53 -0700 (PDT)
Date: Mon, 18 May 2026 15:10:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andy Roulin <aroulin@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, bridge@lists.linux.dev,
 razor@blackwall.org, nikolay@nvidia.com, idosch@nvidia.com,
 petrm@nvidia.com, danieller@nvidia.com
Subject: Re: [PATCH iproute2-next] iplink: bridge: add stp_mode support
Message-ID: <20260518151050.5dc637fd@phoenix.local>
In-Reply-To: <20260518163647.1935156-1-aroulin@nvidia.com>
References: <20260518163647.1935156-1-aroulin@nvidia.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 09:36:47 -0700
Andy Roulin <aroulin@nvidia.com> wrote:

> +		} else if (strcmp(*argv, "stp_mode") == 0) {
> +			__u32 stp_mode;
> +
> +			NEXT_ARG();
> +			if (strcmp(*argv, "auto") == 0)
> +				stp_mode = BR_STP_MODE_AUTO;
> +			else if (strcmp(*argv, "user") == 0)
> +				stp_mode = BR_STP_MODE_USER;
> +			else if (strcmp(*argv, "kernel") == 0)
> +				stp_mode = BR_STP_MODE_KERNEL;
> +			else if (get_u32(&stp_mode, *argv, 0))
> +				invarg("invalid stp_mode", *argv);
> +
> +			addattr32(n, 1024, IFLA_BR_STP_MODE, stp_mode);

Not your fault but yet another case where matches() was bad idea
because if you pass "stp" it matches only stp_state.

Really should fix all of iproute2 to use a table approach and
not allow conflicting matches, but that is a lot of work,
and will break peoples scripts.
