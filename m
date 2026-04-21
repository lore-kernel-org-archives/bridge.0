Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37111B4F09
	for <bridge@lists.linux.dev>; Tue, 21 Apr 2026 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776773030; cv=none; b=q9kbFPwHCTjwF7ZYxkQvgKNdztaF/E/zyFCFyCX06ijWrJr9wTlnTYnwC2D2J9Kql/N19dMNpXkjW+d+Yn/htTO9H6xXBN66vYbZUAzC+d4kv7Mwo2QUQBuaCM2f1m9IOc0+y+lrPLN6ztb3DM1gkzMS1jfBtxaGyLOOLsA4aRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776773030; c=relaxed/simple;
	bh=D2pg4QST6SQsj9Y0AlZ3xwmYOqacTuU/qi+aAUKUt00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eY17CzBTu5+KunScXcP4QR2EOow4/6lewmfHPROhAXwdlcjSQSAfQ3MoU75Ia9J2ZiFsqvlLvRbNGAQKUwSnXuRc8qNgnsBVv5GJ+vOGmE5jARAjAA9EyvuBljUXQv4XjKn9F8iOyEhxL3tDUEtPP6Hg7QABDeXO1DZdYIJurOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-42f24cae679so270297fac.3
        for <bridge@lists.linux.dev>; Tue, 21 Apr 2026 05:03:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773028; x=1777377828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ji5jUeRQ9s6IdrcvkqpKzzaDEFKSxwSRUCTUPQc2w4=;
        b=CPmkxL/kILsER9ciXjA/3PTWHzgwaXKHss6DIXayrt6xd/3+VTQ45of95wHdM0AlAL
         OFX7JfJTgT6mIrIT7/FGoVmmCy2+HpAiIGCEL23O4quKc4jpUd7z594caJ7qA8yuhdA5
         9ZMlq+19oHdUK9YuEofa+hrNmNhtozkL7+yhR6/5Lf9dCwQ2PfRycvNqSWSF2cVIRDTJ
         h+R2bHSRE712cjglpdYMMExLx2iMcOXMWPaHqPN/c9EfsUnFjYjy9MAaPSqMU/OpxF0V
         rHib798bNOK1rr38mVxreMTg1D0GktvSYRrw6IuI61XpL3igw4/fYnplp0Nlx9pbYWWK
         +UYA==
X-Forwarded-Encrypted: i=1; AFNElJ/Qj5vV8XnfdBPFaaJtwZEInox4NaogY3FixPMFU8AEoNdHMRLugcGuPcaQpo3B87SdxJyoYxw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzVtFvU0z2nUvUbRN2JE4WFL+Nfbj2Zsolq/qelf+ui8h9Iaeki
	/iBKQsazMT3r9KsKEZX16MdTgE3JKtCc96DV8ZVGbFOf004FNqZ+x5bsCwjMTgF3ywQ=
X-Gm-Gg: AeBDievUrG9993XxrUN+xVllWack3ra6gHwOzEacmuaadMQYduU3dJbhbmG/zVUrJIu
	GBAk+2BANer7t2Y4b/MUlErQzdfyKMUDeAnfHLX+j52mWIWocxatAB5LlOaRiXGD40aRPl3TR3Q
	nSlOTVVhZeZHEm+vZ2x8QcdDw9jOeNAPVwbDGOwcKekxSnI1in37N4AVoTM5YAF4lClwP83OqmY
	7JujCnXv2jV/26mWNZsr3sbJwmTUPz1Ysgzb1RPIFFbWtC2Wg+21m21E3sNVHZpLsxSitD9zh8/
	hDcgbTa3C5AfRqHyg5avqaWwRkC3VbarX/Aemfd5evodtj48b/R7uh7/x+IguIgDHjYHTQnm3bo
	4CUhGRPbgw+sU1m+e84ZjKN1M0dZtq4eURQ8lSzbkszTID04uONg1c0F8/MtkxShzKkCKtbRxki
	as+6mrQH69o2NfEA9T0Bscbvx4GwIFTpiwdYenWLPE1p0oQyXQ0As9tS4ZtIYeXzNL7og2xYc=
X-Received: by 2002:a05:6870:c1d1:b0:3d9:2fe2:f5c8 with SMTP id 586e51a60fabf-42aded75b22mr10531101fac.32.1776773028218;
        Tue, 21 Apr 2026 05:03:48 -0700 (PDT)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b930afa63sm10847551fac.5.2026.04.21.05.03.47
        for <bridge@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 05:03:47 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6949831a7bcso294170eaf.1
        for <bridge@lists.linux.dev>; Tue, 21 Apr 2026 05:03:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8mZsYF72R35JTjvQiv8jaECd/fF4r+ld+BkwyHbxBRXPxakjaaqIXvZ+mQNlRpt50xVzkPEY4=@lists.linux.dev
X-Received: by 2002:a05:6102:f8b:b0:601:f386:9ed2 with SMTP id
 ada2fe7eead31-616f4d67f72mr7641295137.7.1776772665998; Tue, 21 Apr 2026
 04:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260421021943.1295109-1-kuba@kernel.org> <c7506c225ce22a71c03abc2673823cf84bbb5b0d.camel@infradead.org>
 <aedkZ5bizasuBPI8@gondor.apana.org.au>
In-Reply-To: <aedkZ5bizasuBPI8@gondor.apana.org.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Apr 2026 13:57:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU96F_42faeqNzDwaXks7mFrLrkPSJB_QTwxEn9HmVWpQ@mail.gmail.com>
X-Gm-Features: AQROBzAVi0Fh-UpifM1LaPGNEDH0ax6I6xOmcEB0yUP_KKo8UOyxGmDNb2nIMYw
Message-ID: <CAMuHMdU96F_42faeqNzDwaXks7mFrLrkPSJB_QTwxEn9HmVWpQ@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove unused ATM protocols and legacy
 ATM device drivers
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, 3chas3@gmail.com, razor@blackwall.org, idosch@nvidia.com, 
	jani.nikula@intel.com, mchehab+huawei@kernel.org, tytso@mit.edu, 
	ebiggers@kernel.org, johannes.berg@intel.com, jonathan.cameron@huawei.com, 
	kees@kernel.org, kuniyu@google.com, fourier.thomas@gmail.com, 
	andriy.shevchenko@intel.com, rdunlap@infradead.org, akpm@linux-foundation.org, 
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, bridge@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Herbert,

On Tue, 21 Apr 2026 at 13:51, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Apr 21, 2026 at 10:26:18AM +0100, David Woodhouse wrote:
> > I suspect they don't have a huge amount of interest in the Solos any
> > more, or the Geode-based SBC they sold with two of them on-board. But
> > OpenWrt does still support them, and I even have one here (although no
> > ADSL line to test it with). They were briefly popular as fully Linux-
> > supported ADSL routers.
>
> ADSL is history, it only ever made sense in rich countries where
> physical copper cables were pre-installed in homes.  While rich
> countries have moved to fibre, the rest of the world won't use
> ADSL either because there is no copper cable to begin with.  So
> it's actually cheaper to just lay a fibre cable for a new install.

I am afraid the move to fibre hasn't been completed yet.
ADSL (VDSL2?) is still being used.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
