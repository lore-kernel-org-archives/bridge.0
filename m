Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABA2D6E72
	for <bridge@lists.linux.dev>; Mon,  5 Oct 2026 04:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791175102; cv=none; b=kTwhVXykUy1SvtZ4sIpswxXyICmj3Ss0wycTDDkYU63jkNn6fHpsLh5NBBN5sMqp4fSpAkw91KPVNStxvN/AJ0PgQFIpCYSRxrABH2qmlz19cnI0/5TnsNt1w8+f0a/UQ1+5RgHufCOSKqzOf3jL0xsTeaxD19Rb0fKKKatQ5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791175102; c=relaxed/simple;
	bh=Pk1V3yBnj2gKrN3bv2Nfw53cNs1zJpDrB5f3qShOohY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPQ0EJuW0B4XVPudlz1BSuHLwSj72a58UNcKf6bkcr0HgJdkhDYhVNuEYmEh7GvVQr9UPlO5L5K0F5PJV8ZWHWVP9VOTL2SjAJA9PIK5xaBvvA669Ra4YDSIWhJYS+Vy6yoXVrc156Cc4tbvl8KnNzg24gpCkOodYOhTEuCsKaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePnBMXid; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePnBMXid"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-344447f9c3dso685006eec.0
        for <bridge@lists.linux.dev>; Sun, 04 Oct 2026 21:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791175100; x=1791779900; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pk1V3yBnj2gKrN3bv2Nfw53cNs1zJpDrB5f3qShOohY=;
        b=ePnBMXidLV378pPdKMOzu+enEB3Sbu9gixcmFlwbM4UHmy85m61Io7+j5OboSiqE2h
         Mx2fY2phJ4XBy36XbjfbF+aTjuiwAKjnsYronHctCG67O7X98RQgVY+SbbD0/qkKxw6M
         9icYFTy0QAJjb1TtP7lo8Iqgp6Tpg+MindU6OGRs2B2D5tp81eSysKExyR8odpp6Gstx
         XQc29ka5VbIln3LZfsatjoYthuER9pJRDcXBCjgwV2f9HyzeGb75j8HDVcwWmLWfg9WX
         gxZl1ZgAkvp059GEyvovK0oY6JULu3NbP2KsyFRSakjnDTNCM2jfLW28Zu0uHxT/UruJ
         n98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791175100; x=1791779900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pk1V3yBnj2gKrN3bv2Nfw53cNs1zJpDrB5f3qShOohY=;
        b=w/7+8rP9BMaIP/5svnlA+cZs/qE+Ae3fOv2poB+Z4dyvYJEXFx6ijq+w1VzXjP1Qv9
         mvL/dOWa1KLtT6DfYx5BtAu+7buyp1870nSKzd8gfEarNoqT/bXxxexYwh/Oev2drC0O
         +tHxZ30XtpsBLcd6e3EL5iCo0LEiaQbHVTugCsfNO3BnDQMhDcUIyn5PgCrWx25rxetZ
         afQ7vR0egsWjLwfP+bZoeiNvMWYX9zUcPE7P2sBVG3LWP1fHRmer4ZAUSAQ+j7keuS2a
         yIehm5ecpdrn8JAvnnawQtqPK5eUuSoMtdZlrpWwm2j+szeplAU7XNbi/32KrKfGxkxa
         LLPw==
X-Forwarded-Encrypted: i=1; AKwUvBye9h3ZgMS+aI4YbD6z/wtUAqtlK3NwrtordqPEkBzPDwgFvQLFjmIurDYDMpEXOcM0Ijwlf2k=@lists.linux.dev
X-Gm-Message-State: AFuF++k1FxACC2YZP6Z42A8GzfCDMmaT9gojm9lRBu2O/3tBF46pQJ3j
	whKFUjPD8Yo1sAjPZVxP9kuKlDeryRXvTZTT6M1PTL+Uh9bppsD77/j0
X-Gm-Gg: AYBFou1A0ZX6jPcyExXh9IpHBrT74fgqIkNLbePNcwSlEE76TG/lIYcF6YL1N4wBvLx
	6Xh88JyCyszaROURYZqP2P+f/lwxokqHsYjU6UaNalcHvtBZgSWWZkAAtuqYdcedQPoWr+Tj4jf
	QO1/HwzrageliL/ewd3PSLJdkGVfa2b17jkoWwHwAwieUjApcPe4SlwOxz+i1GK3fkiTtcujMoY
	A5XgH1z/bStI/bmKMuGrgyntbYhxdUD/c46CbC9Ny0Puu8DPB7CXEsNYYmH8Ga0nG6oDhXAFA/t
	1YKYxDrUDVHm56o8coiJxtTqyjkEpKZR5C7ubKgdeWfnRE0v0iy8FyO7kQGDpcxohxmScrR+sCZ
	p8uLTXcV8oy/SRJXcF9KAF1EwRdxm33GbfeZJ5WHy7lXpxaLhMLwOdOXrESu/G2/D3rDWY5W89v
	iDpSSMqJHs2i4cffooXJCqlI749JX4lzaID1y9UU6Dib+pVezgJoDqCZkof6AHtdZPPF7JMUpT5
	4MbTCI=
X-Received: by 2002:a05:7300:8284:b0:328:3cce:4b3b with SMTP id 5a478bee46e88-34f14f18c81mr10979887eec.4.1791175099687;
        Sun, 04 Oct 2026 21:38:19 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35126f01924sm9649984eec.0.2026.10.04.21.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 21:38:19 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bridge: cfm: notify userspace on CFM config changes
Date: Mon,  5 Oct 2026 04:38:12 +0000
Message-ID: <20261005043812.3106517-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179117378916.434549.16185635728868721491@kernel.org>
References: <179117378916.434549.16185635728868721491@kernel.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 05 Oct 2026 04:16:29 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: High]
> Is the skb that br_info_notify() allocates large enough for a message
> with only RTEXT_FILTER_CFM_CONFIG set?

Right, this is a real bug. br_get_link_af_size_filtered() never counts
the config attributes, so the notification only fit for small configs.
I reproduced it: with one MEP and about 32 peer MEPs every config change
hits the WARN_ON in br_info_notify() and the notification is lost.

v2 adds a patch before this one that counts the config attributes when
RTEXT_FILTER_CFM_CONFIG is set.

> [Severity: Medium]
> What does userspace receive when this request deletes the last MEP?

Right, it gets an RTM_NEWLINK with no IFLA_BRIDGE_CFM at all, which
can't be told apart from other bridge notifications. v2 sends an empty
IFLA_BRIDGE_CFM nest for a bridge with no MEPs, so that case is visible.

pw-bot: cr
