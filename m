Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB2610D
	for <bridge@lists.linux.dev>; Wed,  8 Nov 2023 20:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qw/yUedY"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so101076a12.0
        for <bridge@lists.linux.dev>; Wed, 08 Nov 2023 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699476335; x=1700081135; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=awG7Olb7pC1wEJXiajE9JdlOzQimXXsb3BWKke0OpeM=;
        b=Qw/yUedYAugNsI1WZuodt+35O+g/usAZmLvC8VRaFlKdSLDbXwbQx1P/o6ZpvcjtoQ
         WRvZyFbPqHva+/QzOoCkIkNGa3PD+6tMu2aag61myQhIxeEnL6YE0Vh9QI9huYuFmoHZ
         wWwAMS4UGp3t/jJBIgSrWMDxDCLdfkhxOikfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699476335; x=1700081135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awG7Olb7pC1wEJXiajE9JdlOzQimXXsb3BWKke0OpeM=;
        b=A36JSQU4bjv1V+Yc4B4hnPpTTgTg7SsCanIjCRkQDfUv1XfeHc7WHabtEkLIUYUQ/O
         TG7RPfX6WTNPwHfvgBcbNCiaH/M86vqkokToIECrLlPInWu8CA+/hDB4CFvYqrc3/r2t
         62SBSIqPtciGMZtteYolSXjqtfemRm8zXi7yTIfBlwu+iu217ZQ6FKpYesbG1iCAzKXU
         LjR/vMle5xjprzVM2y5P/qFnOKAK3sMyTBYfmuWaQfa+Jl0k2gVDOfNqr3cPGC2jY8FO
         zF37bPx4Q1Tne2ePJKG4ZTSXFRytD9B5ZxN6VgkOVjiXjeAiONEXSZp6ghW42Qq/Yx9w
         1Wmw==
X-Gm-Message-State: AOJu0Yx7IgcEnjRE5RfsSbKNCi4RXYewAGJur64h2HG+oXQ8hwP0ja+A
	U0S+B57ggEK4rnTAar7nMSOk53NtPzUWb32D5qoJLQ==
X-Google-Smtp-Source: AGHT+IEGZLuqsHP30qx/FE7jozsADcZTdjbl+mLfO+f1rnWiNR5SxyskY0/3QY4OFt4Wds+wVU5RCA==
X-Received: by 2002:a17:907:78c:b0:9e0:4910:166b with SMTP id xd12-20020a170907078c00b009e04910166bmr2507876ejb.52.1699476335564;
        Wed, 08 Nov 2023 12:45:35 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id w15-20020a170906b18f00b009ddcfbac9e7sm1566144ejy.84.2023.11.08.12.45.34
        for <bridge@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 12:45:35 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9a6190af24aso30154066b.0
        for <bridge@lists.linux.dev>; Wed, 08 Nov 2023 12:45:34 -0800 (PST)
X-Received: by 2002:a17:907:7247:b0:9b2:b152:b0f2 with SMTP id
 ds7-20020a170907724700b009b2b152b0f2mr2305890ejc.10.1699476334255; Wed, 08
 Nov 2023 12:45:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107-lists-lf-org-move-v1-1-b19b499a93fb@linuxfoundation.org>
In-Reply-To: <20231107-lists-lf-org-move-v1-1-b19b499a93fb@linuxfoundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Nov 2023 12:45:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg7TrK=kb9ZTEh4Cd+AOkY+ZBvvARsPy-xHyugU5eKMiQ@mail.gmail.com>
Message-ID: <CAHk-=wg7TrK=kb9ZTEh4Cd+AOkY+ZBvvARsPy-xHyugU5eKMiQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update lists.linuxfoundation.org migrated lists
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: virtualization@lists.linux.dev, acpica-devel@lists.linux.dev, 
	bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Nov 2023 at 12:00, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Normally, these would go through individual subsystems, but it's one of
> those one-off changes that don't really bubble up in a natural way. If
> you would like to pull this in through someone else's tree, please let
> me know to whom I should send this instead.

Oh, I still take patches, and this is fine and makes sense. Applied,

                  Linus
