Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B083333C52F
	for <bridge@lists.linux.dev>; Wed,  4 Mar 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638137; cv=pass; b=p3T431k163WHoc/rC1uz9NXCbUB59CNZAqEkpk7tmgBHoNGVeFWM91JgL/UvxXQdgyk1opZUwfLKipjsB8evVcuYH6srMG9rWIn1lwsN0OMb7QyuCP0fvKtsxVTeN47pEHxFoMZ04Yw3PkSZE3XlUd+/8NWRxyNBHEdALWH9Eys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638137; c=relaxed/simple;
	bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ev3wq8Qslk2wGHZo9RJa1Ga3mLgiEgyMUOJoKkrjFtEkIiTOWBh8MLfEKgJic3R1lu7XsiNQsnwrN2tIXNyxkiajXMGMBmMkmLa2Iwgjm2lvLEnh6XwSbg8KeUIjr4JleDzo+OCb8NhSc2gLx/ZwVlNoOW8AZ4ZXd/4xlUXp/zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk6lWoyH; arc=pass smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk6lWoyH"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-65f8c8c3a4aso12898191a12.2
        for <bridge@lists.linux.dev>; Wed, 04 Mar 2026 07:28:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772638134; cv=none;
        d=google.com; s=arc-20240605;
        b=UKaIS8UlvJrKDn6GHmfWAuePfOnZArRf5kCYO5wU+J1pORUbtqy8gPNVSXfiV4COwV
         IRr32NRgrSfT6sNvVksPeUB/UTamK96sNtO7dpaDtIXXby4cq/uebk0i8T72nP9GJbMS
         QeCRHaP38zMXE6nt7A4Rg+sNGwH7naBUW2pENirW/KdJJSbaxHwDl5X0kL7vBkBFGtyC
         2N5nJyR6yu49QYpf6kYtzYOtqfdaevMd6R9VPzAuBMN6RNjCdouXjvpOeh5nGEFnWC77
         ae5wJNQibGXIA8FXBmlkqQjktFYTLHzO4GMr0OXM2OXfTS4I7h3QumbwHPAdTS+KDCPl
         OVog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        fh=d3iDYWR2GVAqMh8yOOmdD711eSgYICp7FTeS71MAO8s=;
        b=g8zvUXross4cTCQXgxQEcN1xSsmXO2TjVMmD6E4+fuFIJCGLZyY9YdYZ//wGQrBBIw
         /JIaRvAbU/NZe0I4cxJlJFKdd++/5yhukoYXAXzNctDW9nRKoK2z75MBL662wpDhYTQG
         oqtL0ifu0DvrRNVj3aWoplCV18PvlwtfFYxH32FWFykoKzdIsi8JDk0KLWwykyplHSJW
         mHHYZvBXhmv7eJOQF/28Zph9ANSYpo4kn9fRKO3HwVSveluJMyRggQBlHVF9K8mV39FE
         L6TLxSoTh3sRtmSzcQo8h4hy6x0gTBzAAO2hsvoDhSX9escldSxVRjs1WRjsbOmdoeZE
         Sk8g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772638134; x=1773242934; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        b=Wk6lWoyHsyys0BDroyPd/wfz6DBkfKrwGKQXzELBG6p1gtHCwKj+QNNkWJi1iR2AnV
         rUsDq/39Q07eRTKryMsILumOqlRrCbnyT3+eTTHlboeZ15iTm496kE/AOqCt+cNxtQff
         itZyn5WcM7tksASY73u1waUET8r+nYvA7L8ZkkraKLI6HBcCAhn8WIUsWPrWBtt2Hg0s
         0tV+15a5Fdvha2rEyfrgz8Ws+nguX6Hn00WCFDskrXrCIRfrWi6CCPcWGGEdAMNmIRLw
         QwxEJq3r1FGdXLf7WtaGVhNYO8WvFKTUuqqn7uOCwJDQpYlbQIqK7oKNIn25/NMvDFFE
         Q+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638134; x=1773242934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXgnaupTOR4EHZcvNrR8+mOFrNjx7Wk4vmJzGUnHFLY=;
        b=gIziMCR4sCToT3w6H69PvxEzOGR4rEdMhrHOv8sJvXgHrJpLPUSN/V2LK/054bJW1r
         LO2LKlpgC93dZRyhaFRbR6yVc/yKx2OUH4gm1c8+B2muQAjk0XdOnUz+hOD/gVdPMkN6
         1OomZqNaTwktVSgHVDmdoFYymrV+1Kut15TIiMwigIr0mNXFUfDAXZsZ5/j3olUK5PjJ
         ii/GKoEqjsHp6iEq4ssCm0qIf6LZGOl1wJUu3+GTXMcl9ULadxRADPbNRe2UiCFvKqMx
         eBz0mhKLj5ue1mPETUWd5uORf5GDYGKqFf1WPKBozHHvU1OqwoXRurTIM9SLWMuQg0gM
         qzPg==
X-Forwarded-Encrypted: i=1; AJvYcCWpOAvrfhT1lNSse/2mgSRDlynfmd22qPw5sKnUcWyuVhB5jfBjDuOJ/LA1g9Y1271OxVggd1k=@lists.linux.dev
X-Gm-Message-State: AOJu0YxDqmRauO5a6sLxbYT4DX8AJG9kK1lvw2MIg07idg9nVYJRrROh
	doJ6NbdMr6axKnIWeNsY5n/epWh1xrqoLLEw3RGfebFftDXOxv9Hxe7Q105TJ4SBNuMQmkhOiPT
	/ZPNeh+SaWgodjpS6KJrhov5L09dIEC8=
X-Gm-Gg: ATEYQzxT35ixjL4JBqoJTMs2EUETfjqzstMlkuyA4n9L1vJz0rUymX8AUAw6bnJCDtp
	EhL8x0rCfs7IuEzpyWicJonohuSYWzV+5xYtd6XlFb4ylMOC2DDJld+C5zgdk8XspRYBdOA7kMG
	uhhnYZIBSJ73tp43cZFkKl5e6rG20K7CgBdvuLj8jHzzwo9kRSnEqkSsQZrc8EEfaoMa2PYn94j
	wvUPSYWlFfSTDBWRZd7E53Z2607qEfiWdwE63l9lqBvl/a1NLswUgTag9YFsZER+a69Ib2PX1Wp
	j2gQecFvo5XqDmJct0f+so32j45H5WdfR8rPGzNa
X-Received: by 2002:a17:906:fe07:b0:b93:edc0:e2e8 with SMTP id
 a640c23a62f3a-b93f159439fmr173698266b.48.1772638133729; Wed, 04 Mar 2026
 07:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260225010853.15916-1-ericterminal@gmail.com>
 <20260225033840.33000-1-ericterminal@gmail.com> <aaRbWCeu-wNdWGzB@horms.kernel.org>
In-Reply-To: <aaRbWCeu-wNdWGzB@horms.kernel.org>
From: Eric_Terminal <ericterminal@gmail.com>
Date: Wed, 4 Mar 2026 23:28:42 +0800
X-Gm-Features: AaiRm53HxF5F9P5qVnAjApnPFfDhasNN9x-M6tagR-mOrAogX8sxQv-oIasNUdM
Message-ID: <CAKNPVZA2sFv7k=wyf5iBGyOUQcHkAdpVLVNjuqr+7XBXDKxNbg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] net: replace deprecated simple_strto* parsers with kstrto*
To: Simon Horman <horms@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	v9fs@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux.dev, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 11:29=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
> Hi,
>
> Thanks for your patches.
>
> I would like to understand what testing has been performed on these patch=
es.
>
> With the possible exception of patch 3/4, I feel that unless they
> are motivated as bug fixes, these changes are too complex to accept
> without testing. Although the opinions of the relevant maintainers
> may differ.
>
> And as for 3/4, I lean towards falling into the policy regarding
> clean-ups not being generally accepted unless it is part of other work.

Hi,

Thanks for the feedback. I've verified the series using virtme-ng and
a userspace mock harness (for the 9p tokenizing logic).

Regarding Patch 1: This is primarily a stability fix. I've tested the
error paths by forcing init failures on a non-Xen system; dmesg
confirms the new sentinel-based cleanup (NULL-ing intf/data and
checking INVALID_GRANT_REF) correctly prevents double-frees and Oops
during teardown.

Regarding the "complexity" in Patch 2: The strsep + kstrtouint
approach was chosen for strictness. I've verified it handles cases
like "1,,2" (empty tokens) and "1abc" (malformed input) correctly. The
latter is now rejected with -EINVAL, whereas simple_strto* would have
silently accepted partial values.

The same applies to Patches 3 and 4. The migration to kstrto* ensures
that sysfs/procfs interfaces now properly validate the entire input
string.

P.S. I used a translation tool for the message above, so please excuse
any awkward wording.

Thanks,
