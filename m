Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96D4E322A
	for <bridge@lists.linux.dev>; Thu, 15 Oct 2026 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062917; cv=pass; b=qgu/NYJSY/bm5ELHPL311MfmQWppwWrE6atKlayADIpSoDJwERJVyo0DVTiWcJjeiiEmhqDGYqM5egNH96xEtIPQweqf1M+XX+1sxjnchFXt6coqGiagm72weSCZSXCrgGQDEeU9KCEeBRWTBtuhjMlJVz76yldPHao5FPFtB84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062917; c=relaxed/simple;
	bh=I9oPJ3YGlwxlNX6cpMBiC5ATHr477eWduZeRhnHEaoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuYpBNor4JacAHGnqFjovOno3isvuwY4GWObIP0Uzf1DLpPg4GqIRLoZv3inrUvFUFNVPkReTe6ZjQbavpAQGRxLRzxV2DxmxGBEJXPmBn2XE2v6O2lqERRQ9lvYkyVNbgYqhkPogPlS3rACF5XwPPKDV8fWMUqKj0Ga2GguaiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=RR29XPCi; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="RR29XPCi"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b09e07e149so19764157b3.1
        for <bridge@lists.linux.dev>; Thu, 15 Oct 2026 04:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792062915; cv=none;
        d=google.com; s=arc-20260327;
        b=nkJqdGltySmD2Ry8z4IeL4epJWDw/5hkgll8MqtGu1VikkxBJtTk5XBMnKdgn6lV/n
         ooRsKOLGj0tiRQgWvQ24ysF1cB0uF7O3Dw1/BnHFKzSeg8ap+4QHYqAoBJutN7isolGw
         /Bm6v8X6/94j+/vz6UbCXniXF+kvgvtz37FKBsGsATOOQRC13KtOHkslH9UihaHGRfHz
         ap8jV/HzsilNaYHNr6n24I3as6/zT4oUCSnRxFk3exmx58xiye6Z8QCdmwwTpZNqvmWc
         rt/g/5zxHLEtH3AN51WEUjhwKnMuHAVkUWCQvOZtMdHBIGvizcfNJ2qIPzJR2+XVUS6Z
         h2Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=I9oPJ3YGlwxlNX6cpMBiC5ATHr477eWduZeRhnHEaoM=;
        fh=hI46kwKcry6/JVVSbxXch2yi7NGLLUZV3cfWHYRNyxc=;
        b=GtLky7w1mB1LfqmfYw0oKPV9S7GRhCW8m5RdQNEe/GrIh2EAblFE0dTEj3e4KHqJqh
         CTpsxKjiEJeGlBc0a3BPMYxHtexZF9mDCWRn54hQ5IVI6entf1CcE0Vyg/A+/BEkWxCT
         W+8dnR3JJEM+J8UUp832rdH7/TBSOKDkPE49CcMBCDYrC0jTk+1ZUCnaTLg5nMu/J0zi
         bNs0fEt1iW2nQLr15fF6HeM8iAUbbxT0XZvv80J/G/Iv/RsWdL7RAY/vRQpBLfxsJT/r
         SwdQM5rOVo8ZkPfWHnPrNC4xFlZw/pio9U/Hk05BE6pvJbUt+wKv+lEuuBvhu9D9IiYZ
         5vJQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1792062915; x=1792667715; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I9oPJ3YGlwxlNX6cpMBiC5ATHr477eWduZeRhnHEaoM=;
        b=RR29XPCiVU1Evi5CXuLdtpNlCTAyJ2WxTySz3jwsLJtgpkLSxbb7MiNL8GkQpdTpMg
         N90W/JYrCIh5aJkUU1PqEOx2ikBJz36ORCGMEA/1Xp77Y5HiDeJV64VuFjFIv73JYxsg
         zVjYe1BmH/XGVutTrfc+V0ivMGE8GjMkQSpHGlg6EfcRraRf0G/hW/tOOZ5Od8g9Dx4a
         lpAuXRPz8msMbXs5GmRDc9STOjMHWnIwMAbQiU+KQA7nHVmnPXMxtIcANmux2SG80F9Z
         zQcBY6o4gB7r9Ktv9/VVFBZSBwOm1oI9xF/UsCMts4mHEMPbMU3vKxAMAWIG1r1v5cAE
         PZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792062915; x=1792667715;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I9oPJ3YGlwxlNX6cpMBiC5ATHr477eWduZeRhnHEaoM=;
        b=HPwmvSMeYefGlXsfpvWFPYCj6T7Ug9+uW6M/tB8+sVkTQ17+78+8+7dyvIqoq53Cid
         Br/CKV9IhUg64hY4Rsp3Ssykr5h480yaP/pvBypl2iHI+GygamDrg9A0jjKh2alzOfn4
         ZYqBV6t2ESo2WqX9uGgoXsraloLA5Rf7tqPTrzyv00w2QQi7NP/HgTqvx9zaNp+A5v+K
         d18TtHVazdLRsfjdMiyeoHey1pU6x12PkmZJk7xKB7KLmsSlG6x9jt78I7oaok71x1N7
         FJ5fOdcUvzT1QP5zdkirTOS4WsDlMNggO73xJpj18L+5XudbeDaAYul1x2vOFbIakaOm
         Vx0g==
X-Forwarded-Encrypted: i=1; AKwUvByGgBa6VX2dkOnQ6e7DsMky+FWRqZQqzvJNQC50viCpge5dzDmK0iAL/QZYRTbfr7Zh6ObqjY0=@lists.linux.dev
X-Gm-Message-State: AFq9FYL2vEsbmucCnn/CfoLsHCYxvdrMjJ2QGd/aMeS+CqRFJ6le1Nso
	NSEQzBuC3//AhxwXzMeNxjE1iQInctD+aTDVaF+VyOfdDyYq7z21WkBwGZBbNVit8TJOCFeKKVo
	lL3ejB2KBzTaeaBQcBks5duRVAIb05w1vNfTepMt0
X-Gm-Gg: AYBFou0njg71aVZ25FrUK3tRDejR93h3uC0srrA98CXGBNsrHfHi5lTq4yTHaBoVNpB
	GPafqR21NjeQR3Iat6IU68yP1pKtm+YH7Z/33apYY6NVTQ7kGZZlY5tFravyGbxNIdbUCz+uzvS
	+vkYqvgQ0R9YzpdtusuT/RNJ686/o6XEQZaG/xYpTQoZUMW22WpJRnej1AAiY+V5DRDgBykX8tz
	rpEIwmRWqtypWZzXgOJ78+FzIZMxKYCXrU6w3c9FYIHWgHgLADm4lpQar71HmXNMBtAqU4y9CS3
	fCyUVguHsSu+wmd5Ya/5fKRbz2fUYrCIfKLTt991UEaGuWLd0j1GtsHi2qxoY/etYUWcyy5KYB1
	oVICHwvkA/KFHYlm4D+IgSc1cF9Ihs8MUlTq5UQttx/3lx7LApS8+BmX8Q9y4O538l/zYBtK7Uk
	oCi+2wYnN/6T5TBIPhSTibQe1N70ePk2d//ycxyZhPoI4v9tbpIZAxOMOsEveTC5r0m1xQL37LA
	d9UBPDXgueateCOQM7HpDLuDfOnx+aWcGemvSdFXMMy+DBMGCMh1Yoo1EccO2pVslofWb4v3clL
	j7hNLN+0tOUp6Q==
X-Received: by 2002:a05:690c:7012:b0:8b0:cf3d:7b35 with SMTP id
 00721157ae682-8b0cf3d7ea6mr10078397b3.15.1792062915195; Thu, 15 Oct 2026
 04:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261014235628.197976-1-julius@bairaktaris.de>
 <20261014235628.197976-2-julius@bairaktaris.de> <atCsGx2IRecQNK3r@chamomile> <atCs-U_AXIyvvpKd@chamomile>
In-Reply-To: <atCs-U_AXIyvvpKd@chamomile>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Thu, 15 Oct 2026 11:14:38 +0000
X-Gm-Features: AclHuK-GCm2OH3Jid7zEvImtoqSM3gq7UTcC3JLFEhmei75CLrzAl8zOZjCyOVw
Message-ID: <CAC1t37+g_5q2NbKmCkxhZthdHYabypyDZSoshwgAUVjbGm0NsQ@mail.gmail.com>
Subject: Re: [PATCH nf-next v7 1/2] netfilter: flowtable: tear down direct
 xmit flows when the fdb entry moves
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de, kadlec@netfilter.org, 
	phil@nwl.cc, horms@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, razor@blackwall.org, 
	idosch@nvidia.com, ericwouds@gmail.com, dqfext@gmail.com, 
	netdev@vger.kernel.org, coreteam@netfilter.org, 
	linux-kselftest@vger.kernel.org, bridge@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Pablo,

Thanks for looking over this.

I will incorporate your feedback and send out v8 + explanations for
the questions Saturday.

Julius
